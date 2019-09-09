import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.
import 'package:url_launcher/url_launcher.dart';

import 'common_widgets.dart';
import 'uploading_center.dart';

// Coming soon page for multi-purpose

class CreatorSubmenuScreen extends StatefulWidget {
  CreatorSubmenuScreen(this.titleText);
  final String titleText;

  @override
  _CreatorSubmenuScreenState createState() =>
      new _CreatorSubmenuScreenState(titleText);
}

class _CreatorSubmenuScreenState extends State<CreatorSubmenuScreen>
    with WidgetsBindingObserver {
  _CreatorSubmenuScreenState(this.titleText);
  String titleText;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(ManageDeviceInfo.resolutionHeight * 0.055),
        child: SafeArea(
          child: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 1,
            backgroundColor: Colors
                .white, //Color.fromRGBO(21, 24, 45, 1.0), //Color(0xff202a30), //Colors.black87, // Color(0xFF5986E1),
            title: Text(
              titleText,
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.import_contacts),
              title: Text(
                'Registration',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return BuildAlertDialog();
                  },
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.cloud_upload),
              title: Text(
                'Uploading Center',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push<Widget>(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UploadingCenterScreen('Uploading Center'),
                  ),
                );
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
