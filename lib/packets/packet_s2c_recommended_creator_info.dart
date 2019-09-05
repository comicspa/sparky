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

      modelRecommendedCreatorInfo.image = await ManageResource.fetchImage(url);

      print(modelRecommendedCreatorInfo.toString());

      list.add(modelRecommendedCreatorInfo);
    }

    ModelRecommendedCreatorInfo.list = list;
  }

}