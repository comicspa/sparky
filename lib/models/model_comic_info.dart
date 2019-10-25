

enum e_comic_genre
{
  romance,
  drama,
  daily_life,
  thriller,
  fantasy,
  comic,
  action,
  sports,
  sf,
  school,
}

enum e_comic_status
{
  in_series,
  in_suspension,
  completed,
}

class ModelComicInfo
{
  int _countIndex = -1;
  String _userId = '1111111111111';
  String _creatorId;
  String _comicId = '000001';
  String _partId = '001';
  String _seasonId = '001';
  String _episode = '1';
  String _episodeId = '00001';
  String _thumbnailImageURL;
  String _subTitleName;
  int _collected = 0;
  int _updated = 0;
  String _cp;


  int get countIndex => _countIndex;
  String get userId => _userId;
  String get comicId => _comicId;
  String get partId => _partId;
  String get seasonId => _seasonId;
  String get episode => _episode;
  String get episodeId => _episodeId;
  String get thumbnailImageUrl => _thumbnailImageURL;
  String get subTitleName => _subTitleName;
  int get collected => _collected;
  int get updated => _updated;


  set countIndex(int countIndex)
  {
    _countIndex = countIndex;
  }
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
  set episodeId(String episodeId)
  {
    _episodeId = episodeId;
    _episode = (int.parse(_episodeId)).toString();
  }
  set thumbnailImageUrl(String thumbnailImageUrl)
  {
    _thumbnailImageURL = thumbnailImageUrl;
  }
  set subTitleName(String subTitleName)
  {
    _subTitleName = subTitleName;
  }
  set collected(int collected)
  {
    _collected = collected;
  }
  set updated(int updated)
  {
    _updated = updated;
  }


}