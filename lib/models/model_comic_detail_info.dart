
import 'dart:ui' as ui;

import 'package:sparky/models/model_comic_info.dart';

import 'package:sparky/manage/manage_firebase_storage.dart';

class ModelComicDetailInfo
{
  String _userId = '1111111111111';
  String _comicId = '000001';
  String _mainTitleName;
  String _representationImageUrl;
  String _explain;
  String _creatorName;
  double _point;
  List<ModelComicInfo> _modelComicInfoList;
  ui.Image _representationImage;

  String get userId => _userId;
  String get comicId => _comicId;
  String get mainTitleName => _mainTitleName;
  String get representationImageUrl => _representationImageUrl;
  String get explain => _explain;
  String get creatorName => _creatorName;
  double get point => _point;
  List<ModelComicInfo> get modelComicInfoList => _modelComicInfoList;
  ui.Image get representationImage => _representationImage;

  set userId(String userId)
  {
    _userId = userId;
  }
  set comicId(String comicId)
  {
    _comicId = comicId;
  }
  set mainTitleName(String mainTitleName)
  {
    _mainTitleName = mainTitleName;
  }
  set representationImageUrl(String representationImageUrl)
  {
    _representationImageUrl = representationImageUrl;
  }
  set explain(String explain)
  {
    _explain = explain;
  }
  set creatorName(String creatorName)
  {
    _creatorName = creatorName;
  }
  set point(double point)
  {
    _point = point;
  }
  set modelComicInfoList(List<ModelComicInfo> modelComicInfoList)
  {
    _modelComicInfoList = modelComicInfoList;
  }
  set representationImage(ui.Image representationImage)
  {
    _representationImage = representationImage;
  }


  static ModelComicDetailInfo _instance;
  static ModelComicDetailInfo getInstance() {
    if(_instance == null) {
      _instance = ModelComicDetailInfo();
      return _instance;
    }
    return _instance;
  }

}