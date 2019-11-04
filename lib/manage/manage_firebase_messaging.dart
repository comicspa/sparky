import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';


class ManageFireBaseMessaging
{
  static FirebaseMessaging _firebaseMessaging;

  static void initialize()
  {
     if(null == _firebaseMessaging)
       _firebaseMessaging = new FirebaseMessaging();

    if (Platform.isIOS)
      _iosSettingsRegistered();

    _firebaseMessaging.getToken().then((token)
    {
      print('firebaseMessaging.getToken() : $token');
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onBackgroundMessage: fcmBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  static Future<dynamic> fcmBackgroundMessageHandler(Map<String, dynamic> message)
  {
    print('fcmBackgroundMessageHandler :  ${message.toString()}');

    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      print('fcmBackgroundMessageHandler :  $data');
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      print('fcmBackgroundMessageHandler :  $notification');
    }

    return null;
    // Or do other work.
  }

  static void _iosSettingsRegistered()
  {
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }
}




