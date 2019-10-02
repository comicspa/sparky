

import 'dart:ui' as ui;


class ModelRecommendedComicInfo
{
  String _comicId;
  String _userId;
  String _partId = '001';
  String _seasonId = '001';
  String _title;
  String _url;
  String _thumbnailUrl;
  ui.Image _image;
  String _creatorName;
  String _creatorId;

  String get comicId => _comicId;
  String get userId => _userId;
  String get partId => _partId;
  String get seasonId => _seasonId;
  String get title => _title;
  String get url => _url;
  String get thumbnailUrl => _thumbnailUrl;
  ui.Image get image => _image;
  String get creatorName => _creatorName;
  String get creatorId => _creatorId;

  set comicId(String comicId)
  {
    _comicId = comicId;
  }

  set userId(String userId)
  {
    _userId = userId;
  }

  set partId(String partId)
  {
    _partId = partId;
  }
  set seasonId(String seasonId)
  {
    _seasonId = seasonId;
  }

  set title(String title)
  {
    _title = title;
  }

  set url(String url)
  {
    _url = url;
  }

  set thumbnailUrl(String thumbnailUrl)
  {
    _thumbnailUrl = thumbnailUrl;
  }

  set image(ui.Image image)
  {
    _image = image;
  }

  set creatorName(String creatorName)
  {
    _creatorName = creatorName;
  }

  set creatorId(String creatorId)
  {
    _creatorId = creatorId;
  }

  @override
  String toString()
  {
    return 'title : $title , creatorName : $creatorName , comicId : $comicId, userId : $userId , creatorId : $creatorId , thumbnailUrl : $thumbnailUrl';
  }

  static List<ModelRecommendedComicInfo> list;

}