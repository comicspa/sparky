import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_real_time_trend_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';

class PacketS2CRealTimeTrendComicInfo extends PacketS2CCommon
{
  PacketS2CRealTimeTrendComicInfo()
  {
    type = e_packet_type.s2c_real_time_trend_comic_info;
  }

  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    //{1566811403000_000001: {title: 아비향, creator_name: 묵검향, comic_id: 000001, user_id: 1566811403000, creator_id: 1566811403000}, 1566811403000_000002: {title: 반야, creator_name: 묵검향, comic_id: 000002, user_id: 1566811403000, creator_id: 1566811403000}, 1566811443000_000001: {title: sample, creator_name: sample, comic_id: 000001, user_id: 1566811443000, creator_id: 1566811443000}, 1566811403000_000003: {title: 개구쟁이, creator_name: 묵검향, comic_id: 000003, user_id: 1566811403000, creator_id: 1566811403000}}
    status = e_packet_status.start_dispatch_respond;

    int countIndex = 0;
    bool switchFlag = false;
    List<ModelRealTimeTrendComicInfo> modelRealTimeTrendComicInfoList = null;
    if(true == switchFlag)
    {
      if(null == ModelRealTimeTrendComicInfo.list)
        ModelRealTimeTrendComicInfo.list = new List<ModelRealTimeTrendComicInfo>();
      else
        ModelRealTimeTrendComicInfo.list.clear();
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

      ModelRealTimeTrendComicInfo modelRealTimeTrendComicInfo = new ModelRealTimeTrendComicInfo();

      modelRealTimeTrendComicInfo.title = comicInfo['title'];
      modelRealTimeTrendComicInfo.creatorName = comicInfo['creator_name'];
      modelRealTimeTrendComicInfo.comicId = comicInfo['comic_id'];
      modelRealTimeTrendComicInfo.userId = comicInfo['user_id'];
      modelRealTimeTrendComicInfo.creatorId = comicInfo['creator_id'];

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelRealTimeTrendComicInfo.userId, modelRealTimeTrendComicInfo.comicId);
      modelRealTimeTrendComicInfo.url = url;
      modelRealTimeTrendComicInfo.thumbnailUrl = url;
      //modelRealTimeTrendComicInfo.image = await ManageResource.fetchImage(url);

      print(modelRealTimeTrendComicInfo.toString());


      if(false == switchFlag)
      {
        if(null == modelRealTimeTrendComicInfoList)
          modelRealTimeTrendComicInfoList = new List<ModelRealTimeTrendComicInfo>();
        modelRealTimeTrendComicInfoList.add(modelRealTimeTrendComicInfo);
      }
      else
      {
        ModelRealTimeTrendComicInfo.list.add(modelRealTimeTrendComicInfo);
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
      ModelRealTimeTrendComicInfo.list = modelRealTimeTrendComicInfoList;
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

    int modelRealTimeTrendInfoCount = getUint32();
    print('modelRealTimeTrendInfoCount : $modelRealTimeTrendInfoCount');


    List<ModelRealTimeTrendComicInfo> list = new List<ModelRealTimeTrendComicInfo>();
    for(int countIndex=0; countIndex<modelRealTimeTrendInfoCount; ++countIndex)
    {
      ModelRealTimeTrendComicInfo modelRealTimeTrendInfo = new ModelRealTimeTrendComicInfo();

      modelRealTimeTrendInfo.userId = readStringToByteBuffer();
      modelRealTimeTrendInfo.comicId = readStringToByteBuffer();
      modelRealTimeTrendInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelRealTimeTrendInfo.userId, modelRealTimeTrendInfo.comicId);
      modelRealTimeTrendInfo.url = url;
      modelRealTimeTrendInfo.thumbnailUrl = url;

      //modelRealTimeTrendInfo.image = await ManageResource.fetchImage(url);

      print(modelRealTimeTrendInfo.toString());

      list.add(modelRealTimeTrendInfo);
    }

    ModelRealTimeTrendComicInfo.list = list;
  }
}