import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/api/car.dart';
import "package:frontend/config/styles.dart";
import 'package:frontend/rent_page.dart';

class CarList extends StatelessWidget {
  final List<Car> cars;
  final Api api;

  CarList(this.cars, this.api);

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
              new Card(
                  child: new Column(
                children: <Widget>[
                  //TODO Hardcoded image link
                  Image.network(
                      "https://media.wired.com/photos/5d09594a62bcb0c9752779d9/125:94/w_1994,h_1500,c_limit/Transpo_G70_TA-518126.jpg"),
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
                        Text("🗓 Release year: " +
                            cars[index].releaseYear.toString()),
                        Text("🏷 Price: \$" + cars[index].price.toString()),
                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                                child: const Text('Rent'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => new RentPage(
                                          car: cars[index],
                                          api: api,
                                        ),
                                      ));
                                }),
                            FlatButton(
                              child: const Text('Remove'),
                              color: Colors.redAccent,
                              onPressed: null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              // )
            ],
          )));
        });
  }
}
