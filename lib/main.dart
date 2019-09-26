import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sparky/screens/test/page_dev_test_menu.dart';
import 'package:sparky/screens/main_tab_bar.dart';
import 'package:sparky/screens/splash.dart';
import 'package:sparky/theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white, //top bar color
      statusBarIconBrightness: Brightness.dark, //top bar icons
      systemNavigationBarColor: Colors.white, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
    )
  );
  SystemChrome.setPreferredOrientations(
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