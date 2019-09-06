import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.

import 'package:sparky/screens/library.dart';
import 'package:sparky/screens/more.dart';
import 'package:sparky/screens/creator.dart';
import 'package:sparky/screens/testhome.dart';
import 'package:sparky/screens/trend.dart';
import 'package:sparky/screens/sign_in.dart';
import 'package:sparky/screens/notification.dart';

// Coming soon page for multi-purpose

class ComingSoonScreen extends StatefulWidget {
  @override
  _ComingSoonScreenState createState() => new _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> with WidgetsBindingObserver
{
//  final String titleText;
//  _ComingSoonScreenState(this.titleText);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)
  {
    print('state = $state');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ManageDeviceInfo.resolutionHeight * 0.055),
        child: SafeArea(
          child: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 1,
            backgroundColor: Colors.white, //Color.fromRGBO(21, 24, 45, 1.0), //Color(0xff202a30), //Colors.black87, // Color(0xFF5986E1),
            title: Text('Coming Soon',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(
                Icons.info_outline,
                size: ManageDeviceInfo.resolutionHeight * 0.035,
              ),
            ),

            Text(
              'Coming soon~!',
              style: TextStyle(
                fontSize: ManageDeviceInfo.resolutionHeight * 0.05,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: ManageDeviceInfo.resolutionHeight * 0.1,),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.redAccent,
              child: Text('Back to Main Page'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
