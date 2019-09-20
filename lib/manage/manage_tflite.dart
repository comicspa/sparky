
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
//import 'package:tflite_native/tflite.dart' as tfl;
import 'package:tflite/tflite.dart';


class ManageTFLite
{
  static void readModel() async
  {
    String res = await Tflite.loadModel(
        model: 'data/tflite/model.tflite',
        labels: 'data/tflite/dict.txt',
        numThreads: 1 // defaults to 1
    );

    print('readModel - $res');

  }

}