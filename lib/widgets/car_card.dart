import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CarCard extends StatelessWidget {
  const CarCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: workers == null ? 0 : workers.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
              child: new Center(
                  child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // new GestureDetector(
              //   onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => new DetailsPage(
              //         worker: workers[index],
              //       ),
              //     ),
              //   ),
              //   child: 
                new Card(
                    child: new Column(
                  children: <Widget>[
                    Image.network(workers[index].imageLink),
                    Padding(
                      padding: Styles.cardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          // Vechile Name
                          Padding(
                            padding: Styles.cardHeadPadding,
                            child: Text(
                              workers[index].transportName,
                              style: Styles.primaryCardText,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text("TransportID: " +
                              workers[index].transportId.toString()),
                          Text("MineID: " + workers[index].mineId.toString()),
                        ],
                      ),
                    )
                  ],
                )),
              // )
            ],
          )));
        });
  }
}
