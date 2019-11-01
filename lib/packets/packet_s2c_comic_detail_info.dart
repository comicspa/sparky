import 'dart:typed_data';

import 'package:sparky/manage/manage_device_info.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_comic_detail_info.dart';
import 'package:sparky/models/model_comic_info.dart';
import 'package:sparky/models/model_comic_episode_info.dart';
import 'package:sparky/models/model_preset.dart';


class PacketS2CComicDetailInfo extends PacketS2CCommon
{
  List<ModelComicInfo> _modelComicInfoList;
  List<ModelComicInfo> get modelComicInfoList => _modelComicInfoList;

  PacketS2CComicDetailInfo()
  {
    type = e_packet_type.s2c_comic_detail_info;
    _modelComicInfoList = new List<ModelComicInfo>();
  }

  void clear()
  {
    if(null != _modelComicInfoList)
      _modelComicInfoList.clear();
  }

  void addModelComicInfo(int addCount,int currentCountIndex)
  {

  }


  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    ModelComicDetailInfo.getInstance().userId = jsonMap['user_id'];
    ModelComicDetailInfo.getInstance().comicId = jsonMap['comic_id'];
    ModelComicDetailInfo.getInstance().creatorName = jsonMap['creator_name'];
    ModelComicDetailInfo.getInstance().titleName = jsonMap['title'];
    ModelComicDetailInfo.getInstance().explain = jsonMap['explain'];
    //print('comicDetailInfo_explain : ${ModelComicDetailInfo.getInstance().explain}');
    ModelComicDetailInfo.getInstance().point = double.parse(jsonMap['point'].toString());
    ModelComicDetailInfo.getInstance().creatorId = jsonMap['creator_id'];

    //ModelComicDetailInfo.getInstance().representationImageUrl =
    //  await ModelPreset.getRepresentationVerticalImageDownloadUrl(ModelComicDetailInfo.getInstance().userId, ModelComicDetailInfo.getInstance().comicId );

    ModelComicDetailInfo.getInstance().representationImageUrl =
    await ModelPreset.getRepresentationSquareImageDownloadUrl(ModelComicDetailInfo.getInstance().userId, ModelComicDetailInfo.getInstance().comicId );

    if(null == ModelComicDetailInfo.getInstance().modelComicEpisodeInfoList)
      ModelComicDetailInfo.getInstance().modelComicEpisodeInfoList = new List<ModelComicEpisodeInfo>();
    ModelComicDetailInfo.getInstance().modelComicEpisodeInfoList.clear();

    int countIndex = 0;

    var subscribersMap = jsonMap['subscribers'];
    if(true == ModelUserInfo.getInstance().signedIn)
    {
      if(null != subscribersMap)
      {
        if (subscribersMap.containsKey(ModelUserInfo
            .getInstance()
            .uId)) {
          ModelComicDetailInfo
              .getInstance()
              .subscribed = 1;
        }
        else {
          ModelComicDetailInfo
              .getInstance()
              .subscribed = 0;
        }
      }
    }


    var comics = jsonMap['comics'];

    ModelComicDetailInfo.getInstance().modelComicInfoLength = comics.keys.length;
    //print('modelComicInfoList length1 : ${ModelComicDetailInfo.getInstance().modelComicInfoList.length}');

    if(null != onFetchDone)
      onFetchDone(this);

    var newMap = Map.fromEntries(comics.entries.toList()..sort((e1, e2) =>
        int.parse(e1.value["episode_id"]).compareTo(int.parse(e2.value["episode_id"]))));
    for(var key in newMap.keys)
    {

      ModelComicEpisodeInfo modelComicEpisodeInfo = new ModelComicEpisodeInfo();

      modelComicEpisodeInfo.episodeId = comics[key.toString()]['episode_id'];
      modelComicEpisodeInfo.titleName = comics[key.toString()]['title'];
      int collected = comics[key.toString()]['collected'];
      int updated = comics[key.toString()]['updated'];

      print('episode_id : ${modelComicEpisodeInfo.episodeId}');

      //modelComicEpisodeInfo.userId = ModelComicDetailInfo.getInstance().userId;
      //modelComicEpisodeInfo.comicId = ModelComicDetailInfo.getInstance().comicId;

      modelComicEpisodeInfo.thumbnailUrl =
      //await ModelPreset.getThumbnailImageDownloadUrl(ModelComicDetailInfo.getInstance().userId,
      //   ModelComicDetailInfo.getInstance().comicId,'001','001','00001');

      //String userId,String comicId,String partId,String seasonId,String episodeId
      await ModelPreset.getThumbnailImageDownloadUrl(ModelComicDetailInfo.getInstance().userId,
        ModelComicDetailInfo.getInstance().comicId,
        ModelComicDetailInfo.getInstance().partId,
        ModelComicDetailInfo.getInstance().seasonId,
          modelComicEpisodeInfo.episodeId);

      print('comicInfo_thumbnailImageURL[$countIndex] : ${modelComicEpisodeInfo.thumbnailUrl}');
      ++countIndex;

      ModelComicDetailInfo.getInstance().modelComicEpisodeInfoList.add(modelComicEpisodeInfo);

      if(0 == countIndex % 5) {
        if (null != onFetchDone)
          onFetchDone(this);
      }
    }

