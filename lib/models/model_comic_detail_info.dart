
import 'dart:ui' as ui;
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/models/model_comic_info.dart';

class ModelComicDetailInfo
{
  String _userId = '1111111111111';
  String _comicId = '000001';
  String _partId = '001';
  String _seasonId = '001';
  String _mainTitleName;
  String _representationImageUrl;
  String _explain;
  String _creatorId;
  String _creatorName;
  double _point;
  List<ModelComicInfo> _modelComicInfoList;
  ui.Image _representationImage;

  String get userId => _userId;
  String get comicId => _comicId;
  String get partId => _partId;
  String get seasonId => _seasonId;
  String get mainTitleName => _mainTitleName;
  String get representationImageUrl => _representationImageUrl;
  String get explain => _explain;
  String get creatorName => _creatorName;
  double get point => _point;
  List<ModelComicInfo> get modelComicInfoList => _modelComicInfoList;
  ui.Image get representationImage => _representationImage;
  String get creatorId => _creatorId;

  set userId(String userId)
  {
    _userId = userId;
  }
  set comicId(String comicId)
  {
    _comicId = comicId;
  }
  set partId(String partId)
  {
    _partId = partId;
  }
  set seasonId(String seasonId)
  {
    _seasonId = seasonId;
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

  set creatorId(String creatorId)
  {
    _creatorId = creatorId;
  }

  String getPrevEpisodeId(String episodeId)
  {
    int episodeNumber = int.parse(episodeId);
    -- episodeNumber;
    if(0 < episodeNumber)
      episodeId = ModelPreset.convertNumber2EpisodeId(episodeNumber);
    return episodeId;
  }

  String getNextEpisodeId(String episodeId)
  {
    int episodeNumber = int.parse(episodeId);
    ++ episodeNumber;

    if(episodeNumber < _modelComicInfoList.length + 1)
      episodeId = ModelPreset.convertNumber2EpisodeId(episodeNumber);
    return episodeId;
  }



  ModelComicInfo searchModelComicInfo(String episodeId)
  {
    if(null == _modelComicInfoList)
      return null;
    for(int countIndex=0; countIndex<_modelComicInfoList.length; ++countIndex)
      {
        if(0 == _modelComicInfoList[countIndex].episodeId.compareTo(episodeId))
          return _modelComicInfoList[countIndex];
      }

    return null;

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