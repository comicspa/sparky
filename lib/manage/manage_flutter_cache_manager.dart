import 'dart:io';


import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class ManageFlutterCacheManager
{

  static Future<File> getSingleFile(String url) async
  {
    File file =  await DefaultCacheManager().getSingleFile(url);
    return file;
  }

  static void removeFile(String url)
  {
    DefaultCacheManager().removeFile(url);
  }

  static Future<FileInfo> downloadFile(String url) async
  {
    return await DefaultCacheManager().downloadFile(url);
  }

}


