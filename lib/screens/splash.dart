import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:sparky/manage/manage_firebase_storage.dart';
import 'package:sparky/manage/manage_firebase_cloud_firestore.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_c2s_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_common.dart';
import 'package:sparky/manage/manage_device_info.dart';
import 'package:sparky/manage/manage_message.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparky/packets/packet_c2s_preset_comic_info.dart';
import 'package:sparky/packets/packet_c2s_preset_library_info.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sparky/packets/packet_c2s_sign_in.dart';
import 'package:sparky/packets/packet_c2s_preset.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_c2s_localization_info.dart';
import 'package:sparky/packets/packet_c2s_featured_comic_info.dart';
import 'package:sparky/packets/packet_c2s_recommended_comic_info.dart';
import 'package:sparky/packets/packet_c2s_real_time_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_new_comic_info.dart';
import 'package:sparky/packets/packet_c2s_today_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_weekly_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_continue_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_owned_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_recent_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_view_list_comic_info.dart';
import 'package:sparky/manage/manage_shared_preference.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {

  bool _enableAppVersion = true;
  String _uId;
  int _socialProviderType = 0;
  Stream<PacketS2CCommon> _broadcastStream;


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
    if(kDebugMode)
    {
      print('Debug Mode');
      //ModelPreset.developerMode = true;
    }
    else
    {
      print('Release Mode');
    }

    //ManageFirebaseDatabase.setModelInfo('model_weekly_trend_comic_info','1566811403000','000004');
    //ManageFirebaseDatabase.deleteModelComicDetailInfoLike();
    //ManageFirebaseDatabase.deleteModelComicDetailInfoSubscribe();
    //ManageFireBaseCloudFireStore.getData();
    //ManageFireBaseCloudFireStore.deleteData();

     _uId = await ManageSharedPreference.getString('uId');
     _socialProviderType = await ManageSharedPreference.getInt('social_provider_type');
     print('uId : $_uId , social_provider_type : $_socialProviderType');

    bool result = true;
    _enableAppVersion = result;

    ManageMessage.generate();
    _broadcastStream = ManageMessage.streamController.stream;
    _broadcastStream.listen((data)
    {
      print("DataReceived1: " + data.type.toString());

      switch (data.type)
      {
        case e_packet_type.s2c_preset:
        {
          print('----- e_packet_type.s2c_preset ----- ');

          if(true == ModelPreset.developerMode)
          {
            Navigator.of(context).pushReplacementNamed('/PageDevTestMenu');
          }
          else
            {
              if(null != _uId && _uId.length > 0)
              {
                if(false == ModelUserInfo.getInstance().signedIn)
                {

                  ModelUserInfo.getInstance().uId = _uId;
                  ModelUserInfo.getInstance().socialProviderType = e_social_provider_type.values[_socialProviderType];

                  print('social_provider_type : ${ModelUserInfo.getInstance().socialProviderType.toString()}');

                  PacketC2SSignIn packetC2SSignIn = new PacketC2SSignIn();
                  packetC2SSignIn.generate(_uId);
                  ManageMessage.add(packetC2SSignIn);

                }
              }
              else
              {


                PacketC2SLocalizationInfo packetC2SLocalizationInfo = new PacketC2SLocalizationInfo();
                packetC2SLocalizationInfo.generate(ManageDeviceInfo.languageCode,ManageDeviceInfo.localeCode);
                ManageMessage.add(packetC2SLocalizationInfo);

              }

            }

        }
        break;

        case e_packet_type.s2c_sign_in:
          {
            print('----- e_packet_type.s2c_sign_in ------');

            PacketC2SUserInfo packetC2SUserInfo = new PacketC2SUserInfo();
            packetC2SUserInfo.generate(_uId);
            ManageMessage.add(packetC2SUserInfo);

          }
          break;

        case e_packet_type.s2c_user_info:
          {
            print('----- e_packet_type.s2c_user_info -------');

            PacketC2SLocalizationInfo packetC2SLocalizationInfo = new PacketC2SLocalizationInfo();
            packetC2SLocalizationInfo.generate(ManageDeviceInfo.languageCode,ManageDeviceInfo.localeCode);
            ManageMessage.add(packetC2SLocalizationInfo);
          }
          break;

        case e_packet_type.s2c_localization_info:
          {
            print('---- e_packet_type.s2c_localization_info ------');

            bool skip = true;
            if(true == skip)
            {
              navigationPage();
            }
            else
            {
              PacketC2SFeaturedComicInfo packetC2SFeaturedComicInfo = new PacketC2SFeaturedComicInfo();
              packetC2SFeaturedComicInfo.generate();
              ManageMessage.add(packetC2SFeaturedComicInfo);
            }
          }
          break;

        case e_packet_type.s2c_featured_comic_info:
          {
            print('---- e_packet_type.s2c_featured_comic_info ------');

            PacketC2SRecommendedComicInfo packetC2SRecommendedComicInfo = new PacketC2SRecommendedComicInfo();
            packetC2SRecommendedComicInfo.generate();
            ManageMessage.add(packetC2SRecommendedComicInfo);

          }
          break;

        case e_packet_type.s2c_recommended_comic_info:
          {
            print('---- e_packet_type.s2c_recommended_comic_info ------');

            PacketC2SRealTimeTrendComicInfo packetC2SRealTimeTrendComicInfo = new PacketC2SRealTimeTrendComicInfo();
            packetC2SRealTimeTrendComicInfo.generate();
            ManageMessage.add(packetC2SRealTimeTrendComicInfo);

          }
          break;

        case e_packet_type.s2c_real_time_trend_comic_info:
          {
            print('---- e_packet_type.s2c_real_time_trend_comic_info ------');

            PacketC2SNewComicInfo packetC2SNewComicInfo = new PacketC2SNewComicInfo();
            packetC2SNewComicInfo.generate();
            ManageMessage.add(packetC2SNewComicInfo);

          }
          break;

        case e_packet_type.s2c_new_comic_info:
          {
            print('---- e_packet_type.s2c_new_comic_info ------');

            PacketC2STodayTrendComicInfo packetC2STodayTrendComicInfo = new PacketC2STodayTrendComicInfo();
            packetC2STodayTrendComicInfo.generate();
            ManageMessage.add(packetC2STodayTrendComicInfo);

          }
          break;

        case e_packet_type.s2c_today_trend_comic_info:
          {
            print('---- e_packet_type.s2c_today_trend_comic_info ------');

            PacketC2SWeeklyTrendComicInfo packetC2SWeeklyTrendComicInfo = new PacketC2SWeeklyTrendComicInfo();
            packetC2SWeeklyTrendComicInfo.generate();
            ManageMessage.add(packetC2SWeeklyTrendComicInfo);

          }
          break;

        case e_packet_type.s2c_weekly_trend_comic_info:
          {
            print('---- e_packet_type.s2c_weekly_trend_comic_info ------');

            PacketC2SLibraryContinueComicInfo  packetC2SLibraryContinueComicInfo = new PacketC2SLibraryContinueComicInfo();
            packetC2SLibraryContinueComicInfo.generate();
            ManageMessage.add(packetC2SLibraryContinueComicInfo);

          }
          break;

        case e_packet_type.s2c_library_continue_comic_info:
          {
            print('---- e_packet_type.s2c_library_continue_comic_info ------');

            PacketC2SLibraryOwnedComicInfo  packetC2SLibraryOwnedComicInfo = new PacketC2SLibraryOwnedComicInfo();
            packetC2SLibraryOwnedComicInfo.generate();
            ManageMessage.add(packetC2SLibraryOwnedComicInfo);

          }
          break;

        case e_packet_type.s2c_library_owned_comic_info:
          {
            print('---- e_packet_type.s2c_library_owned_comic_info ------');

            PacketC2SLibraryRecentComicInfo  packetC2SLibraryRecentComicInfo = new PacketC2SLibraryRecentComicInfo();
            packetC2SLibraryRecentComicInfo.generate();
            ManageMessage.add(packetC2SLibraryRecentComicInfo);

          }
          break;

        case e_packet_type.s2c_library_recent_comic_info:
          {
            print('---- e_packet_type.s2c_library_recent_comic_info ------');

            PacketC2SLibraryViewListComicInfo  packetC2SLibraryViewListComicInfo = new PacketC2SLibraryViewListComicInfo();
            packetC2SLibraryViewListComicInfo.generate();
            ManageMessage.add(packetC2SLibraryViewListComicInfo);

          }
          break;

        case e_packet_type.s2c_library_view_list_comic_info:
          {
            print('---- e_packet_type.s2c_library_view_list_comic_info ------');

            navigationPage();
          }
          break;



        default:
          break;
      }
    });

    //
    PacketC2SPreset packetC2SPreset = new PacketC2SPreset();
    packetC2SPreset.generate();
    ManageMessage.add(packetC2SPreset);

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


  void _onFetchDone(PacketS2CCommon packetS2CCommon)
  {
    if(true == ModelPreset.developerMode)
    {
      Navigator.of(context).pushReplacementNamed('/PageDevTestMenu');
      return;
    }

    if(e_packet_status.finish_dispatch_respond != packetS2CCommon.status)
      return;

    bool result = true;
    _enableAppVersion = result;

    if (true == result)
    {
      ManageMessage.generate();
      ManageMessage.streamController.stream.listen((data) {
        print("DataReceived1: " + data.toString());

        switch(data.type)
        {
          case e_packet_type.s2c_sign_in:
            {
              PacketC2SUserInfo packetC2SUserInfo = new PacketC2SUserInfo();
              packetC2SUserInfo.generate(_uId);
              ManageMessage.add(packetC2SUserInfo);
            }
            break;

          case e_packet_type.s2c_user_info:
            {
              print('e_packet_type.s2c_user_info');

              PacketC2SFeaturedComicInfo packetC2SFeaturedComicInfo = new PacketC2SFeaturedComicInfo();
              packetC2SFeaturedComicInfo.generate();
              ManageMessage.add(packetC2SFeaturedComicInfo);





             // PacketC2SPresetComicInfo packetC2SPresetComicInfo = new PacketC2SPresetComicInfo();
             // packetC2SPresetComicInfo.generate();
             // ManageMessage.add(packetC2SPresetComicInfo);

            }
            break;

          case e_packet_type.s2c_featured_comic_info:
            {
              print('e_packet_type.s2c_featured_comic_info');
            }
            break;

          case e_packet_type.s2c_preset_comic_info:
            {

             // PacketC2SPresetLibraryInfo packetC2SPresetLibraryInfo = new PacketC2SPresetLibraryInfo();
             // packetC2SPresetLibraryInfo.generate();
             // ManageMessage.add(packetC2SPresetLibraryInfo);

            }
            break;

          case e_packet_type.s2c_preset_library_info:
            {
              PacketC2SLocalizationInfo packetC2SLocalizationInfo = new PacketC2SLocalizationInfo();
              packetC2SLocalizationInfo.generate(ManageDeviceInfo.languageCode,ManageDeviceInfo.localeCode);
              ManageMessage.add(packetC2SLocalizationInfo);
            }
            break;

          case e_packet_type.s2c_localization_info:
            {
              navigationPage();
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


      if(null != _uId && _uId.length > 0)
      {
        if(false == ModelUserInfo.getInstance().signedIn)
        {
          ModelUserInfo.getInstance().uId = _uId;
          ModelUserInfo.getInstance().socialProviderType = e_social_provider_type.values[_socialProviderType];

          print('social_provider_type : ${ModelUserInfo.getInstance().socialProviderType.toString()}');

          PacketC2SSignIn packetC2SSignIn = new PacketC2SSignIn();
          packetC2SSignIn.generate(_uId);
          ManageMessage.add(packetC2SSignIn);
        }
      }
      else
      {
        PacketC2SPresetComicInfo packetC2SPresetComicInfo = new PacketC2SPresetComicInfo();
        packetC2SPresetComicInfo.generate();
        ManageMessage.add(packetC2SPresetComicInfo);
      }
    }
  }


  /* backup
  void _onFetchDone(PacketS2CCommon packetS2CCommon)
  {
    if(true == ModelPreset.developerMode)
    {
      Navigator.of(context).pushReplacementNamed('/PageDevTestMenu');
      return;
    }

    if(e_packet_status.finish_dispatch_respond != packetS2CCommon.status)
      return;

    bool result = true;
    _enableAppVersion = result;

    if (true == result) {
      ManageMessage.generate();
      ManageMessage.streamController.stream.listen((data) {
        print("DataReceived1: " + data.toString());

        switch(data)
        {
          case e_packet_type.s2c_sign_in:
            {
              PacketC2SUserInfo packetC2SUserInfo = new PacketC2SUserInfo();
              packetC2SUserInfo.generate(_uId);
              ManageMessage.add(packetC2SUserInfo);
            }
            break;

          case e_packet_type.s2c_user_info:
            {
              PacketC2SPresetComicInfo packetC2SPresetComicInfo = new PacketC2SPresetComicInfo();
              packetC2SPresetComicInfo.generate();
              ManageMessage.add(packetC2SPresetComicInfo);
            }
            break;

          case e_packet_type.s2c_preset_comic_info:
            {
              PacketC2SPresetLibraryInfo packetC2SPresetLibraryInfo = new PacketC2SPresetLibraryInfo();
              packetC2SPresetLibraryInfo.generate();
              ManageMessage.add(packetC2SPresetLibraryInfo);
            }
            break;

          case e_packet_type.s2c_preset_library_info:
            {
              PacketC2SLocalizationInfo packetC2SLocalizationInfo = new PacketC2SLocalizationInfo();
              packetC2SLocalizationInfo.generate(ManageDeviceInfo.languageCode,ManageDeviceInfo.localeCode);
              ManageMessage.add(packetC2SLocalizationInfo);
            }
            break;

          case e_packet_type.s2c_localization_info:
            {
              navigationPage();
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


      if(null != _uId && _uId.length > 0)
      {
        if(false == ModelUserInfo.getInstance().signedIn)
        {
          ModelUserInfo.getInstance().uId = _uId;
          ModelUserInfo.getInstance().socialProviderType = e_social_provider_type.values[_socialProviderType];

          print('social_provider_type : ${ModelUserInfo.getInstance().socialProviderType.toString()}');

          PacketC2SSignIn packetC2SSignIn = new PacketC2SSignIn();
          packetC2SSignIn.generate(_uId);
          ManageMessage.add(packetC2SSignIn);
        }
      }
      else
      {
        PacketC2SPresetComicInfo packetC2SPresetComicInfo = new PacketC2SPresetComicInfo();
        packetC2SPresetComicInfo.generate();
        ManageMessage.add(packetC2SPresetComicInfo);
      }
    }
  }
  */

  void navigationPage() {

      Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  void applicationQuit()
  {
    if (Platform.isAndroid)
    {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      //SystemNavigator.pop();
    }
    else if (Platform.isIOS)
    {
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
