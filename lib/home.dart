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
  double _min_price = 0;
  double _max_price = 100000;

  Future<void> _updateList() async {
    Data data;
    List<Car> dataCars = [];
    //Get data from
    try {
      data = await widget.api.getTransports();
      dataCars = data.cars;
    } catch (e) {
      print(e.toString());
    }

    if (checkAvailability) {
      dataCars = dataCars.where((car) => (car.renter == null)).toList();
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
                                values: RangeValues(
                                    this._min_price, this._max_price),
                                labels: RangeLabels('$_min_price', '$_max_price'),
                                onChanged: (RangeValues value) {
                                  setState(() {
                                    _min_price = value.start.roundToDouble();
                                    _max_price = value.end.roundToDouble();
                                  });
                                },
                              ),
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
