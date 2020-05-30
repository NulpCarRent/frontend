import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RangeValues _values = RangeValues(0.3, 0.7);

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
              child: Container(),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
