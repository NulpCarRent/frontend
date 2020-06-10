import 'package:flutter/material.dart';
import 'package:frontend/api/car.dart';
import 'package:frontend/api/request.dart';
import 'package:frontend/config/strings.dart';
import 'package:frontend/config/styles.dart';
import 'package:jiffy/jiffy.dart';

import 'api/api.dart';

class RentPage extends StatefulWidget {
  final Car car;
  final Api api;
  RentPage({Key key, this.car, this.api}) : super(key: key);

  @override
  _RentCarState createState() => _RentCarState();
}

class _RentCarState extends State<RentPage> {
  //Init key for working with form
  final _formKey = new GlobalKey<FormState>();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _dueDateController = TextEditingController();

  DateTime _rentDate = DateTime.now();
  DateTime _dueDate = DateTime.now();
  String _pledge;
  String _totalSum;

  // Check if form is valid
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<Null> _selectDueDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _dueDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != _dueDate)
      setState(() {
        _dueDate = picked;
        _dueDateController.text = picked.toIso8601String();
      });
  }

    Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _rentDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != _rentDate)
      setState(() {
        _rentDate = picked;
        _startDateController.text = picked.toIso8601String();
      });
  }

  
  Future<void> _postRequest() async {

    Request req = new Request();

    req.rentDate = Jiffy(_rentDate).format("yyyy-MM-dd");;
    req.dueDate = Jiffy(_dueDate).format("yyyy-MM-dd");
    req.car = widget.car.id;
    req.renter = 1;

    print("Request_2");
    try {
      int result = await widget.api.postRequest(req);
      print(result);
    } catch (e) {
      print(e.toString());
    }
  }

  // Perform login or signup
  void _validateAndSubmit() async {
    if (_validateAndSave()) {
      try {
        _postRequest();
      } catch (e) {
        print('Error: $e');
      }
    } else {

    }
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.detailsPageTitle),
        ),
        body: new Container(
            padding: new EdgeInsets.fromLTRB(70, 10, 70, 10),
            child: new Center(
                child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Form(
              key: _formKey,
              child: new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _showRentDateInput(),
                  _showDueDateInput(),
                  _showPledgeInput(),
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () => {
                      print("Request"),
                      _validateAndSubmit()
                    }
                    )
                ],
              ),
            )
          ],
        ))));
  }

  Widget _showPledgeInput() {
    return Padding(
      padding: Styles.inputFormPadding,
      child: new TextFormField(
        maxLines: 1,
        obscureText: false,
        autofocus: false,
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
            hintText: Strings.hintPledge,
            icon: new Icon(
              Icons.money_off,
              color: Colors.grey,
            )),
        onSaved: (value) => _totalSum = value.trim(),
      ),
    );
  }


  Widget _showRentDateInput() {
    return Padding(
      padding: Styles.inputFormPadding,
      child: new TextFormField(
        maxLines: 1,
        obscureText: false,
        autofocus: false,
        keyboardType: TextInputType.datetime,
        controller: this._startDateController,
        decoration: new InputDecoration(
            hintText: Strings.hintRentDate,
            icon: new Icon(
              Icons.date_range,
              color: Colors.grey,
            )),
        onTap: () => _selectStartDate(context)
      ),
    );
  }

    Widget _showDueDateInput() {
    return Padding(
      padding: Styles.inputFormPadding,
      child: new TextFormField(
        maxLines: 1,
        obscureText: false,
        autofocus: false,
        keyboardType: TextInputType.datetime,
        controller: this._dueDateController,
        decoration: new InputDecoration(
            hintText: Strings.hintDueDate,
            icon: new Icon(
              Icons.date_range,
              color: Colors.grey,
            )),
        onTap: () => _selectDueDate(context),
      ),
    );
  }

    Widget _showPrimaryButton() {
    return new Padding(
        padding: Styles.primaryButtonPadding,
        child: new MaterialButton(
          elevation: 5.0,
          minWidth: 200.0,
          height: 42.0,
          color: Colors.blue,
          child: new Text(Strings.rentText, style: Styles.primaryText),
          onPressed: _validateAndSubmit,
        ),
        );
  }
}
