import 'package:flutter/material.dart';
import 'api/api.dart';
import 'api/request.dart';
import 'config/styles.dart';

class RequestsListPage extends StatefulWidget {
  RequestsListPage({Key key, this.api}) : super(key: key);
  final Api api;

  @override
  _RequestsListPageState createState() => _RequestsListPageState();
}

class _RequestsListPageState extends State<RequestsListPage> {
  List<Request> requests = [];

  Future<void> _updateList() async {
    RequestData data;
    //Get data from
    try {
      data = await widget.api.getRequests();
      print(data.requests);
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      requests = data.requests;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateList();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: new ListView.builder(
        itemCount: requests == null ? 0 : requests.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
              child: new Center(
                  child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Card(
                  child: new Column(
                children: <Widget>[
                  Padding(
                    padding: Styles.cardPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text("🗓 Release year: " +
                            requests[index].rentDate.toString()),
                        Text("🗓 Price: \$" + requests[index].dueDate.toString()),
                
                      ],
                    ),
                  ),
                ],
              )),
              // )
            ],
          )));
        })
    );
  }
}