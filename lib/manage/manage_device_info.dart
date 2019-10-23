import 'package:device_info/device_info.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';


enum e_platform_type
{
  none,
  ios,
  android,
}


class ManageDeviceInfo
{
  static String _deviceId;
  static double _resolutionWidth = 0.0;
  static double _resolutionHeight = 0.0;
  static double _statusBarHeight = 0.0;
  //static Locale _locale;
  static String _languageCode;
  static String _localeCode;
  static e_platform_type _platformType;

  static String get deviceId => _deviceId;
  static double get resolutionWidth => _resolutionWidth;
  static double get resolutionHeight => _resolutionHeight;
  static double get statusBarHeight => _statusBarHeight;
  //static Locale get locale => _locale;
  static String get languageCode => _languageCode;
  static String get localeCode => _localeCode;
  static e_platform_type get platformType => _platformType;

  static set languageCode(String languageCode)
  {
    _languageCode = languageCode;
  }

  static set localeCode(String localeCode)
  {
    _localeCode = localeCode;
  }

  static String getLanguageLocaleCode()
  {
    return '${languageCode}_${localeCode}';
  }


  static Future<String> _getDeviceId(BuildContext context) async
  {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.iOS)
    {
      _platformType = e_platform_type.ios;
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    }
    else
    {
      _platformType = e_platform_type.android;
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

  static void getDeviceId(BuildContext context)
  {
    if(null != _deviceId)
      return;

    _getDeviceId(context).then((s) {
      _deviceId = s;
      print('getDeviceId : $_deviceId');
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
    if(null != _languageCode && null != _localeCode)
    {
      print('null != _languageCode && null != _localeCode');
      return;
    }

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

  static void firstInitialize(BuildContext context)
  {
    getLanguageLocale();
    getResolution(context);
    getDeviceId(context);
    getStatusBarHeight(context);
    //getLocale(context);
  }

  static bool equalLanguageLocaleCode(String languageLocaleCode)
  {
    if(0 == getLanguageLocaleCode().compareTo(languageLocaleCode.toLowerCase()))
      return true;
    return false;
  }

  //static String getStringLanguageLocale()
  //{
  //  return 'localeCode :  $localeCode, languageCode : $languageCode';
  //}
}