import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ManageToastMessage
{

  static show(String message,Toast toastLength,ToastGravity gravity,double fontSize,Color backgroundColor,Color textColor)
  {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIos: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize);
  }

  static showLong(String message)
  {
    show(message,Toast.LENGTH_LONG,ToastGravity.BOTTOM,16.0,Colors.black,Colors.white);
  }

  static showShort(String message)
  {
    show(message,Toast.LENGTH_SHORT,ToastGravity.BOTTOM,16.0,Colors.black,Colors.white);
  }

  static cancel()
  {
    Fluttertoast.cancel();
  }
}