
import 'package:sparky/models/model_comic_info.dart';


class ModelComicEpisodeInfo
{
  static const String ModelName = "model_comic_episode_info";

  e_view_direction_type _viewDirectionType;
  String _thumbnailUrl;
  int _imageCutCount = 0;
  List<String> _imageCutUrlList;
  String _episodeId = '00001';
  String _titleName;
  String _fileExt = 'jpg';
  int _viewCount = 10000;

  String get thumbnailUrl => _thumbnailUrl;
  int get imageCutCount => _imageCutCount;
  List<String> get imageCutUrlList => _imageCutUrlList;
  String get episodeId => _episodeId;
  int get episodeNumber {return int.parse(_episodeId); }
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

  set episodeId(String episodeId)
  {
    _episodeId = episodeId;
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

  static List<ModelComicEpisodeInfo> list;

}