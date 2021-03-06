
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/models/model_comic_info.dart';
import 'package:sparky/models/model_comic_episode_info.dart';

class ModelComicDetailInfo
{
  static const String ModelName = "model_comic_detail_info";

  ModelComicInfo _modelComicInfo = new ModelComicInfo();

  String _representationImageUrl;
  double _point;
  List<ModelComicEpisodeInfo> _modelComicEpisodeInfoList;
  int _modelComicInfoLength = 0;
  int _subscribed = 0;

  String get userId => _modelComicInfo.userId;
  String get comicNumber => _modelComicInfo.comicNumber;
  String get partNumber => _modelComicInfo.partNumber;
  String get seasonNumber => _modelComicInfo.seasonNumber;
  String get titleName => _modelComicInfo.titleName;
  String get representationImageUrl => _representationImageUrl;
  String get explain => _modelComicInfo.description;
  String get creatorName => _modelComicInfo.creatorName1;
  double get point => _point;
  List<ModelComicEpisodeInfo> get modelComicEpisodeInfoList => _modelComicEpisodeInfoList;
  String get creatorId => _modelComicInfo.creatorId;
  int get modelComicInfoLength => _modelComicInfoLength;
  int get subscribed => _subscribed;

  set userId(String userId)
  {
    _modelComicInfo.userId = userId;
  }
  set comicNumber(String comicNumber)
  {
    _modelComicInfo.comicNumber = comicNumber;
  }
  set partNumber(String partNumber)
  {
    _modelComicInfo.partNumber = partNumber;
  }
  set seasonNumber(String seasonNumber)
  {
    _modelComicInfo.seasonNumber = seasonNumber;
  }
  set titleName(String titleName)
  {
    _modelComicInfo.titleName = titleName;
  }
  set representationImageUrl(String representationImageUrl)
  {
    _representationImageUrl = representationImageUrl;
  }
  set explain(String explain)
  {
    _modelComicInfo.description = explain;
  }
  set creatorName(String creatorName)
  {
    _modelComicInfo.creatorName1 = creatorName;
  }
  set point(double point)
  {
    _point = point;
  }
  set modelComicEpisodeInfoList(List<ModelComicEpisodeInfo> modelComicEpisodeInfoList)
  {
    _modelComicEpisodeInfoList = modelComicEpisodeInfoList;
  }

  set creatorId(String creatorId)
  {
    _modelComicInfo.creatorId = creatorId;
  }

  set modelComicInfoLength(int modelComicInfoLength)
  {
    _modelComicInfoLength = modelComicInfoLength;
  }

  set subscribed(int subscribed)
  {
    _subscribed = subscribed;
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

    if(episodeNumber < _modelComicEpisodeInfoList.length + 1)
      episodeId = ModelPreset.convertNumber2EpisodeId(episodeNumber);
    return episodeId;
  }



  ModelComicEpisodeInfo searchModelComicInfo(String episodeNumber)
  {
    if(null == _modelComicEpisodeInfoList)
      return null;
    for(int countIndex=0; countIndex<_modelComicEpisodeInfoList.length; ++countIndex)
      {
        if(0 == _modelComicEpisodeInfoList[countIndex].episodeNumber.compareTo(episodeNumber))
          return _modelComicEpisodeInfoList[countIndex];
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