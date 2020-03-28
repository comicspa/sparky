

import 'package:file_picker/file_picker.dart';


class ManageFilePicker
{


  static Future<Map<String,String>> getMultiFilePath() async
  {
    Map<String,String> filePathsMap = await FilePicker.getMultiFilePath(type:FileType.image);

    if(null != filePathsMap)
    {
      for (var data in filePathsMap.keys)
      {
        //data : filefullname
        print('getfilePath : $data, ${filePathsMap[data]}');
      }
    }
    return filePathsMap;
  }

  /*
  static Future<String> getFilePath() async
  {
    String filePathName =  await FilePicker.getFilePath(FileType.IMAGE,'');
    return filePathName;
  }
  */


}