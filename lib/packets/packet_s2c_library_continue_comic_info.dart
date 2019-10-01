import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_library_continue_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';



class PacketS2CLibraryContinueComicInfo extends PacketS2CCommon
{
  PacketS2CLibraryContinueComicInfo()
  {
    type = e_packet_type.s2c_library_continue_comic_info;
  }

  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    //{1566811403000_000001: {title: 아비향, creator_name: 묵검향, comic_id: 000001, user_id: 1566811403000, creator_id: 1566811403000}, 1566811403000_000002: {title: 반야, creator_name: 묵검향, comic_id: 000002, user_id: 1566811403000, creator_id: 1566811403000}, 1566811443000_000001: {title: sample, creator_name: sample, comic_id: 000001, user_id: 1566811443000, creator_id: 1566811443000}, 1566811403000_000003: {title: 개구쟁이, creator_name: 묵검향, comic_id: 000003, user_id: 1566811403000, creator_id: 1566811403000}}

    List<ModelLibraryContinueComicInfo>  list = new List<ModelLibraryContinueComicInfo>();
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

      ModelLibraryContinueComicInfo modelLibraryContinueComicInfo = new ModelLibraryContinueComicInfo();

      modelLibraryContinueComicInfo.title = comicInfo['title'];
      modelLibraryContinueComicInfo.creatorName = comicInfo['creator_name'];
      modelLibraryContinueComicInfo.comicId = comicInfo['comic_id'];
      modelLibraryContinueComicInfo.userId = comicInfo['user_id'];
      modelLibraryContinueComicInfo.creatorId = comicInfo['creator_id'];

      String url = await ModelPreset.getBannerImageDownloadUrl(modelLibraryContinueComicInfo.userId, modelLibraryContinueComicInfo.comicId);
      modelLibraryContinueComicInfo.url = url;
      modelLibraryContinueComicInfo.thumbnailUrl = url;
      modelLibraryContinueComicInfo.image = await ManageResource.fetchImage(url);

      print(modelLibraryContinueComicInfo.toString());

      list.add(modelLibraryContinueComicInfo);

    }
    ModelLibraryContinueComicInfo.list = list;

    if(null != onFetchDone)
      onFetchDone(this);
  }

  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize,onFetchDone) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int modelMyLockerComicContinueCount = getUint32();
    print('modelMyLockerComicContinueCount : $modelMyLockerComicContinueCount');


    List<ModelLibraryContinueComicInfo> list = new List<ModelLibraryContinueComicInfo>();
    for(int countIndex=0; countIndex<modelMyLockerComicContinueCount; ++countIndex)
    {
      ModelLibraryContinueComicInfo modelLibraryContinueComicInfo = new ModelLibraryContinueComicInfo();

      modelLibraryContinueComicInfo.userId = readStringToByteBuffer();
      modelLibraryContinueComicInfo.comicId = readStringToByteBuffer();
      modelLibraryContinueComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationVerticalImageDownloadUrl(modelLibraryContinueComicInfo.userId, modelLibraryContinueComicInfo.comicId);
      modelLibraryContinueComicInfo.url = url;
      modelLibraryContinueComicInfo.thumbnailUrl = url;

      modelLibraryContinueComicInfo.image = await ManageResource.fetchImage(url);

      print(modelLibraryContinueComicInfo.toString());

      list.add(modelLibraryContinueComicInfo);

    }

    ModelLibraryContinueComicInfo.list = list;

    if(null != onFetchDone)
      onFetchDone(this);

  }

}