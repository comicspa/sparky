import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';


import 'package:sparky/models/model_view_comic_detect_text_info.dart';








class ManageFirebaseMLVision
{
  static Future<VisionText> detectTextFromFile(File file,bool useCloud) async
  {
    print('detectTextFromFile - start');

    TextRecognizer textRecognizer;
    if(true == useCloud)
    {
      textRecognizer = FirebaseVision.instance.cloudTextRecognizer();
    }
    else
    {
      textRecognizer = FirebaseVision.instance.textRecognizer();
    }

    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(file);

    VisionText visionText = await textRecognizer.processImage(visionImage);

    if (null != visionText.blocks)
    {
      for (int i = 0; i < visionText.blocks.length; ++i)
      {
        TextBlock textBlock = visionText.blocks[i];

        if (null != textBlock.recognizedLanguages)
        {
          for (int m = 0; m < textBlock.recognizedLanguages.length; ++m)
          {
            print('recognizedLanguages code[$i][$m] : ${textBlock.recognizedLanguages[m].languageCode}');
          }
        }
        print('text[$i] : ${textBlock.text}');
        print('boundingBox[$i] : ${textBlock.boundingBox.toString()}');
        print('cornerPoints[$i] : ${textBlock.cornerPoints.toString()}');

        if(null != textBlock.lines)
        {
          for (int j = 0; j < textBlock.lines.length; ++j)
          {
            print('linetext[$i][$j] : ${textBlock.lines[j].text}');
          }
        }
      }
    }

    //print('VisionText : ${visionText.text}');
    await textRecognizer.close();


    print('detectTextFromFile - finish');
    return visionText;
  }


}