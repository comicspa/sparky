import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

import 'package:sparky/models/model_preset.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_common.dart';
import 'package:sparky/manage/manage_device_info.dart';
import 'package:sparky/manage/manage_message.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sparky/packets/packet_c2s_sign_in.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_c2s_localization_info.dart';

class PageDevTestApply extends StatefulWidget {
  @override
  _PageDevTestApplyState createState() => new _PageDevTestApplyState();
}

class _PageDevTestApplyState extends State<PageDevTestApply>
    with WidgetsBindingObserver {

  @override
  void initState()
  {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    ManageCommon.rotatePortraitOnly();

    initialize();
  }

  void initialize() async
  {
    ManageMessage.generate();

    /*
    ManageMessage.streamController.stream.listen((data) {
      print("DataReceived1: " + data.toString());

      switch(data.type)
      {
        case e_packet_type.s2c_preset_comic_info:
          {
            PacketC2SPresetLibraryInfo packetC2SPresetLibraryInfo = new PacketC2SPresetLibraryInfo();
            packetC2SPresetLibraryInfo.generate();
            ManageMessage.add(packetC2SPresetLibraryInfo);

            print('[_PageDevTestApplyState::_onFetchDone] : e_packet_type.s2c_preset_comic_info');
          }
          break;

        case e_packet_type.s2c_preset_library_info:
          {
            print('[_PageDevTestApplyState::_onFetchDone] : e_packet_type.s2c_preset_library_info');
            print(ManageDeviceInfo.getLanguageLocaleCode());

            PacketC2SLocalizationInfo packetC2SLocalizationInfo = new PacketC2SLocalizationInfo();
            packetC2SLocalizationInfo.generate(
                ManageDeviceInfo.languageCode,ManageDeviceInfo.localeCode);
            ManageMessage.add(packetC2SLocalizationInfo);

          }
          break;

        case e_packet_type.s2c_localization_info:
          {
            navigationPage();

            print('[_PageDevTestApplyState::_onFetchDone] : e_packet_type.s2c_localization_info');
          }
          break;

        default:
          break;
      }


    }, onDone: () {
      print("_onFetchDone Done");
    }, onError: (error) {
      print("_onFetchDone Error");
    });
    */


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

  void navigationPage() {

      Navigator.of(context).pushReplacementNamed('/HomeScreen');
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
      body : Stack(
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


