import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_library_owned_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';



class PacketS2CLibraryOwnedComicInfo extends PacketS2CCommon
{
  PacketS2CLibraryOwnedComicInfo()
  {
    type = e_packet_type.s2c_library_owned_comic_info;
  }

  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    //{1566811403000_000001: {title: 아비향, creator_name: 묵검향, comic_id: 000001, user_id: 1566811403000, creator_id: 1566811403000}, 1566811403000_000002: {title: 반야, creator_name: 묵검향, comic_id: 000002, user_id: 1566811403000, creator_id: 1566811403000}, 1566811443000_000001: {title: sample, creator_name: sample, comic_id: 000001, user_id: 1566811443000, creator_id: 1566811443000}, 1566811403000_000003: {title: 개구쟁이, creator_name: 묵검향, comic_id: 000003, user_id: 1566811403000, creator_id: 1566811403000}}
    status = e_packet_status.start_dispatch_respond;

    int countIndex = 0;
    bool switchFlag = false;
    List<ModelLibraryOwnedComicInfo> modelLibraryOwnedComicInfoList = null;
    if(true == switchFlag)
    {
      if(null == ModelLibraryOwnedComicInfo.list)
        ModelLibraryOwnedComicInfo.list = new List<ModelLibraryOwnedComicInfo>();
      else
        ModelLibraryOwnedComicInfo.list.clear();
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

      ModelLibraryOwnedComicInfo modelLibraryOwnedComicInfo = new ModelLibraryOwnedComicInfo();

      modelLibraryOwnedComicInfo.title = comicInfo['title'];
      modelLibraryOwnedComicInfo.creatorName = comicInfo['creator_name'];
      modelLibraryOwnedComicInfo.comicId = comicInfo['comic_id'];
      modelLibraryOwnedComicInfo.userId = comicInfo['user_id'];
      modelLibraryOwnedComicInfo.creatorId = comicInfo['creator_id'];

      String url = await ModelPreset.getRepresentationSquareImageDownloadUrl(modelLibraryOwnedComicInfo.userId, modelLibraryOwnedComicInfo.comicId);
      modelLibraryOwnedComicInfo.url = url;
      modelLibraryOwnedComicInfo.thumbnailUrl = url;
      modelLibraryOwnedComicInfo.image = await ManageResource.fetchImage(url);

      print(modelLibraryOwnedComicInfo.toString());

      if(false == switchFlag)
      {
        if(null == modelLibraryOwnedComicInfoList)
          modelLibraryOwnedComicInfoList = new List<ModelLibraryOwnedComicInfo>();
        modelLibraryOwnedComicInfoList.add(modelLibraryOwnedComicInfo);
      }
      else
      {
        ModelLibraryOwnedComicInfo.list.add(modelLibraryOwnedComicInfo);
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
      ModelLibraryOwnedComicInfo.list = modelLibraryOwnedComicInfoList;
    }

    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
  }

  //
  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize,onFetchDone) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int modelMyLockerComicOwnedCount = getUint32();
    print('modelMyLockerComicOwnedCount : $modelMyLockerComicOwnedCount');


    List<ModelLibraryOwnedComicInfo> list = new List<ModelLibraryOwnedComicInfo>();

    for(int countIndex=0; countIndex<modelMyLockerComicOwnedCount; ++countIndex)
    {
      ModelLibraryOwnedComicInfo modelLibraryOwnedComicInfo = new ModelLibraryOwnedComicInfo();

      modelLibraryOwnedComicInfo.userId = readStringToByteBuffer();
      modelLibraryOwnedComicInfo.comicId = readStringToByteBuffer();
      modelLibraryOwnedComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationSquareImageDownloadUrl(modelLibraryOwnedComicInfo.userId, modelLibraryOwnedComicInfo.comicId);
      modelLibraryOwnedComicInfo.url = url;
      modelLibraryOwnedComicInfo.thumbnailUrl = url;

      modelLibraryOwnedComicInfo.image = await ManageResource.fetchImage(url);

      print(modelLibraryOwnedComicInfo.toString());

      list.add(modelLibraryOwnedComicInfo);
    }

    ModelLibraryOwnedComicInfo.list = list;

    if(null != onFetchDone)
      onFetchDone(this);
  }
}