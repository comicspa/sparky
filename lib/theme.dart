import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart';

ThemeData basicTheme(){
  TextTheme _basicTextTheme(TextTheme base){
    return base.copyWith(
      headline: base.headline.copyWith(
        fontFamily: 'Lato',
        fontSize: 18,
        color: Colors.black87
      ),
      title:base.title.copyWith(
        fontFamily: 'Lato',
        fontSize: 14,
        color: Colors.black87
      ),
      display1:base.title.copyWith(
        fontFamily: 'Lato',
        fontSize: 12,
        color: Colors.black87
      ),
      display2:base.title.copyWith(
        fontFamily: 'Lato',
        fontSize: 10,
        color: Colors.black87
      ),
      caption:base.title.copyWith(
        fontFamily: 'Lato',
        fontSize: 10,
        color: Colors.black87
      ),
      body1:base.body1.copyWith(
        color: Colors.black87
      )
    );
  }
  
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _basicTextTheme(base.textTheme),
    primaryColor: Colors.black87,
    iconTheme: IconThemeData(
      color: Colors.black87,
    ),
    indicatorColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.white,
    tabBarTheme: base.tabBarTheme.copyWith(
      labelColor: Color.fromRGBO(21, 24, 45, 1.0),
      unselectedLabelColor: Colors.grey,
    )

  );

}