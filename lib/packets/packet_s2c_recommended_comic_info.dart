import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_recommended_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';


class PacketS2CRecommendedComicInfo extends PacketS2CCommon
{
  PacketS2CRecommendedComicInfo()
  {
    type = e_packet_type.s2c_recommended_comic_info;
  }

  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    //{1566811403000_000001: {title: 아비향, creator_name: 묵검향, comic_id: 000001, user_id: 1566811403000, creator_id: 1566811403000}, 1566811403000_000002: {title: 반야, creator_name: 묵검향, comic_id: 000002, user_id: 1566811403000, creator_id: 1566811403000}, 1566811443000_000001: {title: sample, creator_name: sample, comic_id: 000001, user_id: 1566811443000, creator_id: 1566811443000}, 1566811403000_000003: {title: 개구쟁이, creator_name: 묵검향, comic_id: 000003, user_id: 1566811403000, creator_id: 1566811403000}}

    List<ModelRecommendedComicInfo>  list = new List<ModelRecommendedComicInfo>();
    for(var key in jsonMap.keys)
    {
      print(key);
      List<String> splitList = key.toString().split('_');
      switch(splitList.length)
      {
        case 2:
          {
            //String creatorId = splitList[0];
            //String comicId = splitList[1];
          }
          break;

        default:
          continue;
      }

      var comicInfo = jsonMap[key];

      ModelRecommendedComicInfo modelRecommendedComicInfo = new ModelRecommendedComicInfo();

      modelRecommendedComicInfo.title = comicInfo['title'];
      modelRecommendedComicInfo.creatorName = comicInfo['creator_name'];
      modelRecommendedComicInfo.comicId = comicInfo['comic_id'];
      modelRecommendedComicInfo.userId = comicInfo['user_id'];
      modelRecommendedComicInfo.creatorId = comicInfo['creator_id'];

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelRecommendedComicInfo.userId, modelRecommendedComicInfo.comicId);
      modelRecommendedComicInfo.url = url;
      modelRecommendedComicInfo.thumbnailUrl = url;
      modelRecommendedComicInfo.image = await ManageResource.fetchImage(url);

      print(modelRecommendedComicInfo.toString());

      list.add(modelRecommendedComicInfo);

    }
    ModelRecommendedComicInfo.list = list;

    if(null != onFetchDone)
      onFetchDone(this);
  }

  //
  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize) async
  {
    print('[PacketS2CRecommendedComicInfo::parseBytes] start');
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int modelRecommendedComicInfoCount = getUint32();
    print('modelRecommendedComicInfoCount : $modelRecommendedComicInfoCount');


    List<ModelRecommendedComicInfo> list = new List<ModelRecommendedComicInfo>();
    for(int countIndex=0; countIndex<modelRecommendedComicInfoCount; ++countIndex)
    {
      ModelRecommendedComicInfo modelRecommendedComicInfo = new ModelRecommendedComicInfo();

      modelRecommendedComicInfo.userId = readStringToByteBuffer();
      modelRecommendedComicInfo.comicId = readStringToByteBuffer();
      modelRecommendedComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelRecommendedComicInfo.userId, modelRecommendedComicInfo.comicId);
      modelRecommendedComicInfo.url = url;
      modelRecommendedComicInfo.thumbnailUrl = url;

      modelRecommendedComicInfo.image = await ManageResource.fetchImage(url);

      print(modelRecommendedComicInfo.toString());

      list.add(modelRecommendedComicInfo);
    }

    ModelRecommendedComicInfo.list = list;
    print('[PacketS2CRecommendedComicInfo::parseBytes] finished');
  }

}