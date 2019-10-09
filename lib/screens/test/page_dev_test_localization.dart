
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sparky/manage/manage_device_info.dart';

class PageDevTestLocalization extends StatefulWidget {
  @override
  _PageDevTestLocalizationState createState() => new _PageDevTestLocalizationState();
}

class _PageDevTestLocalizationState extends State<PageDevTestLocalization> {
  // TODO Add build() method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Localization Test'),
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

              Navigator.of(context).pushReplacementNamed('/PageDevTestApply');

            },
          ),

          ListTile(
            title: Text('ko_kr'),
            onTap: (){

              ManageDeviceInfo.languageCode = 'ko';
              ManageDeviceInfo.localeCode = 'kr';

              Fluttertoast.showToast(
                  msg: "Select ko_kr",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.yellow,
                  fontSize: 16.0
              );


            },
          ),
          ListTile(
            title: Text('en_us'),
            onTap: (){

              ManageDeviceInfo.languageCode = 'en';
              ManageDeviceInfo.localeCode = 'us';

              Fluttertoast.showToast(
                  msg: "Select en_us",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.yellow,
                  fontSize: 16.0
              );

            },
          ),

        ], ).toList(), ); }

}