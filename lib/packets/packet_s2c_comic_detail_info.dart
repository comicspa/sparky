import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_comic_detail_info.dart';
import 'package:sparky/models/model_comic_info.dart';
import 'package:sparky/models/model_preset.dart';


class PacketS2CComicDetailInfo extends PacketS2CCommon
{
  PacketS2CComicDetailInfo()
  {
    type = e_packet_type.s2c_comic_detail_info;
  }

  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    ModelComicDetailInfo.getInstance().userId = jsonMap['user_id'];
    ModelComicDetailInfo.getInstance().comicId = jsonMap['comic_id'];
    ModelComicDetailInfo.getInstance().creatorName = jsonMap['creator_name'];
    ModelComicDetailInfo.getInstance().mainTitleName = jsonMap['title'];
    ModelComicDetailInfo.getInstance().explain = jsonMap['explain'];
    //print('comicDetailInfo_explain : ${ModelComicDetailInfo.getInstance().explain}');
    ModelComicDetailInfo.getInstance().point = jsonMap['point'];
    ModelComicDetailInfo.getInstance().creatorId = jsonMap['creator_id'];

    //ModelComicDetailInfo.getInstance().representationImageUrl =
    //  await ModelPreset.getRepresentationVerticalImageDownloadUrl(ModelComicDetailInfo.getInstance().userId, ModelComicDetailInfo.getInstance().comicId );

    ModelComicDetailInfo.getInstance().representationImageUrl =
    await ModelPreset.getRepresentationHorizontalImageDownloadUrl(ModelComicDetailInfo.getInstance().userId, ModelComicDetailInfo.getInstance().comicId );

    if(null == ModelComicDetailInfo.getInstance().modelComicInfoList)
      ModelComicDetailInfo.getInstance().modelComicInfoList = new List<ModelComicInfo>();
    ModelComicDetailInfo.getInstance().modelComicInfoList.clear();

    //print('modelComicInfoList length1 : ${ModelComicDetailInfo.getInstance().modelComicInfoList.length}');

    int countIndex = 0;
    var comics = jsonMap['comics'];
    for(var key in comics.keys)
    {
      ModelComicInfo modelComicInfo = new ModelComicInfo();

      modelComicInfo.episodeId = comics[key.toString()]['episode_id'];
      modelComicInfo.subTitleName = comics[key.toString()]['title'];
      modelComicInfo.collected = comics[key.toString()]['collected'];
      modelComicInfo.updated = comics[key.toString()]['updated'];

      print('episode_id : ${modelComicInfo.episodeId}');

      modelComicInfo.userId = ModelComicDetailInfo.getInstance().userId;
      modelComicInfo.comicId = ModelComicDetailInfo.getInstance().comicId;

      modelComicInfo.thumbnailImageUrl =
      //await ModelPreset.getThumbnailImageDownloadUrl(ModelComicDetailInfo.getInstance().userId,
      //   ModelComicDetailInfo.getInstance().comicId,'001','001','00001');
      await ModelPreset.getRepresentationHorizontalImageDownloadUrl(ModelComicDetailInfo.getInstance().userId, ModelComicDetailInfo.getInstance().comicId);

      print('comicInfo_thumbnailImageURL[$countIndex] : ${modelComicInfo.thumbnailImageUrl}');
      ++countIndex;

      ModelComicDetailInfo.getInstance().modelComicInfoList.add(modelComicInfo);
    }

    //print('modelComicInfoList length2 : ${ModelComicDetailInfo.getInstance().modelComicInfoList.length}');

    //sort
    ModelComicDetailInfo.getInstance().modelComicInfoList.sort((a, b) => a.episodeId.compareTo(b.episodeId));

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
    ModelComicDetailInfo.getInstance().mainTitleName = readStringToByteBuffer();
    ModelComicDetailInfo.getInstance().explain = readStringToByteBuffer();
    print('comicDetailInfo_explain : ${ModelComicDetailInfo.getInstance().explain}');
    ModelComicDetailInfo.getInstance().point = getDouble();

    //ModelComicDetailInfo.getInstance().representationImageUrl =
    //  await ModelPreset.getRepresentationVerticalImageDownloadUrl(ModelComicDetailInfo.getInstance().userId, ModelComicDetailInfo.getInstance().comicId );

    ModelComicDetailInfo.getInstance().representationImageUrl =
      await ModelPreset.getRepresentationHorizontalImageDownloadUrl(ModelComicDetailInfo.getInstance().userId, ModelComicDetailInfo.getInstance().comicId );


    if(null == ModelComicDetailInfo.getInstance().modelComicInfoList)
      ModelComicDetailInfo.getInstance().modelComicInfoList = new List<ModelComicInfo>();
    else
      ModelComicDetailInfo.getInstance().modelComicInfoList.clear();

    int comicInfoCount = getUint32();
    print('comicInfoCount : $comicInfoCount');
    for(int countIndex=0; countIndex<comicInfoCount; ++countIndex)
    {
      ModelComicInfo modelComicInfo = new ModelComicInfo();

      modelComicInfo.episodeId = readStringToByteBuffer();
      modelComicInfo.subTitleName = readStringToByteBuffer();
      modelComicInfo.collected = getUint32();
      modelComicInfo.updated = getUint32();

      modelComicInfo.userId = ModelComicDetailInfo.getInstance().userId;
      modelComicInfo.comicId = ModelComicDetailInfo.getInstance().comicId;

      modelComicInfo.thumbnailImageUrl =
      //await ModelPreset.getThumbnailImageDownloadUrl(ModelComicDetailInfo.getInstance().userId,
       //   ModelComicDetailInfo.getInstance().comicId,'001','001','00001');

      await ModelPreset.getRepresentationHorizontalImageDownloadUrl(ModelComicDetailInfo.getInstance().userId, ModelComicDetailInfo.getInstance().comicId);

      print('comicInfo_thumbnailImageURL[$countIndex] : ${modelComicInfo.thumbnailImageUrl}');

      ModelComicDetailInfo.getInstance().modelComicInfoList.add(modelComicInfo);
    }

    if(null != onFetchDone)
      onFetchDone(this);

  }

}
