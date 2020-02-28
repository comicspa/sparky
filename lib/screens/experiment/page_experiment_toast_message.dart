
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class PageExperimentToastMessage extends StatefulWidget {
  @override
  _PageExperimentToastMessageState createState() => new _PageExperimentToastMessageState();
}

class _PageExperimentToastMessageState extends State<PageExperimentToastMessage> {
  // TODO Add build() method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToastMessage Experiment'),
      ),
      body: _buildSuggestions(context),
    );
  }

  @override
  void dispose() {
    Fluttertoast.cancel();
    super.dispose();
  }

  Widget
  _buildSuggestions(BuildContext context)
  {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [

          ListTile(
            title: Text('Go to Next Page !!'),
            onTap: (){

              Navigator.of(context).pushReplacementNamed('/PageExperimentApply');

            },
          ),

          ListTile(
            title: Text('duration - short'),
            onTap: (){

              Fluttertoast.showToast(
                  msg: "This is Center Short Toast",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            },
          ),
          ListTile(
            title: Text('duration - long'),
            onTap: (){

              Fluttertoast.showToast(
                  msg: "This is Bottom long Toast",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );


            },
          ),
          ListTile(
            title: Text('text/background color'),
            onTap: (){

              Fluttertoast.showToast(
                  msg: "This is bottom long Toast",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.yellow,
                  fontSize: 16.0
              );


            },
          ),

          ListTile(
            title: Text('font size'),
            onTap: (){

              Fluttertoast.showToast(
                  msg: "This is Center Short Toast",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.yellow,
                  fontSize: 24.0
              );


            },
          ),

        ], ).toList(), ); }

}