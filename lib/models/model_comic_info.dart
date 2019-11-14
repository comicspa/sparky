

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

enum e_story_status
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
  vertical,
  horizontal,
}


class ModelComicInfo
{
  static const String ModelName = "model_comic_info";

  static const int AgeRestriction_All = 0;
  static const int AgeRestriction_12_Under = 12;
  static const int AgeRestriction_16_Under = 16;
  static const int AgeRestriction_19_MoreThan = 19;

  int _countIndex = -1;
  String _userId;
  String _creatorId;
  String _creatorName1;
  String _creatorName2;
  String _comicNumber = '000001';
  String _partNumber = '001';
  String _seasonNumber = '001';
  String _titleName;
  String _cp;
  e_story_status _storyStatus;
  String _genre1;
  String _genre2;
  String _genre3;
  String _genre4;
  e_division_type _divisionType;
  e_view_direction_type _viewDirectionType;
  String _description;
  int _ageRestriction = AgeRestriction_All;
  int _totalNumberBook = 0;
  int _totalNumberEpisode = 0;
  int _pricePerEpisode = 0;
  int _pricePerRent = 0;
  int _freeEpisode = -1;
  String _languageLocaleCode;
  int _profitModelType;
  String _dateCreated;
  String _datePublished;
  String _urlAddress;
  int _viewCount = 10000;

  String get creatorId => _creatorId;
  int get countIndex => _countIndex;
  String get userId => _userId;
  String get comicNumber => _comicNumber;
  String get partNumber => _partNumber;
  String get seasonNumber => _seasonNumber;
  String get titleName => _titleName;
  e_story_status get storyStatus => _storyStatus;
  String get cp => _cp;
  String get genre1 => _genre1;
  String get genre2 => _genre2;
  String get genre3 => _genre3;
  String get genre4 => _genre4;
  e_division_type get divisionType => _divisionType;
  e_view_direction_type get viewDirectionType => _viewDirectionType;
  String get description => _description;
  String get creatorName1 => _creatorName1;
  String get creatorName2 => _creatorName2;
  int get ageRestriction => _ageRestriction;
  int get totalNumberBook => _totalNumberBook;
  int get totalNumberEpisode => _totalNumberEpisode;
  int get pricePerEpisode => _pricePerEpisode;
  int get pricePerRent => _pricePerRent;
  int get freeEpisode => _freeEpisode;
  String get languageLocaleCode => _languageLocaleCode;
  int get profitModelType => _profitModelType;
  String get dateCreated => _dateCreated;
  String get datePublished => _datePublished;
  String get urlAddress => _urlAddress;
  int get viewCount => _viewCount;
  String get comicId => _creatorId+'_'+_comicNumber+'_'+_partNumber+'_'+_seasonNumber;

  set cp(String cp)
  {
    _cp = cp;
  }
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
  set comicNumber(String comicNumber)
  {
    _comicNumber = comicNumber;
  }
  set partNumber(String partNumber)
  {
    _partNumber = partNumber;
  }
  set seasonNumber(String seasonNumber)
  {
    _seasonNumber = seasonNumber;
  }
  set titleName(String titleName)
  {
    _titleName = titleName;
  }
  set storyStatus(e_story_status storyStatus)
  {
    _storyStatus = storyStatus;
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
  set ageRestriction(int ageRestriction)
  {
    _ageRestriction = ageRestriction;
  }
  set totalNumberBook(int totalNumberBook)
  {
    _totalNumberBook = totalNumberBook;
  }
  set totalNumberEpisode(int totalNumberEpisode)
  {
    _totalNumberEpisode = totalNumberEpisode;
  }
  set pricePerEpisode(int pricePerEpisode)
  {
    _pricePerEpisode = pricePerEpisode;
  }
  set pricePerRent(int pricePerRent)
  {
    _pricePerRent = pricePerRent;
  }
  set freeEpisode(int freeEpisode)
  {
    _freeEpisode = freeEpisode;
  }
  set languageLocaleCode(String languageLocaleCode)
  {
    _languageLocaleCode = languageLocaleCode;
  }
  set profitModelType(int profitModelType)
  {
    _profitModelType = profitModelType;
  }
  set dateCreated(String dateCreated)
  {
    _dateCreated = dateCreated;
  }
  set datePublished(String datePublished)
  {
    _datePublished = datePublished;
  }
  set urlAddress(String urlAddress)
  {
    _urlAddress = urlAddress;
  }
  set viewCount(int viewCount)
  {
    _viewCount = viewCount;
  }

  static String getComicId(String creatorId,String comicNumber,String partNumber,String seasonNumber)
  {
      return creatorId+'_'+comicNumber+'_'+partNumber+'_'+seasonNumber;
  }

  static Map<String,ModelComicInfo> __map;
  static ModelComicInfo Search(String comicId)
  {
    if(__map.containsKey(comicId))
      return null;
    return __map[comicId];
  }

}