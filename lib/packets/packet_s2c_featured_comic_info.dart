import 'dart:typed_data';

import 'package:sparky/models/model_preset.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_featured_comic_info.dart';
import 'package:sparky/manage/manage_resource.dart';


class PacketS2CFeaturedComicInfo extends PacketS2CCommon
{

  PacketS2CFeaturedComicInfo()
  {
    type = e_packet_type.s2c_featured_comic_info;
  }


  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    //{1566811403000_000001: {title: 아비향, creator_name: 묵검향, comic_id: 000001, user_id: 1566811403000, creator_id: 1566811403000}, 1566811403000_000002: {title: 반야, creator_name: 묵검향, comic_id: 000002, user_id: 1566811403000, creator_id: 1566811403000}, 1566811443000_000001: {title: sample, creator_name: sample, comic_id: 000001, user_id: 1566811443000, creator_id: 1566811443000}, 1566811403000_000003: {title: 개구쟁이, creator_name: 묵검향, comic_id: 000003, user_id: 1566811403000, creator_id: 1566811403000}}

    List<ModelFeaturedComicInfo>  list = new List<ModelFeaturedComicInfo>();
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

        ModelFeaturedComicInfo modelFeaturedComicInfo = new ModelFeaturedComicInfo();

        modelFeaturedComicInfo.title = comicInfo['title'];
        modelFeaturedComicInfo.creatorName = comicInfo['creator_name'];
        modelFeaturedComicInfo.comicId = comicInfo['comic_id'];
        modelFeaturedComicInfo.userId = comicInfo['user_id'];
        modelFeaturedComicInfo.creatorId = comicInfo['creator_id'];

        String url = await ModelPreset.getBannerImageDownloadUrl(modelFeaturedComicInfo.userId, modelFeaturedComicInfo.comicId);
        modelFeaturedComicInfo.url = url;
        modelFeaturedComicInfo.thumbnailUrl = url;
        modelFeaturedComicInfo.image = await ManageResource.fetchImage(url);

        print(modelFeaturedComicInfo.toString());

        list.add(modelFeaturedComicInfo);

      }
    ModelFeaturedComicInfo.list = list;

    if(null != onFetchDone)
      onFetchDone(this);
  }


  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize,onFetchDone) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int modelFeaturedComicInfoCount = getUint32();
    print('modelFeaturedComicInfoCount : $modelFeaturedComicInfoCount');

    List<ModelFeaturedComicInfo>  list = new List<ModelFeaturedComicInfo>();

    for(int countIndex=0; countIndex<modelFeaturedComicInfoCount; ++countIndex)
    {
      ModelFeaturedComicInfo modelFeaturedComicInfo = new ModelFeaturedComicInfo();

      modelFeaturedComicInfo.userId = readStringToByteBuffer();
      modelFeaturedComicInfo.comicId = readStringToByteBuffer();
      modelFeaturedComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getBannerImageDownloadUrl(modelFeaturedComicInfo.userId, modelFeaturedComicInfo.comicId);
      modelFeaturedComicInfo.url = url;
      modelFeaturedComicInfo.thumbnailUrl = url;

      modelFeaturedComicInfo.image = await ManageResource.fetchImage(url);


      print(modelFeaturedComicInfo.toString());

      list.add(modelFeaturedComicInfo);
    }

    ModelFeaturedComicInfo.list = list;

    if(null != onFetchDone)
      onFetchDone(this);
  }

}