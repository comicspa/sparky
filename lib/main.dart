import 'package:flutter/material.dart';
import 'package:sparky/screens/test/page_dev_test.dart';
import 'package:sparky/screens/test/page_dev_view.dart';
import 'package:sparky/screens/test/page_dev_signalr.dart';
import 'package:sparky/screens/main_tab_bar.dart';
import 'package:sparky/screens/splash.dart';
import 'package:sparky/screens/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: basicTheme(), //ThemeData(fontFamily: 'Lato'),

      home: SplashScreen(),
      routes: {
        '/PageDevTest': (context) => PageDevTest(),
        '/HomeScreen': (context) => HomeScreen(),
        '/PageDevView': (context) => PageDevView(),
        '/PageDevSignalR': (context) => PageDevSignalR(),
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