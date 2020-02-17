import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sparky/screens/test/page_dev_test_menu.dart';
import 'package:sparky/screens/main_tab_bar.dart';
import 'package:sparky/screens/splash.dart';
import 'package:sparky/screens/test/page_dev_test_apply.dart';
import 'package:sparky/theme.dart';

/* ios permission
<key>NSAppleMusicUsageDescription</key>
<string>Media Library Access Warning</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Location When In Use Access Warning</string>
<key>NSCalendarsUsageDescription</key>
<string>Calendars Access Warning</string>
<key>NSContactsUsageDescription</key>
<string>Contacts Access Warning</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>Location Always Access Warning</string>
<key>NSMotionUsageDescription</key>
<string>Motion Access Warning</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Photo Library Access Warning</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Speech Recognition Access Warning</string>
 */

void main() async {
  InAppPurchaseConnection.enablePendingPurchases();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.black, //top bar color
      statusBarIconBrightness: Brightness.dark, //top bar icons
      systemNavigationBarColor: Colors.white, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
    )
  );
  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(fontFamily: 'Lato'),//basicTheme(), **** need to add title to implement basicTheme()

      home: SplashScreen(),
      routes: {
        '/PageDevTestMenu': (context) => PageDevTestMenu(),
        '/HomeScreen': (context) => HomeScreen(),
        '/PageDevTestApply': (context) => PageDevTestApply(),
      },

    );
  }
}


//      initialRoute: '/',
//      routes: {
//        '/': (context) => SplashScreen(),
//        '/HomeScreen': (context) => HomeScreen(),
//        '/LibraryScreen': (context) => LibraryScreen(),
//        '/CreatorScreen': (context) => CreatorScreen(),
//        '/MoreScreen': (context) => MoreScreen(),
//      },