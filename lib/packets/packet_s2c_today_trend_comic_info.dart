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
    status = e_packet_status.start_dispatch_respond;

    int countIndex = 0;
    bool switchFlag = false;
    List<ModelTodayTrendComicInfo> modelTodayTrendComicInfoList = null;
    if(true == switchFlag)
    {
      if(null == ModelTodayTrendComicInfo.list)
        ModelTodayTrendComicInfo.list = new List<ModelTodayTrendComicInfo>();
      else
        ModelTodayTrendComicInfo.list.clear();
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

      ModelTodayTrendComicInfo modelTodayTrendComicInfo = new ModelTodayTrendComicInfo();

      modelTodayTrendComicInfo.titleName = comicInfo['title'];
      modelTodayTrendComicInfo.creatorName = comicInfo['creator_name'];
      modelTodayTrendComicInfo.comicNumber = comicInfo['comic_id'];
      //modelTodayTrendComicInfo.userId = comicInfo['user_id'];
      modelTodayTrendComicInfo.creatorId = comicInfo['creator_id'];

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelTodayTrendComicInfo.creatorId, modelTodayTrendComicInfo.comicNumber);
      modelTodayTrendComicInfo.url = url;

      print(modelTodayTrendComicInfo.toString());



      if(false == switchFlag)
      {
        if(null == modelTodayTrendComicInfoList)
          modelTodayTrendComicInfoList = new List<ModelTodayTrendComicInfo>();
        modelTodayTrendComicInfoList.add(modelTodayTrendComicInfo);
      }
      else
      {
        ModelTodayTrendComicInfo.list.add(modelTodayTrendComicInfo);
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
      ModelTodayTrendComicInfo.list = modelTodayTrendComicInfoList;
    }


    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
  }

  //
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

      modelTodayTrendComicInfo.creatorId = readStringToByteBuffer();
      modelTodayTrendComicInfo.comicNumber = readStringToByteBuffer();
      modelTodayTrendComicInfo.titleName = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelTodayTrendComicInfo.creatorId, modelTodayTrendComicInfo.comicNumber);
      modelTodayTrendComicInfo.url = url;

      print(modelTodayTrendComicInfo.toString());

      list.add(modelTodayTrendComicInfo);
    }

    ModelTodayTrendComicInfo.list = list;
  }

}