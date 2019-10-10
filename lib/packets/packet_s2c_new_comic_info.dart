import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_new_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';


class PacketS2CNewComicInfo extends PacketS2CCommon
{
  PacketS2CNewComicInfo()
  {
    type = e_packet_type.s2c_new_comic_info;
  }

  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    //{1566811403000_000001: {title: 아비향, creator_name: 묵검향, comic_id: 000001, user_id: 1566811403000, creator_id: 1566811403000}, 1566811403000_000002: {title: 반야, creator_name: 묵검향, comic_id: 000002, user_id: 1566811403000, creator_id: 1566811403000}, 1566811443000_000001: {title: sample, creator_name: sample, comic_id: 000001, user_id: 1566811443000, creator_id: 1566811443000}, 1566811403000_000003: {title: 개구쟁이, creator_name: 묵검향, comic_id: 000003, user_id: 1566811403000, creator_id: 1566811403000}}

    List<ModelNewComicInfo>  list = new List<ModelNewComicInfo>();
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

      ModelNewComicInfo modelNewComicInfo = new ModelNewComicInfo();

      modelNewComicInfo.title = comicInfo['title'];
      modelNewComicInfo.creatorName = comicInfo['creator_name'];
      modelNewComicInfo.comicId = comicInfo['comic_id'];
      modelNewComicInfo.userId = comicInfo['user_id'];
      modelNewComicInfo.creatorId = comicInfo['creator_id'];

      String url = await ModelPreset.getRepresentationVerticalImageDownloadUrl(modelNewComicInfo.userId, modelNewComicInfo.comicId);
      modelNewComicInfo.url = url;
      modelNewComicInfo.thumbnailUrl = url;
      modelNewComicInfo.image = await ManageResource.fetchImage(url);

      print(modelNewComicInfo.toString());

      list.add(modelNewComicInfo);

    }
    ModelNewComicInfo.list = list;

    if(null != onFetchDone)
      onFetchDone(this);
  }

  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int modelNewComicInfoCount = getUint32();
    print('modelNewComicInfoCount : $modelNewComicInfoCount');

    List<ModelNewComicInfo> list = new List<ModelNewComicInfo>();
    for(int countIndex=0; countIndex<modelNewComicInfoCount; ++countIndex)
    {
      ModelNewComicInfo modelNewComicInfo = new ModelNewComicInfo();

      modelNewComicInfo.userId = readStringToByteBuffer();
      modelNewComicInfo.comicId = readStringToByteBuffer();
      modelNewComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelNewComicInfo.userId, modelNewComicInfo.comicId);
      modelNewComicInfo.url = url;
      modelNewComicInfo.thumbnailUrl = url;

      modelNewComicInfo.image = await ManageResource.fetchImage(url);

      print(modelNewComicInfo.toString());

      list.add(modelNewComicInfo);
    }

    ModelNewComicInfo.list = list;
  }
}