import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_new_creator_info.dart';
import 'package:sparky/models/model_preset.dart';


class PacketS2CNewCreatorInfo extends PacketS2CCommon
{
  PacketS2CNewCreatorInfo()
  {
    type = e_packet_type.s2c_new_creator_info;
  }

  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    //{1566811403000_000001: {title: 아비향, creator_name: 묵검향, comic_id: 000001, user_id: 1566811403000, creator_id: 1566811403000}, 1566811403000_000002: {title: 반야, creator_name: 묵검향, comic_id: 000002, user_id: 1566811403000, creator_id: 1566811403000}, 1566811443000_000001: {title: sample, creator_name: sample, comic_id: 000001, user_id: 1566811443000, creator_id: 1566811443000}, 1566811403000_000003: {title: 개구쟁이, creator_name: 묵검향, comic_id: 000003, user_id: 1566811403000, creator_id: 1566811403000}}
    status = e_packet_status.start_dispatch_respond;

    int countIndex = 0;
    bool switchFlag = false;
    List<ModelNewCreatorInfo> modelNewCreatorInfoList = null;
    if(true == switchFlag)
    {
      if(null == ModelNewCreatorInfo.list )
        ModelNewCreatorInfo.list = new List<ModelNewCreatorInfo>();
      else
        ModelNewCreatorInfo.list.clear();
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

      ModelNewCreatorInfo modelNewCreatorInfo = new ModelNewCreatorInfo();

      modelNewCreatorInfo.titleName = comicInfo['title'];
      modelNewCreatorInfo.creatorName = comicInfo['creator_name'];
      modelNewCreatorInfo.comicNumber = comicInfo['comic_id'];
      modelNewCreatorInfo.userId = comicInfo['user_id'];
      modelNewCreatorInfo.creatorId = comicInfo['creator_id'];

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelNewCreatorInfo.userId, modelNewCreatorInfo.comicNumber);
      modelNewCreatorInfo.url = url;

      print(modelNewCreatorInfo.toString());



      if(false == switchFlag)
      {
        if(null == modelNewCreatorInfoList)
          modelNewCreatorInfoList = new List<ModelNewCreatorInfo>();
        modelNewCreatorInfoList.add(modelNewCreatorInfo);
      }
      else
      {
        ModelNewCreatorInfo.list.add(modelNewCreatorInfo);
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
      ModelNewCreatorInfo.list = modelNewCreatorInfoList;
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

    int modelNewCreatorInfoCount = getUint32();
    print('modelNewCreatorInfoCount : $modelNewCreatorInfoCount');

    List<ModelNewCreatorInfo> list = new List<ModelNewCreatorInfo>();
    for(int countIndex=0; countIndex<modelNewCreatorInfoCount; ++countIndex)
    {
      ModelNewCreatorInfo modelNewCreatorInfo = new ModelNewCreatorInfo();

      modelNewCreatorInfo.userId = readStringToByteBuffer();
      modelNewCreatorInfo.comicNumber = readStringToByteBuffer();
      modelNewCreatorInfo.titleName = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelNewCreatorInfo.userId, modelNewCreatorInfo.comicNumber);
      modelNewCreatorInfo.url = url;
      print(modelNewCreatorInfo.toString());

      list.add(modelNewCreatorInfo);
    }

    ModelNewCreatorInfo.list = list;

  }

}