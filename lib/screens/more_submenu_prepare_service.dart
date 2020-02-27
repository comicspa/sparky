import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.


// prepare service page for multi-purpose

class SubMenuPrepareServiceScreen extends StatefulWidget {
  SubMenuPrepareServiceScreen(this.titleText);
  final String titleText;


  @override
  _SubMenuPrepareScreenState createState() => new _SubMenuPrepareScreenState(titleText);
}

class _SubMenuPrepareScreenState extends State<SubMenuPrepareServiceScreen>  with WidgetsBindingObserver{
  _SubMenuPrepareScreenState(this.titleText);
  String titleText;

  @override
  void initState()
  {
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
            title: Text(titleText,
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
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
                size: 35,
              ),
            ),
            Text(
              'Prepare Service~!',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.redAccent,
              child: Text('Back to Main Page'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
