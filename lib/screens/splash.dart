import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

import 'package:sparky/models/model_preset.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_common.dart';
import 'package:sparky/manage/manage_device_info.dart';
import 'package:sparky/manage/manage_message.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparky/packets/packet_c2s_preset_comic_info.dart';
import 'package:sparky/packets/packet_c2s_preset_library_info.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  List<PacketC2SCommon> _packetList;
  bool _enableAppVersion = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    ManageCommon.rotatePortraitOnly();

    ModelPreset.fetch2(_presetFetchDone);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    //ManageCommon.rotatePortraitLandscape();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
  }

  void _presetFetchDone(bool result) {
    _enableAppVersion = result;

    if (true == result) {
      ManageMessage.generate();
      ManageMessage.streamController.stream.listen((data) {
        print("DataReceived1: " + data.toString());

        _packetList.removeAt(0);
        if (_packetList.length > 0) ManageMessage.add(_packetList[0]);

        if (data == e_packet_type.c2s_preset_library_info) navigationPage();
      }, onDone: () {
        print("Task Done1");
      }, onError: (error) {
        print("Some Error1");
      });

      PacketC2SPresetComicInfo packetC2SPresetComicInfo =
          new PacketC2SPresetComicInfo();
      packetC2SPresetComicInfo.generate();

      PacketC2SPresetLibraryInfo packetC2SPresetLibraryInfo =
          new PacketC2SPresetLibraryInfo();
      packetC2SPresetLibraryInfo.generate();

      if (null == _packetList) _packetList = new List<PacketC2SCommon>();
      _packetList.add(packetC2SPresetComicInfo);
      _packetList.add(packetC2SPresetLibraryInfo);

      ManageMessage.add(_packetList[0]);
    }
  }

  void navigationPage() {
    int switchPage = 0;
    switch (switchPage) {
      case 0:
        Navigator.of(context).pushReplacementNamed('/HomeScreen');
        break;

      case 1:
        Navigator.of(context).pushReplacementNamed('/PageDevTest');
        break;

      case 2:
        Navigator.of(context).pushReplacementNamed('/PageDevView');
        break;

      case 3:
        Navigator.of(context).pushReplacementNamed('/PageDevSignalR');
        break;
    }
  }

  void applicationQuit() {
    if (Platform.isAndroid) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      //SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    ManageDeviceInfo.firstInitialize(context);

    return Scaffold(
      body: _enableAppVersion == false
          ? BuildVersionConflictDialog()
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //Color(0xff7c94b6),
                    //                gradient: LinearGradient(
                    //                  colors: [new Color(0xff7c94e6), new Color(0xff5c94b1)],
                    //                  begin: Alignment.centerRight,
                    //                  end: Alignment.bottomLeft,
                    //                ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'images/sparky_logo.svg',
                      width: ManageDeviceInfo.resolutionWidth * 0.075,
                      height: ManageDeviceInfo.resolutionHeight * 0.035,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Text(
                      'Bring Joys to Everyone',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ManageDeviceInfo.resolutionHeight * 0.024),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: ManageDeviceInfo.resolutionHeight * 0.04),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: new LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: true,
                        lineHeight: 5.0,
                        animationDuration: 2500,
                        percent: 0.8,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.redAccent,
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}

class BuildVersionConflictDialog extends StatelessWidget {
  const BuildVersionConflictDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('About'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new BuildVersionText(),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Okay, got it!'),
        ),
      ],
    );
  }
}

class BuildVersionText extends StatelessWidget {
  const BuildVersionText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: new TextSpan(
        text: 'Current app is old version.\n\n',
        style: const TextStyle(color: Colors.black87),
        children: <TextSpan>[
          const TextSpan(text: 'Please Update!'),
          new TextSpan(
            text: ' ',
          ),
          const TextSpan(
            text: ' ',
          ),
          new TextSpan(
            text: '- by Sparky Toons',
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
