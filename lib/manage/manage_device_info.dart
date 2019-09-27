import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';


class ManageDeviceInfo
{
  static String _uniqueId;
  static double _resolutionWidth = 0.0;
  static double _resolutionHeight = 0.0;
  static double _statusBarHeight = 0.0;
  //static Locale _locale;
  static String _languageCode = 'ko';
  static String _localeCode = 'kr';

  static String get uniqueId => _uniqueId;
  static double get resolutionWidth => _resolutionWidth;
  static double get resolutionHeight => _resolutionHeight;
  static double get statusBarHeight => _statusBarHeight;
  //static Locale get locale => _locale;
  static String get languageCode => _languageCode;
  static String get localeCode => _localeCode;

  static Future<String> _getUniqueId(BuildContext context) async
  {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.iOS)
    {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    }
    else
    {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }


  static void getResolution(BuildContext context)
  {
    if(0 == _resolutionWidth)
      _resolutionWidth = MediaQuery.of(context).size.width;
    if(0 == _resolutionHeight)
      _resolutionHeight = MediaQuery.of(context).size.height;

    print('getResolution - Width : $_resolutionWidth , Height : $_resolutionHeight');
  }

  static void getUniqueId(BuildContext context)
  {
    if(null != _uniqueId)
      return;

    _getUniqueId(context).then((s) {
      _uniqueId = s;
      print('getUniqueId : $_uniqueId');
    });
  }

  static void getStatusBarHeight(BuildContext context)
  {
    if(0 == _statusBarHeight)
      _statusBarHeight =  MediaQuery.of(context).padding.top;

    print('getStatusBarHeight : $_statusBarHeight');
  }

  static void getLanguageLocale() async
  {
    List languages = await Devicelocale.preferredLanguages;
    String locale = await Devicelocale.currentLocale;

    print('language[0] : ${languages[0]} , locale : $locale');
    //languageCode : ko-KR , locale : en-KR - ios
    //language[0] : ko_KR , locale : ko_KR

    if(languages[0].toString().contains('-')) {
      List<String> splits = languages[0].toString().split('-');
      _languageCode = splits[0].toLowerCase();
      _localeCode = splits[1].toLowerCase();
    }
    else if(languages[0].toString().contains('_')) {
      List<String> splits = languages[0].toString().split('_');
      _languageCode = splits[0].toLowerCase();
      _localeCode = splits[1].toLowerCase();
    }

    print('languageCode : $_languageCode , localeCode : $_localeCode');
  }

  /*
  static void getLocale(BuildContext context) async
  {
    if(null == _locale)
      _locale = Localizations.localeOf(context);
    print('getLocale - countryCode : ${_locale.countryCode} , languageCode : ${_locale.languageCode}');
  }
   */

  static void firstInitialize(BuildContext context)
  {
    getLanguageLocale();
    getResolution(context);
    getUniqueId(context);
    getStatusBarHeight(context);
    //getLocale(context);
  }

}