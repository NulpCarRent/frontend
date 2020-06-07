import 'package:flutter/material.dart';
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
  RangeValues _values = RangeValues(0.3, 0.7);
  List<Car> cars = [];

  Future<void> _updateList() async {
    Data data;
    //Get data from
    try {
      data = await widget.api.getTransports();
      print(data.cars);
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      cars = data.cars;
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
                            RangeSlider(
                              min: 0,
                              max: 1,
                              values: _values,
                              onChanged: (RangeValues value) {},
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
                                Checkbox(value: true),
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
              child: CarList(cars),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
