import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:sparky/models/model_common.dart';

import 'package:sparky/manage/manage_flutter_cache_manager.dart';
import 'package:sparky/manage/manage_image.dart';

class ManageResource
{
  static Map<String,ui.Image> __imageMap;

  static Map<String,ui.Image> get imageMap
  {
    if(null == __imageMap)
      __imageMap = new Map<String,ui.Image>();
    return __imageMap;
  }

  /*
  static Future<ui.Image> generateAddImage(String realImageUrl) async
  {
    if(imageMap.containsKey(realImageUrl))
      return imageMap[realImageUrl];

    File file = await ManageFlutterCacheManager.getSingleFileFromCache(realImageUrl);
    Uint8List uint8list = await ModelCommon.getUint8ListFromFile(file);
    ui.Image image = await ManageImage.loadImage(uint8list);
    imageMap[realImageUrl] = image;

    return image;
  }
   */


  static Future<ui.Image> fetchImage(String realImageUrl) async
  {
    if(imageMap.containsKey(realImageUrl))
      return imageMap[realImageUrl];

    ui.Image image = await ManageImage.fetchImage(realImageUrl);
    imageMap[realImageUrl] = image;

    return image;
  }


}