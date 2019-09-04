import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_recommended_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';


class PacketS2CRecommendedComicInfo extends PacketS2CCommon
{
  PacketS2CRecommendedComicInfo()
  {
    type = e_packet_type.s2c_recommended_comic_info;
  }

  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize) async
  {
    print('[PacketS2CRecommendedComicInfo::parseBytes] start');
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int modelRecommendedComicInfoCount = getUint32();
    print('modelRecommendedComicInfoCount : $modelRecommendedComicInfoCount');


    List<ModelRecommendedComicInfo> list = new List<ModelRecommendedComicInfo>();
    for(int countIndex=0; countIndex<modelRecommendedComicInfoCount; ++countIndex)
    {
      ModelRecommendedComicInfo modelRecommendedComicInfo = new ModelRecommendedComicInfo();

      modelRecommendedComicInfo.userId = readStringToByteBuffer();
      modelRecommendedComicInfo.comicId = readStringToByteBuffer();
      modelRecommendedComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelRecommendedComicInfo.userId, modelRecommendedComicInfo.comicId);
      modelRecommendedComicInfo.url = url;
      modelRecommendedComicInfo.thumbnailUrl = url;

      modelRecommendedComicInfo.image = await ManageResource.fetchImage(url);

      print(modelRecommendedComicInfo.toString());

      list.add(modelRecommendedComicInfo);
    }

    ModelRecommendedComicInfo.list = list;
    print('[PacketS2CRecommendedComicInfo::parseBytes] finished');
  }

}