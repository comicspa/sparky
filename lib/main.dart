import 'package:flutter/material.dart';
import 'package:sparky/screens/test/page_dev_test.dart';
import 'package:sparky/screens/test/page_dev_view.dart';
import 'package:sparky/screens/main_tab_bar.dart';
import 'package:sparky/screens/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Lato'),

      home: SplashScreen(),
      routes: {
        '/PageDevTest': (context) => PageDevTest(),
        '/HomeScreen': (context) => HomeScreen(),
        '/PageDevView': (context) => PageDevView(),
      },
//      initialRoute: '/',
//      routes: {
//        '/': (context) => SplashScreen(),
//        '/HomeScreen': (context) => HomeScreen(),
//        '/LibraryScreen': (context) => LibraryScreen(),
//        '/CreatorScreen': (context) => CreatorScreen(),
//        '/MoreScreen': (context) => MoreScreen(),
//      },
    );
  }
}
