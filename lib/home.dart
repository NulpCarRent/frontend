import 'package:flutter/material.dart';
import 'package:frontend/requests_list.dart';
import 'api/api.dart';
import 'api/car.dart';
import 'widgets/car_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.api}) : super(key: key);

  final String title;
  final Api api;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Car> cars = [];
  Map filters = {"min": null, "max": null, "check_availability": false};
  bool checkAvailability = false;
  double _minPrice = 0;
  double _maxPrice = 1000000;

  Future<void> _updateList() async {
    Data data;
    List<Car> dataCars = [];
    //Get data from
    try {
      data = await widget.api.getTransports(max: _maxPrice.toInt(), min: _minPrice.toInt());
      dataCars = data.cars;
    } catch (e) {
      print("ERROR");
      print(e.toString());
    }

    if (checkAvailability) {
      dataCars = dataCars.where((car) => car.available).toList();
    }

    print(dataCars.toString());
    setState(() {
      this.cars = dataCars;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => new RequestsListPage(
                          api: widget.api,
                        ),
                      ));
                },
                child: Icon(
                  Icons.list,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                  padding: new EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Card(
                          child: Padding(
                        padding: new EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text("Price range"),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                showValueIndicator: ShowValueIndicator.always
                              ),
                              child: RangeSlider(
                                min: 0,
                                max: 1000000,
                                divisions: 20,
                                values: RangeValues(
                                    this._minPrice, this._maxPrice),
                                labels: RangeLabels('$_minPrice', '$_maxPrice'),
                                onChanged: (RangeValues value) {
                                  setState(() {
                                    _minPrice = value.start.roundToDouble();
                                    _maxPrice = value.end.roundToDouble();
                                  });
                                },
                              ),
                            ),
                            RaisedButton(
                              onPressed: () => _updateList(),
                              color: Colors.green,
                              child: Text("Filter"),
                            )
                          ],
                        ),
                      )),
                      Card(
                          child: Padding(
                        padding: new EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Row(
                              children: [
                                Checkbox(
                                  value: checkAvailability,
                                  onChanged: (bool value) {
                                    setState(() {
                                      checkAvailability = value;
                                    });
                                    _updateList();
                                  },
                                ),
                                Text("Only available cars")
                              ],
                            )
                          ],
                        ),
                      )),
                    ],
                  )),
            ),
            Expanded(
              flex: 8,
              child: CarList(cars, widget.api),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
