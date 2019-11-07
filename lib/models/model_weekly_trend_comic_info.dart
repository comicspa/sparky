

import 'package:sparky/models/model_comic_info.dart';


class ModelWeeklyTrendComicInfo
{
  static const String ModelName = "model_weekly_trend_comic_info";
  ModelComicInfo _modelComicInfo = new ModelComicInfo();

  String get comicId => _modelComicInfo.comicId;
  String get userId => _modelComicInfo.userId;
  String get partId => _modelComicInfo.partId;
  String get seasonId => _modelComicInfo.seasonId;
  String get title => _modelComicInfo.titleName;
  String get url => _modelComicInfo.urlAddress;
  String get creatorName => _modelComicInfo.creatorName1;
  String get creatorId => _modelComicInfo.creatorId;
  int get viewCount => _modelComicInfo.viewCount;

  set comicId(String comicId)
  {
    _modelComicInfo.comicId = comicId;
  }

  set userId(String userId)
  {
    _modelComicInfo.userId = userId;
  }

  set partId(String partId)
  {
    _modelComicInfo.partId = partId;
  }
  set seasonId(String seasonId)
  {
    _modelComicInfo.seasonId = seasonId;
  }

  set title(String title)
  {
    _modelComicInfo.titleName = title;
  }

  set url(String url)
  {
    _modelComicInfo.urlAddress = url;
  }

  set creatorName(String creatorName)
  {
    _modelComicInfo.creatorName1 = creatorName;
  }

  set creatorId(String creatorId)
  {
    _modelComicInfo.creatorId = creatorId;
  }

  set viewCount(int viewCount)
  {
    _modelComicInfo.viewCount = viewCount;
  }

  @override
  String toString()
  {
    return 'title : $title , creatorName : $creatorName , comicId : $comicId, userId : $userId , creatorId : $creatorId , url : $url';
  }

  static List<ModelWeeklyTrendComicInfo> list;

}