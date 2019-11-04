import 'dart:ui' as ui;

import 'package:sparky/models/model_comic_info.dart';


class ModelComicEpisodeInfo
{
  e_view_direction_type _viewDirectionType;
  String _thumbnailUrl;
  int _imageCutCount = 0;
  List<String> _imageCutUrlList;
  String _episodeId = '00001';
  String _titleName;

  String get thumbnailUrl => _thumbnailUrl;
  int get imageCutCount => _imageCutCount;
  List<String> get imageCutUrlList => _imageCutUrlList;
  String get episodeId => _episodeId;
  int get episodeNumber {return int.parse(_episodeId); }
  String get titleName => _titleName;
  e_view_direction_type get viewDirectionType => _viewDirectionType;

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

/*
  Future<List<String>> getImageCutDownloadUrl() async
  {
    for(int countIndex=0; countIndex<_imageCutCount; ++countIndex)
    {
      if(null == _imageCutUrlList)
        _imageCutUrlList = new List<String>();

      String fileName = sprintf('%05d.jpg', (countIndex+1));
      print('getImageCutDownloadUrl[$countIndex/$_imageCutCount)] : $fileName');

      String imageUrl = await ManageFirebaseStorage.getDownloadUrl('comics/$_userId/$_comicId/$_partId/$_seasonId/$_episodeId/$fileName');
      print('getImageCutDownloadUrl[$countIndex/$_imageCutCount)] : $imageUrl');

      _imageCutUrlList.add(imageUrl);
    }
   */


}