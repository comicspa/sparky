import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sparky/manage/manage_firebase_storage.dart';



// Coming soon page for multi-purpose


class AccountDeleteWidget extends StatefulWidget {
  const AccountDeleteWidget({
    Key key,
    this.titleText,
    }) : super(key: key);
  
  final String titleText;

  _AccountDeleteWidgetState createState() => _AccountDeleteWidgetState(this.titleText);
}


class _AccountDeleteWidgetState extends State<AccountDeleteWidget> with WidgetsBindingObserver{
  _AccountDeleteWidgetState(this.titleText);
  String titleText;

  TextEditingController _textInputController = TextEditingController();
  String _showText = "";

  @override
    void initState() {
      WidgetsBinding.instance.addObserver(this);
      super.initState();

      print('titleText : $titleText');
    }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
  }


  _onPressed() {
    setState(() {
      _showText = _textInputController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Text Input Value'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Submitted Text: $_showText"),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: _textInputController,
                  autocorrect: true,
                  decoration: InputDecoration(hintText: 'Enter a \'delete\' here'),
                ),
              ),
              RaisedButton(
                onPressed: _onPressed,
                child: Text('Submit'),
              )
            ],
          ),
        ));
  }
}

