import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_new_creator_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';

class PacketS2CNewCreatorInfo extends PacketS2CCommon
{
  PacketS2CNewCreatorInfo()
  {
    type = e_packet_type.s2c_new_creator_info;
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
      modelNewCreatorInfo.comicId = readStringToByteBuffer();
      modelNewCreatorInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelNewCreatorInfo.userId, modelNewCreatorInfo.comicId);
      modelNewCreatorInfo.url = url;
      modelNewCreatorInfo.thumbnailUrl = url;

      modelNewCreatorInfo.image = await ManageResource.fetchImage(url);

      print(modelNewCreatorInfo.toString());

      list.add(modelNewCreatorInfo);
    }

    ModelNewCreatorInfo.list = list;

  }

}