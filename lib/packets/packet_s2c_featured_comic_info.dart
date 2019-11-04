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
    status = e_packet_status.start_dispatch_respond;

    int countIndex = 0;

    bool switchFlag = true;
    List<ModelFeaturedComicInfo> modelFeaturedComicInfoList = null;
    if(true == switchFlag)
    {
      if (null == ModelFeaturedComicInfo.list)
        ModelFeaturedComicInfo.list = new List<ModelFeaturedComicInfo>();
      else
        ModelFeaturedComicInfo.list.clear();
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

        ModelFeaturedComicInfo modelFeaturedComicInfo = new ModelFeaturedComicInfo();

        modelFeaturedComicInfo.title = comicInfo['title'];
        modelFeaturedComicInfo.creatorName = comicInfo['creator_name'];
        modelFeaturedComicInfo.comicId = comicInfo['comic_id'];
        modelFeaturedComicInfo.userId = comicInfo['user_id'];
        modelFeaturedComicInfo.creatorId = comicInfo['creator_id'];

        String url = await ModelPreset.getBannerImageDownloadUrl(modelFeaturedComicInfo.userId, modelFeaturedComicInfo.comicId);
        modelFeaturedComicInfo.url = url;
        modelFeaturedComicInfo.thumbnailUrl = url;
        //modelFeaturedComicInfo.image = await ManageResource.fetchImage(url);

        print(modelFeaturedComicInfo.toString());

        if(false == switchFlag)
          {
            if(null == modelFeaturedComicInfoList)
              modelFeaturedComicInfoList = new List<ModelFeaturedComicInfo>();
            modelFeaturedComicInfoList.add(modelFeaturedComicInfo);
          }
        else
          {
            ModelFeaturedComicInfo.list.add(modelFeaturedComicInfo);
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
      ModelFeaturedComicInfo.list = modelFeaturedComicInfoList;
    }

    status = e_packet_status.finish_dispatch_respond;
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

      //modelFeaturedComicInfo.image = await ManageResource.fetchImage(url);


      print(modelFeaturedComicInfo.toString());

      list.add(modelFeaturedComicInfo);
    }

    ModelFeaturedComicInfo.list = list;

    if(null != onFetchDone)
      onFetchDone(this);
  }

}