import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_recommended_creator_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';

class PacketS2CRecommendedCreatorInfo extends PacketS2CCommon
{
  PacketS2CRecommendedCreatorInfo()
  {
    type = e_packet_type.s2c_recommended_creator_info;
  }


  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    //{1566811403000_000001: {title: 아비향, creator_name: 묵검향, comic_id: 000001, user_id: 1566811403000, creator_id: 1566811403000}, 1566811403000_000002: {title: 반야, creator_name: 묵검향, comic_id: 000002, user_id: 1566811403000, creator_id: 1566811403000}, 1566811443000_000001: {title: sample, creator_name: sample, comic_id: 000001, user_id: 1566811443000, creator_id: 1566811443000}, 1566811403000_000003: {title: 개구쟁이, creator_name: 묵검향, comic_id: 000003, user_id: 1566811403000, creator_id: 1566811403000}}
    status = e_packet_status.start_dispatch_respond;

    int countIndex = 0;
    bool switchFlag = false;
    List<ModelRecommendedCreatorInfo> modelRecommendedCreatorInfoList = null;
    if(true == switchFlag)
    {
      if(null == ModelRecommendedCreatorInfo.list)
        ModelRecommendedCreatorInfo.list = new List<ModelRecommendedCreatorInfo>();
      else
        ModelRecommendedCreatorInfo.list.clear();
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

      ModelRecommendedCreatorInfo modelRecommendedCreatorInfo = new ModelRecommendedCreatorInfo();

      modelRecommendedCreatorInfo.title = comicInfo['title'];
      modelRecommendedCreatorInfo.creatorName = comicInfo['creator_name'];
      modelRecommendedCreatorInfo.comicId = comicInfo['comic_id'];
      modelRecommendedCreatorInfo.userId = comicInfo['user_id'];
      modelRecommendedCreatorInfo.creatorId = comicInfo['creator_id'];

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelRecommendedCreatorInfo.userId, modelRecommendedCreatorInfo.comicId);
      modelRecommendedCreatorInfo.url = url;
      modelRecommendedCreatorInfo.thumbnailUrl = url;
      //modelRecommendedCreatorInfo.image = await ManageResource.fetchImage(url);

      print(modelRecommendedCreatorInfo.toString());

      if(false == switchFlag)
      {
        if(null == modelRecommendedCreatorInfoList)
          modelRecommendedCreatorInfoList = new List<ModelRecommendedCreatorInfo>();
        modelRecommendedCreatorInfoList.add(modelRecommendedCreatorInfo);
      }
      else
      {
        ModelRecommendedCreatorInfo.list.add(modelRecommendedCreatorInfo);
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
      ModelRecommendedCreatorInfo.list = modelRecommendedCreatorInfoList;
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

    int modelRecommendedCreatorInfoCount = getUint32();
    print('modelRecommendedCreatorInfoCount : $modelRecommendedCreatorInfoCount');


    List<ModelRecommendedCreatorInfo> list = new List<ModelRecommendedCreatorInfo>();
    for(int countIndex=0; countIndex<modelRecommendedCreatorInfoCount; ++countIndex)
    {
      ModelRecommendedCreatorInfo modelRecommendedCreatorInfo = new ModelRecommendedCreatorInfo();

      modelRecommendedCreatorInfo.userId = readStringToByteBuffer();
      modelRecommendedCreatorInfo.comicId = readStringToByteBuffer();
      modelRecommendedCreatorInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelRecommendedCreatorInfo.userId, modelRecommendedCreatorInfo.comicId);
      modelRecommendedCreatorInfo.url = url;
      modelRecommendedCreatorInfo.thumbnailUrl = url;

      //modelRecommendedCreatorInfo.image = await ManageResource.fetchImage(url);

      print(modelRecommendedCreatorInfo.toString());

      list.add(modelRecommendedCreatorInfo);
    }

    ModelRecommendedCreatorInfo.list = list;
  }

}