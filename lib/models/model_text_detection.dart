
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/manage/manage_flutter_cache_manager.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sparky/manage/manage_firebase_storage.dart';
import 'package:sparky/manage/manage_firebase_ml_vision.dart';
import 'package:sparky/manage/manage_image.dart';
import 'package:sparky/manage/manage_device_info.dart';
import 'package:path_provider/path_provider.dart';


class BoundingBoxInfo
{
  Rect boundingBox;
  int countIndex = -1;
  String text = '';
  bool changed = false;
  int previousImageTotalHeight = 0;
  int imageWidth = 0;
  int textLineCount = 0;

  double get left
  {
    return ManageDeviceInfo.resolutionWidth / (imageWidth / boundingBox.left);
  }

  double get top
  {
    return (boundingBox.top / (imageWidth / ManageDeviceInfo.resolutionWidth)) + (previousImageTotalHeight/(imageWidth / ManageDeviceInfo.resolutionWidth));
  }

  double get width
  {
    return ManageDeviceInfo.resolutionWidth / (imageWidth / boundingBox.width);
  }

  double get height
  {
    return ManageDeviceInfo.resolutionHeight /
        (ModelTextDetection.imageTotalHeight / boundingBox.height) +
        ManageDeviceInfo.statusBarHeight;
  }

}


class ModelTextDetection
{
  int _previousImageTotalHeight = 0;
  ui.Image _image;
  List<TextBlock> _textBlockList = new List<TextBlock>();
  ManageImage _manageImage = new ManageImage();
  Uint8List _uint8list;

  int get previousImageTotalHeight => _previousImageTotalHeight;
  List<TextBlock> get textBlockList => _textBlockList;
  ui.Image get image => _image;
  ManageImage  get manageImage => _manageImage;
  Uint8List get uint8List => _uint8list;

  set image(ui.Image image)
  {
    _image = image;
  }
  set uint8List(Uint8List uint8List)
  {
    _uint8list = uint8List;
  }
  set previousImageTotalHeight(int previousImageTotalHeight)
  {
    _previousImageTotalHeight = previousImageTotalHeight;
  }

  static List<ModelTextDetection> list;
  static List<BoundingBoxInfo> boundingBoxInfoList;
  static int imageTotalHeight = 0;

  static void reset()
  {
    imageTotalHeight = 0;
    if(null != list) {
      list.clear();
      list = null;
    }

    if(null != boundingBoxInfoList) {
      boundingBoxInfoList.clear();
      boundingBoxInfoList = null;
    }
  }

  static Future<List<ModelTextDetection>> generate(List<String> urlList,bool useCloud) async
  {
    if(null!= list)
      return list;

    int boundingBoxCountIndex = 0;
    int previousImageTotalHeight = 0;
    for(int countIndex=0; countIndex<urlList.length; ++countIndex)
       {
         String url  = urlList[countIndex];//await ManageFirebaseStorage.getDownloadUrl('comics/${urlList[countIndex]}');
         print('url[$countIndex/${urlList.length}] : $url');

         /*
         Directory tempDir = await getTemporaryDirectory();
         String tempPath = tempDir.path;
         print('tempPath : $tempPath');

         HttpClient client = new HttpClient();
         var downloadData = List<int>();
         File file = new File('$tempPath/${urlList[countIndex]}');
         client.getUrl(Uri.parse(url))
             .then((HttpClientRequest request) {
           return request.close();
         })
             .then((HttpClientResponse response) {
           response.listen((d) => downloadData.addAll(d),
               onDone: () {
                 file.writeAsBytes(downloadData);
               }
           );
         });
         */

         FileInfo fileInfo = await ManageFlutterCacheManager.downloadFile(url);
         int fileLength = await fileInfo.file.length();
         print('fileLength[$countIndex/${urlList.length}] : $fileLength');


         VisionText visionText = await ManageFirebaseMLVision.detectTextFromFile(fileInfo.file, useCloud);
         Uint8List uint8list = await ModelCommon.getUint8ListFromFile(fileInfo.file);

         ModelTextDetection modelTextDetection = new ModelTextDetection();
         modelTextDetection.uint8List = uint8list;
         modelTextDetection.image = await ManageImage.loadImage(uint8list);

         print('imaghe1[$countIndex/${urlList.length}] size - width : ${modelTextDetection.image.width} , height : ${modelTextDetection.image.height}');

         if (false == modelTextDetection.manageImage.decode(uint8list))
         {
           print('false == manageImage.decode');
         }
         else
         {
           print('imaghe2[$countIndex/${urlList.length}] size - width : ${modelTextDetection.manageImage.width} , height : ${modelTextDetection.manageImage.height}');
         }

         if(0 < countIndex)
           previousImageTotalHeight += list[countIndex-1].manageImage.height;
         print('previousImageTotalHeight[$countIndex/${urlList.length}] : $previousImageTotalHeight');
         modelTextDetection.previousImageTotalHeight = previousImageTotalHeight;

         if (null != visionText.blocks) {
           for (int i = 0; i < visionText.blocks.length; ++i) {
             TextBlock textBlock = visionText.blocks[i];

             modelTextDetection.textBlockList.add(textBlock);

             BoundingBoxInfo boundingBoxInfo = new BoundingBoxInfo();
             boundingBoxInfo.countIndex = boundingBoxCountIndex ++;
             boundingBoxInfo.boundingBox = textBlock.boundingBox;
             boundingBoxInfo.text = '';
             boundingBoxInfo.previousImageTotalHeight = previousImageTotalHeight;
             boundingBoxInfo.imageWidth = modelTextDetection.image.width;



        //if (null != textBlock.recognizedLanguages)
        //{
        //  for (int m = 0; m < textBlock.recognizedLanguages.length; ++m)
        //  {
        //    print('recognizedLanguages[$m] : ${textBlock.recognizedLanguages.elementAt(m).toString()}');
        //  }
        //}

             //print('text[$i] : ${textBlock.text}');
             // print('boundingBox[$i] : ${textBlock.boundingBox.toString()}');
             //print('cornerPoints[$i] : ${textBlock.cornerPoints.toString()}');

             if (null != textBlock.lines)
             {
               boundingBoxInfo.textLineCount = textBlock.lines.length;

               for (int j = 0; j < textBlock.lines.length; ++j) {
                 // print('linetext[$i][$j] : ${textBlock.lines[j].text}');
               }
             }

             if(null == boundingBoxInfoList)
               boundingBoxInfoList = new List<BoundingBoxInfo>();
             boundingBoxInfoList.add(boundingBoxInfo);



           }
         }




         /*
         print('textBlockList Count : ${modelTextDetection.textBlockList.length}');
         modelTextDetection.uint8List = await ModelCommon.getUint8ListFromFile(fileInfo.file);
        */

         imageTotalHeight += modelTextDetection.manageImage.height;
         print('imageTotalHeight[$countIndex/${urlList.length}] : $imageTotalHeight');


         if(null == list)
           list = new List<ModelTextDetection>();

         list.add(modelTextDetection);

       }

       return list;
     }

   static get sizeBoxWidth
   {
     if(null == ModelTextDetection.list || 0 == ModelTextDetection.list.length)
       return ManageDeviceInfo.resolutionWidth;

     return ManageDeviceInfo.resolutionWidth * (ModelTextDetection.list[0].manageImage.width / ManageDeviceInfo.resolutionWidth);
   }

  static get sizeBoxHeight
  {
    return ManageDeviceInfo.resolutionHeight * (ModelTextDetection.imageTotalHeight / ManageDeviceInfo.resolutionHeight);
  }


}