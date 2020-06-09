import 'package:flutter/material.dart';
import 'package:frontend/api/car.dart';
import 'package:frontend/config/strings.dart';
import 'package:frontend/config/styles.dart';

class RentPage extends StatefulWidget {
  Car car;
  RentPage({Key key, this.car}) : super(key: key);

  @override
  _RentCarState createState() => _RentCarState();
}

class _RentCarState extends State<RentPage> {
  //Init key for working with form
  final _formKey = new GlobalKey<FormState>();

  String _rentDate;
  String _dueDate;
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

  // Perform login or signup
  void _validateAndSubmit() async {
    if (_validateAndSave()) {
      try {
        // userId = await _getUserId();
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
                  _showTotalInput()
                ],
              ),
            )
          ],
        ))));
  }

  Widget _showTotalInput() {
    return Padding(
      padding: Styles.inputFormPadding,
      child: new TextFormField(
        maxLines: 1,
        obscureText: false,
        autofocus: false,
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
            hintText: Strings.hintPhone,
            icon: new Icon(
              Icons.check,
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
        decoration: new InputDecoration(
            hintText: Strings.hintPhone,
            icon: new Icon(
              Icons.date_range,
              color: Colors.grey,
            )),
        onSaved: (value) => _rentDate = value.trim(),
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
        decoration: new InputDecoration(
            hintText: Strings.hintPhone,
            icon: new Icon(
              Icons.date_range,
              color: Colors.grey,
            )),
        onSaved: (value) => _dueDate = value.trim(),
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
          child: new Text(Strings.loginText, style: Styles.primaryText),
          onPressed: _validateAndSubmit,
        ));
  }
}
