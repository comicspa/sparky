
import 'package:sparky/models/model_comic_info.dart';
import 'package:sparky/packets/packet_common.dart';

class ModelLibraryContinueComicInfo
{
  static const String ModelName = "model_library_continue_comic_info";
  ModelComicInfo _modelComicInfo = new ModelComicInfo();

  String get comicNumber => _modelComicInfo.comicNumber;
  String get partNumber => _modelComicInfo.partNumber;
  String get seasonNumber => _modelComicInfo.seasonNumber;
  String get titleName => _modelComicInfo.titleName;
  String get url => _modelComicInfo.urlAddress;
  String get creatorName => _modelComicInfo.creatorName1;
  String get creatorId => _modelComicInfo.creatorId;
  int get viewCount => _modelComicInfo.viewCount;
  String get comicId => ModelComicInfo.getComicId(creatorId,comicNumber,partNumber,seasonNumber);

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
    return 'titleName : $titleName , creatorName : $creatorName , comicNumber : $comicNumber, creatorId : $creatorId , url : $url';
  }

  static List<ModelLibraryContinueComicInfo> list;
  static e_packet_status status;
  static int isEmptyUrl()
  {
    if(null == list)
      return -1;

    for(int countIndex=0; countIndex<list.length; ++countIndex)
    {
      if(null == list[countIndex].url || '' == list[countIndex].url)
        return 1;
    }

    return 0;
  }
}