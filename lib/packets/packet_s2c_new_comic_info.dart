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