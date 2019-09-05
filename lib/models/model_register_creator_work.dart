



import 'package:sparky/manage/manage_file_picker.dart';
import 'package:sparky/manage/manage_permission.dart';


class ModelRegisterCreatorWork
{
  Map<String,String> _imageFilePathMap;

  void checkPermissionGetMultiFilePath() async
  {
    bool checkPermissions = await ManagePermission.checkRequest();
    if(true == checkPermissions)
      _imageFilePathMap = await ManageFilePicker.getMultiFilePath();

  }







}