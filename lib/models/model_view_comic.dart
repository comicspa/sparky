
import 'package:sparky/models/model_comic_info.dart';
import 'package:sparky/models/model_comic_episode_info.dart';


class ModelViewComic
{
  ModelComicEpisodeInfo _modelComicEpisodeInfo = new ModelComicEpisodeInfo();

  String _userId;
  String _id;
  String _partId = '001';
  String _seasonId = '001';

  String get userId => _userId;
  String get title => _modelComicEpisodeInfo.titleName;
  String get episodeNumber => _modelComicEpisodeInfo.episodeNumber;
  String get id => _id;
  String get partId => _partId;
  String get seasonId => _seasonId;
  List<String> get imageUrlList => _modelComicEpisodeInfo.imageCutUrlList;
  e_view_direction_type get viewDirectionType => _modelComicEpisodeInfo.viewDirectionType;

  set userId(String userId)
  {
    _userId = userId;
  }
  set title(String title)
  {
    _modelComicEpisodeInfo.titleName = title;
  }
  set episodeNumber(String episodeNumber)
  {
    _modelComicEpisodeInfo.episodeNumber = episodeNumber;
  }
  set id(String id)
  {
    _id = id;
  }
  set partId(String partId)
  {
    _partId = partId;
  }
  set seasonId(String seasonId)
  {
    _seasonId = seasonId;
  }
  set imageUrlList(List<String> imageUrlList)
  {
    _modelComicEpisodeInfo.imageCutUrlList = imageUrlList;
  }
  set viewDirectionType(e_view_direction_type viewDirectionType)
  {
    _modelComicEpisodeInfo.viewDirectionType = viewDirectionType;
  }

  static void reset()
  {}


  static ModelViewComic _instance;
  static ModelViewComic getInstance() {
    if(_instance == null) {
      _instance = ModelViewComic();
      return _instance;
    }
    return _instance;
  }

}