    //print('modelComicInfoList length2 : ${ModelComicDetailInfo.getInstance().modelComicInfoList.length}');

    //sort
    /*
    if(null != modelComicInfoList) {
      modelComicInfoList..sort((a, b) => a.countIndex.compareTo(b.countIndex));
      ModelComicDetailInfo
          .getInstance()
          .modelComicInfoList = modelComicInfoList;
    }

     */

    //print('modelComicInfoList length3 : ${ModelComicDetailInfo.getInstance().modelComicInfoList.length}');

    print('[PacketC2SComicDetailInfo : fetchFireBaseDB finished]');

    if(null != onFetchDone)
      onFetchDone(this);
  }



  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize, onFetchDone) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    ModelComicDetailInfo.getInstance().userId = readStringToByteBuffer();
    ModelComicDetailInfo.getInstance().comicId = readStringToByteBuffer();
    ModelComicDetailInfo.getInstance().creatorName = readStringToByteBuffer();
    ModelComicDetailInfo.getInstance().titleName = readStringToByteBuffer();
    ModelComicDetailInfo.getInstance().explain = readStringToByteBuffer();
    print('comicDetailInfo_explain : ${ModelComicDetailInfo.getInstance().explain}');
    ModelComicDetailInfo.getInstance().point = getDouble();

    //ModelComicDetailInfo.getInstance().representationImageUrl =
    //  await ModelPreset.getRepresentationVerticalImageDownloadUrl(ModelComicDetailInfo.getInstance().userId, ModelComicDetailInfo.getInstance().comicId );

    ModelComicDetailInfo.getInstance().representationImageUrl =
      await ModelPreset.getRepresentationSquareImageDownloadUrl(ModelComicDetailInfo.getInstance().userId, ModelComicDetailInfo.getInstance().comicId );


    if(null == ModelComicDetailInfo.getInstance().modelComicEpisodeInfoList)
      ModelComicDetailInfo.getInstance().modelComicEpisodeInfoList = new List<ModelComicEpisodeInfo>();
    else
      ModelComicDetailInfo.getInstance().modelComicEpisodeInfoList.clear();

    int comicInfoCount = getUint32();
    print('comicInfoCount : $comicInfoCount');
    for(int countIndex=0; countIndex<comicInfoCount; ++countIndex)
    {
      ModelComicEpisodeInfo modelComicEpisodeInfo = new ModelComicEpisodeInfo();

      String episodeId = readStringToByteBuffer();
      modelComicEpisodeInfo.titleName = readStringToByteBuffer();
      int collected = getUint32();
      int updated = getUint32();

      //modelComicEpisodeInfo.userId = ModelComicDetailInfo.getInstance().userId;
      //modelComicEpisodeInfo.comicId = ModelComicDetailInfo.getInstance().comicId;

      modelComicEpisodeInfo.thumbnailUrl =
      //await ModelPreset.getThumbnailImageDownloadUrl(ModelComicDetailInfo.getInstance().userId,
       //   ModelComicDetailInfo.getInstance().comicId,'001','001','00001');
      await ModelPreset.getThumbnailImageDownloadUrl(ModelComicDetailInfo.getInstance().userId,
          ModelComicDetailInfo.getInstance().comicId,
          ModelComicDetailInfo.getInstance().partId,
          ModelComicDetailInfo.getInstance().seasonId,
          modelComicEpisodeInfo.episodeId);


      print('comicInfo_thumbnailImageURL[$countIndex] : ${modelComicEpisodeInfo.thumbnailUrl}');

      ModelComicDetailInfo.getInstance().modelComicEpisodeInfoList.add(modelComicEpisodeInfo);
    }

    if(null != onFetchDone)
      onFetchDone(this);

  }

}
