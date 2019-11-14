
import 'package:sparky/models/model_comic_info.dart';


class ModelComicEpisodeInfo
{
  static const String ModelName = "model_comic_episode_info";

  e_view_direction_type _viewDirectionType;
  String _thumbnailUrl;
  int _imageCutCount = 0;
  List<String> _imageCutUrlList;
  String _episodeNumber = '00001';
  String _titleName;
  String _fileExt = 'jpg';
  int _viewCount = 10000;

  String get thumbnailUrl => _thumbnailUrl;
  int get imageCutCount => _imageCutCount;
  List<String> get imageCutUrlList => _imageCutUrlList;
  String get episodeNumber => _episodeNumber;
  String get titleName => _titleName;
  e_view_direction_type get viewDirectionType => _viewDirectionType;
  String get fileExt => _fileExt;
  int get viewCount => _viewCount;

  set thumbnailUrl(String thumbnailUrl)
  {
    _thumbnailUrl = thumbnailUrl;
  }

  set imageCutCount(int imageCutCount)
  {
    _imageCutCount = imageCutCount;
  }

  set imageCutUrlList(List<String> imageCutUrlList)
  {
    _imageCutUrlList = imageCutUrlList;
  }

  set episodeNumber(String episodeNumber)
  {
    _episodeNumber = episodeNumber;
  }

  set titleName(String titleName)
  {
    _titleName = titleName;
  }

  set viewDirectionType(e_view_direction_type viewDirectionType)
  {
    _viewDirectionType = viewDirectionType;
  }
  set fileExt(String fileExt)
  {
    _fileExt = fileExt;
  }
  set viewCount(int viewCount)
  {
    _viewCount = viewCount;
  }


  static String getComicEpisodeId(String creatorId,String comicNumber,String partNumber,String seasonNumber,String episodeNumber)
  {
    return creatorId+'_'+comicNumber+'_'+partNumber+'_'+seasonNumber+'_'+episodeNumber;
  }

  static List<ModelComicEpisodeInfo> list;

}