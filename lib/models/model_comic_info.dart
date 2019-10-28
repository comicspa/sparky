

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

enum e_division_type
{
  none,
  book,
  webtoon,
}

enum e_view_direction_type
{
  horizontal,
  vertical,
}

class ModelComicInfo
{
  int _countIndex = -1;
  String _userId;
  String _creatorId;
  String _creatorName1;
  String _creatorName2;
  String _comicId = '000001';
  String _partId = '001';
  String _seasonId = '001';
  String _episodeId = '00001';
  String _thumbnailImageURL;
  String _titleName;
  int _collected = 0;
  int _updated = 0;
  String _cp;
  e_comic_status _status;
  String _genre1;
  String _genre2;
  String _genre3;
  String _genre4;
  e_division_type _divisionType;
  e_view_direction_type _viewDirectionType;
  String _description;

  String get creatorId => _creatorId;
  int get countIndex => _countIndex;
  String get userId => _userId;
  String get comicId => _comicId;
  String get partId => _partId;
  String get seasonId => _seasonId;
  int get episode
  {
    return int.parse(_episodeId);
  }
  String get episodeId => _episodeId;
  String get thumbnailImageUrl => _thumbnailImageURL;
  String get titleName => _titleName;
  int get collected => _collected;
  int get updated => _updated;
  e_comic_status get status => _status;
  String get genre1 => _genre1;
  String get genre2 => _genre2;
  String get genre3 => _genre3;
  String get genre4 => _genre4;
  e_division_type get divisionType => _divisionType;
  e_view_direction_type get viewDirectionType => _viewDirectionType;
  String get description => _description;
  String get creatorName1 => _creatorName1;
  String get creatorName2 => _creatorName2;

  set creatorId(String creatorId)
  {
    _creatorId = creatorId;
  }
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
  }
  set thumbnailImageUrl(String thumbnailImageUrl)
  {
    _thumbnailImageURL = thumbnailImageUrl;
  }
  set titleName(String titleName)
  {
    _titleName = titleName;
  }
  set collected(int collected)
  {
    _collected = collected;
  }
  set updated(int updated)
  {
    _updated = updated;
  }
  set status(e_comic_status status)
  {
    _status = status;
  }
  set genre1(String genre1)
  {
    _genre1 = genre1;
  }
  set genre2(String genre2)
  {
    _genre2 = genre2;
  }
  set genre3(String genre3)
  {
    _genre3 = genre3;
  }
  set genre4(String genre4)
  {
    _genre4 = genre4;
  }
  set divisionType(e_division_type divisionType)
  {
    _divisionType = divisionType;
  }
  set viewDirectionType(e_view_direction_type viewDirectionType)
  {
    _viewDirectionType = viewDirectionType;
  }
  set description(String description)
  {
    _description = description;
  }
  set creatorName1(String creatorName1)
  {
    _creatorName1 = creatorName1;
  }
  set creatorName2(String creatorName2)
  {
    _creatorName2 = creatorName2;
  }
}