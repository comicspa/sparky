import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_weekly_creator_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';

class PacketS2CWeeklyCreatorInfo extends PacketS2CCommon
{
  PacketS2CWeeklyCreatorInfo()
  {
    type = e_packet_type.s2c_weekly_creator_info;
  }

  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    //{1566811403000_000001: {title: 아비향, creator_name: 묵검향, comic_id: 000001, user_id: 1566811403000, creator_id: 1566811403000}, 1566811403000_000002: {title: 반야, creator_name: 묵검향, comic_id: 000002, user_id: 1566811403000, creator_id: 1566811403000}, 1566811443000_000001: {title: sample, creator_name: sample, comic_id: 000001, user_id: 1566811443000, creator_id: 1566811443000}, 1566811403000_000003: {title: 개구쟁이, creator_name: 묵검향, comic_id: 000003, user_id: 1566811403000, creator_id: 1566811403000}}
    status = e_packet_status.start_dispatch_respond;

    int countIndex = 0;
    bool switchFlag = false;
    List<ModelWeeklyCreatorInfo> modelWeeklyCreatorInfoList = null;
    if(true == switchFlag)
    {
      if(null == ModelWeeklyCreatorInfo.list)
        ModelWeeklyCreatorInfo.list = new List<ModelWeeklyCreatorInfo>();
      else
        ModelWeeklyCreatorInfo.list.clear();
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

      ModelWeeklyCreatorInfo modelWeeklyCreatorInfo = new ModelWeeklyCreatorInfo();

      modelWeeklyCreatorInfo.titleName = comicInfo['title'];
      modelWeeklyCreatorInfo.creatorName = comicInfo['creator_name'];
      modelWeeklyCreatorInfo.comicNumber = comicInfo['comic_id'];
      modelWeeklyCreatorInfo.userId = comicInfo['user_id'];
      modelWeeklyCreatorInfo.creatorId = comicInfo['creator_id'];

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelWeeklyCreatorInfo.userId, modelWeeklyCreatorInfo.comicNumber);
      modelWeeklyCreatorInfo.url = url;

      print(modelWeeklyCreatorInfo.toString());

      if(false == switchFlag)
      {
        if(null == modelWeeklyCreatorInfoList)
          modelWeeklyCreatorInfoList = new List<ModelWeeklyCreatorInfo>();
        modelWeeklyCreatorInfoList.add(modelWeeklyCreatorInfo);
      }
      else
      {
        ModelWeeklyCreatorInfo.list.add(modelWeeklyCreatorInfo);
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
      ModelWeeklyCreatorInfo.list = modelWeeklyCreatorInfoList;
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

    int modelWeeklyCreatorInfoCount = getUint32();
    print('modelWeeklyCreatorInfoCount : $modelWeeklyCreatorInfoCount');


    List<ModelWeeklyCreatorInfo> list = new List<ModelWeeklyCreatorInfo>();
    for(int countIndex=0; countIndex<modelWeeklyCreatorInfoCount; ++countIndex)
    {
      ModelWeeklyCreatorInfo modelWeeklyCreatorInfo = new ModelWeeklyCreatorInfo();

      modelWeeklyCreatorInfo.userId = readStringToByteBuffer();
      modelWeeklyCreatorInfo.comicNumber = readStringToByteBuffer();
      modelWeeklyCreatorInfo.titleName = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelWeeklyCreatorInfo.userId, modelWeeklyCreatorInfo.comicNumber);
      modelWeeklyCreatorInfo.url = url;

      print(modelWeeklyCreatorInfo.toString());

      list.add(modelWeeklyCreatorInfo);
    }

    ModelWeeklyCreatorInfo.list = list;
  }

}