import 'dart:ui' as ui;


class ModelComicEpisodeInfo
{
  int _imageCutCount = 0;
  List<String> _imageCutUrlList;
  String _episode = '1';
  String _episodeId = '00001';
  List<ui.Image> _imageCutList;
  String _titleName;

  int get imageCutCount => _imageCutCount;
  List<String> get imageCutUrlList => _imageCutUrlList;
  String get episode => _episode;
  List<ui.Image> get imageCutList => _imageCutList;
  String get episodeId => _episodeId;
  String get titleName => _titleName;


  set imageCutCount(int imageCutCount)
  {
    _imageCutCount = imageCutCount;
  }
  set imageCutUrlList(List<String> imageCutUrlList)
  {
    _imageCutUrlList = imageCutUrlList;
  }
  set imageCutList(List<ui.Image> imageCutList)
  {
    _imageCutList = imageCutList;
  }
  set episodeId(String episodeId)
  {
    _episodeId = episodeId;
    _episode = (int.parse(_episodeId)).toString();
  }

  set titleName(String titleName)
  {
    _titleName = titleName;
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

    re

   */


}