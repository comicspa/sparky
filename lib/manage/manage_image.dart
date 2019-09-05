
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:async';

import 'package:image/image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/manage/manage_flutter_cache_manager.dart';

class ManageImage
{
  Image _image;

  int get width => _image.width;
  int get height => _image.height;


  bool decode(Uint8List list)
  {
    _image = decodeImage(list);
    if(null == _image)
      return false;

    return true;
  }


  static Future<ui.Image> loadImage(List<int> img) async
  {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }


  static Future<ui.Image> fetchImage(String url) async
  {
    File file = await ManageFlutterCacheManager.getSingleFile(url);
    //int fileLength = await fileInfo.file.length();
    //print('fileLength[$countIndex/${urlList.length}] : $fileLength');
    Uint8List uint8list = await ModelCommon.getUint8ListFromFile(file);
    ui.Image image = await loadImage(uint8list);
    print('fetchImage : $url - width : ${image.width} , height : ${image.height}');

    return image;
  }


}