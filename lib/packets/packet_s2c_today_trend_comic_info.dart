import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_today_trend_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';


class PacketS2CTodayTrendComicInfo extends PacketS2CCommon
{
  PacketS2CTodayTrendComicInfo()
  {
    type = e_packet_type.s2c_today_trend_comic_info;
  }

  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    //{1566811403000_000001: {title: 아비향, creator_name: 묵검향, comic_id: 000001, user_id: 1566811403000, creator_id: 1566811403000}, 1566811403000_000002: {title: 반야, creator_name: 묵검향, comic_id: 000002, user_id: 1566811403000, creator_id: 1566811403000}, 1566811443000_000001: {title: sample, creator_name: sample, comic_id: 000001, user_id: 1566811443000, creator_id: 1566811443000}, 1566811403000_000003: {title: 개구쟁이, creator_name: 묵검향, comic_id: 000003, user_id: 1566811403000, creator_id: 1566811403000}}

    List<ModelTodayTrendComicInfo>  list = new List<ModelTodayTrendComicInfo>();
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

      ModelTodayTrendComicInfo modelTodayTrendComicInfo = new ModelTodayTrendComicInfo();

      modelTodayTrendComicInfo.title = comicInfo['title'];
      modelTodayTrendComicInfo.creatorName = comicInfo['creator_name'];
      modelTodayTrendComicInfo.comicId = comicInfo['comic_id'];
      modelTodayTrendComicInfo.userId = comicInfo['user_id'];
      modelTodayTrendComicInfo.creatorId = comicInfo['creator_id'];

      String url = await ModelPreset.getBannerImageDownloadUrl(modelTodayTrendComicInfo.userId, modelTodayTrendComicInfo.comicId);
      modelTodayTrendComicInfo.url = url;
      modelTodayTrendComicInfo.thumbnailUrl = url;
      modelTodayTrendComicInfo.image = await ManageResource.fetchImage(url);

      print(modelTodayTrendComicInfo.toString());

      list.add(modelTodayTrendComicInfo);

    }
    ModelTodayTrendComicInfo.list = list;

    if(null != onFetchDone)
      onFetchDone(this);
  }

  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int todayPopularComicInfoCount = getUint32();
    print('todayPopularComicInfoCount : $todayPopularComicInfoCount');


    List<ModelTodayTrendComicInfo> list = new List<ModelTodayTrendComicInfo>();
    for(int countIndex=0; countIndex<todayPopularComicInfoCount; ++countIndex)
    {
      ModelTodayTrendComicInfo modelTodayTrendComicInfo = new ModelTodayTrendComicInfo();

      modelTodayTrendComicInfo.userId = readStringToByteBuffer();
      modelTodayTrendComicInfo.comicId = readStringToByteBuffer();
      modelTodayTrendComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelTodayTrendComicInfo.userId, modelTodayTrendComicInfo.comicId);
      modelTodayTrendComicInfo.url = url;
      modelTodayTrendComicInfo.thumbnailUrl = url;

      modelTodayTrendComicInfo.image = await ManageResource.fetchImage(url);

      print(modelTodayTrendComicInfo.toString());

      list.add(modelTodayTrendComicInfo);
    }

    ModelTodayTrendComicInfo.list = list;
  }

}