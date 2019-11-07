import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_library_view_list_comic_info.dart';
import 'package:sparky/models/model_preset.dart';



class PacketS2CLibraryViewListComicInfo extends PacketS2CCommon
{
  PacketS2CLibraryViewListComicInfo()
  {
    type = e_packet_type.s2c_library_view_list_comic_info;
  }

  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    //{1566811403000_000001: {title: 아비향, creator_name: 묵검향, comic_id: 000001, user_id: 1566811403000, creator_id: 1566811403000}, 1566811403000_000002: {title: 반야, creator_name: 묵검향, comic_id: 000002, user_id: 1566811403000, creator_id: 1566811403000}, 1566811443000_000001: {title: sample, creator_name: sample, comic_id: 000001, user_id: 1566811443000, creator_id: 1566811443000}, 1566811403000_000003: {title: 개구쟁이, creator_name: 묵검향, comic_id: 000003, user_id: 1566811403000, creator_id: 1566811403000}}
    status = e_packet_status.start_dispatch_respond;

    int countIndex = 0;
    bool switchFlag = false;
    List<ModelLibraryViewListComicInfo> modelLibraryViewListComicInfoList = null;
    if(true == switchFlag)
    {
      if(null == ModelLibraryViewListComicInfo.list )
        ModelLibraryViewListComicInfo.list  = new List<ModelLibraryViewListComicInfo>();
      else
        ModelLibraryViewListComicInfo.list .clear();
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

      ModelLibraryViewListComicInfo modelLibraryViewListComicInfo = new ModelLibraryViewListComicInfo();

      modelLibraryViewListComicInfo.title = comicInfo['title'];
      modelLibraryViewListComicInfo.creatorName = comicInfo['creator_name'];
      modelLibraryViewListComicInfo.comicId = comicInfo['comic_id'];
      modelLibraryViewListComicInfo.userId = comicInfo['user_id'];
      modelLibraryViewListComicInfo.creatorId = comicInfo['creator_id'];

      String url = await ModelPreset.getRepresentationSquareImageDownloadUrl(modelLibraryViewListComicInfo.userId, modelLibraryViewListComicInfo.comicId);
      modelLibraryViewListComicInfo.url = url;

      print(modelLibraryViewListComicInfo.toString());


      if(false == switchFlag)
      {
        if(null == modelLibraryViewListComicInfoList)
          modelLibraryViewListComicInfoList = new List<ModelLibraryViewListComicInfo>();
        modelLibraryViewListComicInfoList.add(modelLibraryViewListComicInfo);
      }
      else
      {
        ModelLibraryViewListComicInfo.list .add(modelLibraryViewListComicInfo);
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
      ModelLibraryViewListComicInfo.list = modelLibraryViewListComicInfoList;
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

    int modelMyLockerComicViewListCount = getUint32();
    print('modelMyLockerComicViewListCount : $modelMyLockerComicViewListCount');


    List<ModelLibraryViewListComicInfo> list = new List<ModelLibraryViewListComicInfo>();

    for(int countIndex=0; countIndex<modelMyLockerComicViewListCount; ++countIndex)
    {
      ModelLibraryViewListComicInfo modelLibraryViewListComicInfo = new ModelLibraryViewListComicInfo();

      modelLibraryViewListComicInfo.userId = readStringToByteBuffer();
      modelLibraryViewListComicInfo.comicId = readStringToByteBuffer();
      modelLibraryViewListComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationSquareImageDownloadUrl(modelLibraryViewListComicInfo.userId, modelLibraryViewListComicInfo.comicId);
      modelLibraryViewListComicInfo.url = url;


      print(modelLibraryViewListComicInfo.toString());

      list.add(modelLibraryViewListComicInfo);
    }

    ModelLibraryViewListComicInfo.list = list;

    if(null != onFetchDone)
      onFetchDone(this);

  }

}