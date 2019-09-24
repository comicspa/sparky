
import 'package:sparky/models/model_view_comic_detect_text_info.dart';


enum e_comic_view_style
{
  vertical,
  horizontal,
}


class ModelViewComic
{
  String _userId;
  String _title;
  String _id;
  String _episodeId;
  List<String> _imageUrlList;
  e_comic_view_style _style = e_comic_view_style.vertical;

  String get userId => _userId;
  String get title => _title;
  String get episodeId => _episodeId;
  String get id => _id;
  List<String> get imageUrlList => _imageUrlList;
  e_comic_view_style get style => _style;

  set userId(String userId)
  {
    _userId = userId;
  }
  set title(String title)
  {
    _title = title;
  }
  set episodeId(String episodeId)
  {
    _episodeId = episodeId;
  }
  set id(String id)
  {
    _id = id;
  }
  set imageUrlList(List<String> imageUrlList)
  {
    _imageUrlList = imageUrlList;
  }
  set style(e_comic_view_style style)
  {
    _style = style;
  }


  static List<ModelViewComic> list;

  static void reset()
  {
      if(null != list)
        {list.clear();
        list = null;}
  }

  /*
  static ModelViewComic _instance;
  static ModelViewComic getInstance() {
    if(_instance == null) {
      _instance = ModelViewComic();
      return _instance;
    }
    return _instance;
  }
  */
}