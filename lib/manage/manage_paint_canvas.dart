
import 'dart:ui';

import 'package:flutter/material.dart';


class ManagePaintCanvas extends CustomPainter
{

  @override
  void paint(Canvas canvas,Size size)
  {
    canvas.drawRect(new Rect.fromLTRB(0.0, 100.0, 0.0, 0.0),new Paint()..color = new Color(0xFF0099FF),);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate)
  {
    return false;
  }

}