import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_library_recent_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';


class PacketS2CLibraryRecentComicInfo extends PacketS2CCommon
{
  PacketS2CLibraryRecentComicInfo()
  {
    type = e_packet_type.s2c_library_recent_comic_info;
  }

  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    //{1566811403000_000001: {title: 아비향, creator_name: 묵검향, comic_id: 000001, user_id: 1566811403000, creator_id: 1566811403000}, 1566811403000_000002: {title: 반야, creator_name: 묵검향, comic_id: 000002, user_id: 1566811403000, creator_id: 1566811403000}, 1566811443000_000001: {title: sample, creator_name: sample, comic_id: 000001, user_id: 1566811443000, creator_id: 1566811443000}, 1566811403000_000003: {title: 개구쟁이, creator_name: 묵검향, comic_id: 000003, user_id: 1566811403000, creator_id: 1566811403000}}
    status = e_packet_status.start_dispatch_respond;

    int countIndex = 0;
    bool switchFlag = false;
    List<ModelLibraryRecentComicInfo> modelLibraryRecentComicInfoList = null;
    if(true == switchFlag)
    {
      if(null == ModelLibraryRecentComicInfo.list)
        ModelLibraryRecentComicInfo.list = new List<ModelLibraryRecentComicInfo>();
      else
        ModelLibraryRecentComicInfo.list.clear();
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

      ModelLibraryRecentComicInfo modelLibraryRecentComicInfo = new ModelLibraryRecentComicInfo();

      modelLibraryRecentComicInfo.title = comicInfo['title'];
      modelLibraryRecentComicInfo.creatorName = comicInfo['creator_name'];
      modelLibraryRecentComicInfo.comicId = comicInfo['comic_id'];
      modelLibraryRecentComicInfo.userId = comicInfo['user_id'];
      modelLibraryRecentComicInfo.creatorId = comicInfo['creator_id'];

      String url = await ModelPreset.getRepresentationSquareImageDownloadUrl(modelLibraryRecentComicInfo.userId, modelLibraryRecentComicInfo.comicId);
      modelLibraryRecentComicInfo.url = url;
      modelLibraryRecentComicInfo.thumbnailUrl = url;
      //modelLibraryRecentComicInfo.image = await ManageResource.fetchImage(url);

      print(modelLibraryRecentComicInfo.toString());

      if(false == switchFlag)
      {
        if(null == modelLibraryRecentComicInfoList)
          modelLibraryRecentComicInfoList = new List<ModelLibraryRecentComicInfo>();
        modelLibraryRecentComicInfoList.add(modelLibraryRecentComicInfo);
      }
      else
      {
        ModelLibraryRecentComicInfo.list.add(modelLibraryRecentComicInfo);
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
      ModelLibraryRecentComicInfo.list = modelLibraryRecentComicInfoList;
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

    int modelMyLockerComicRecentCount = getUint32();
    print('modelMyLockerComicRecentCount : $modelMyLockerComicRecentCount');


    List<ModelLibraryRecentComicInfo> list = new List<ModelLibraryRecentComicInfo>();

    for(int countIndex=0; countIndex<modelMyLockerComicRecentCount; ++countIndex)
    {
      ModelLibraryRecentComicInfo modelLibraryRecentComicInfo = new ModelLibraryRecentComicInfo();

      modelLibraryRecentComicInfo.userId = readStringToByteBuffer();
      modelLibraryRecentComicInfo.comicId = readStringToByteBuffer();
      modelLibraryRecentComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationSquareImageDownloadUrl(modelLibraryRecentComicInfo.userId, modelLibraryRecentComicInfo.comicId);
      modelLibraryRecentComicInfo.url = url;
      modelLibraryRecentComicInfo.thumbnailUrl = url;

      modelLibraryRecentComicInfo.image = await ManageResource.fetchImage(url);

      print(modelLibraryRecentComicInfo.toString());

      list.add(modelLibraryRecentComicInfo);
    }

    ModelLibraryRecentComicInfo.list = list;

    if(null != onFetchDone)
      onFetchDone(this);
  }

}