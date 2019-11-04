import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_weekly_trend_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';

class PacketS2CWeeklyTrendComicInfo extends PacketS2CCommon
{
  PacketS2CWeeklyTrendComicInfo()
  {
    type = e_packet_type.s2c_weekly_trend_comic_info;
  }

  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    //{1566811403000_000001: {title: 아비향, creator_name: 묵검향, comic_id: 000001, user_id: 1566811403000, creator_id: 1566811403000}, 1566811403000_000002: {title: 반야, creator_name: 묵검향, comic_id: 000002, user_id: 1566811403000, creator_id: 1566811403000}, 1566811443000_000001: {title: sample, creator_name: sample, comic_id: 000001, user_id: 1566811443000, creator_id: 1566811443000}, 1566811403000_000003: {title: 개구쟁이, creator_name: 묵검향, comic_id: 000003, user_id: 1566811403000, creator_id: 1566811403000}}
    status = e_packet_status.start_dispatch_respond;

    int countIndex = 0;
    bool switchFlag = false;
    List<ModelWeeklyTrendComicInfo>  modelWeeklyTrendComicInfoList = null;
    if(true == switchFlag)
    {
      if(null == ModelWeeklyTrendComicInfo.list)
        ModelWeeklyTrendComicInfo.list = new List<ModelWeeklyTrendComicInfo>();
      else
        ModelWeeklyTrendComicInfo.list.clear();
    }

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

      ModelWeeklyTrendComicInfo modelWeeklyTrendComicInfo = new ModelWeeklyTrendComicInfo();

      modelWeeklyTrendComicInfo.title = comicInfo['title'];
      modelWeeklyTrendComicInfo.creatorName = comicInfo['creator_name'];
      modelWeeklyTrendComicInfo.comicId = comicInfo['comic_id'];
      modelWeeklyTrendComicInfo.userId = comicInfo['user_id'];
      modelWeeklyTrendComicInfo.creatorId = comicInfo['creator_id'];

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelWeeklyTrendComicInfo.userId, modelWeeklyTrendComicInfo.comicId);
      modelWeeklyTrendComicInfo.url = url;
      modelWeeklyTrendComicInfo.thumbnailUrl = url;
      //modelWeeklyTrendComicInfo.image = await ManageResource.fetchImage(url);

      print(modelWeeklyTrendComicInfo.toString());

      if(false == switchFlag)
      {
        if(null == modelWeeklyTrendComicInfoList)
          modelWeeklyTrendComicInfoList = new List<ModelWeeklyTrendComicInfo>();
        modelWeeklyTrendComicInfoList.add(modelWeeklyTrendComicInfo);
      }
      else
      {
        ModelWeeklyTrendComicInfo.list.add(modelWeeklyTrendComicInfo);
        if(0 == countIndex % 3)
        {
          if (null != onFetchDone)
            onFetchDone(this);
        }
      }

      ++ countIndex;

    }

    if(false == switchFlag)
    {
      ModelWeeklyTrendComicInfo.list = modelWeeklyTrendComicInfoList;
    }

    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
  }

  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int weeklyPopularComicInfoCount = getUint32();
    print('weeklyPopularComicInfoCount : $weeklyPopularComicInfoCount');


    List<ModelWeeklyTrendComicInfo> list = new List<ModelWeeklyTrendComicInfo>();
    for(int countIndex=0; countIndex<weeklyPopularComicInfoCount; ++countIndex)
    {
      ModelWeeklyTrendComicInfo modelWeeklyTrendComicInfo = new ModelWeeklyTrendComicInfo();

      modelWeeklyTrendComicInfo.userId = readStringToByteBuffer();
      modelWeeklyTrendComicInfo.comicId = readStringToByteBuffer();
      modelWeeklyTrendComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelWeeklyTrendComicInfo.userId, modelWeeklyTrendComicInfo.comicId);
      modelWeeklyTrendComicInfo.url = url;
      modelWeeklyTrendComicInfo.thumbnailUrl = url;

      //modelWeeklyTrendComicInfo.image = await ManageResource.fetchImage(url);

      print(modelWeeklyTrendComicInfo.toString());

      list.add(modelWeeklyTrendComicInfo);
    }

    ModelWeeklyTrendComicInfo.list = list;
  }

}