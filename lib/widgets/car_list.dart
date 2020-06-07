import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/api/car.dart';
import "package:frontend/config/styles.dart";


class CarList extends StatelessWidget {
  List<Car> cars;

  CarList(this.cars);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: cars == null ? 0 : cars.length,
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
              //         worker: cars[index],
              //       ),
              //     ),
              //   ),
              //   child: 
                new Card(
                    child: new Column(
                  children: <Widget>[
                    //TODO Hardcoded image link
                    Image.network("https://media.wired.com/photos/5d09594a62bcb0c9752779d9/125:94/w_1994,h_1500,c_limit/Transpo_G70_TA-518126.jpg"),
                    Padding(
                      padding: Styles.cardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          // Vechile Name
                          Padding(
                            padding: Styles.cardHeadPadding,
                            child: Text(
                              cars[index].name,
                              style: Styles.primaryCardText,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text("TransportID: " +
                              cars[index].id.toString()),
                          Text("MineID: " + cars[index].price.toString()),
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
