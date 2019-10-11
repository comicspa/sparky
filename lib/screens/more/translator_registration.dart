import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.


// Coming soon page for multi-purpose

class TranslatorRegistrationWidget extends StatelessWidget {
  const TranslatorRegistrationWidget({
    Key key,
    this.titleText,
    }) : super(key: key);
  
  final String titleText;

  
  

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(CupertinoIcons.info),
              title: Text('This is the Translator registration page.'),
              subtitle: Text('Please follow the steps'),
              isThreeLine: true,
            ),
          ),
          
          
         
        ],
      ),
    );
  }
}


