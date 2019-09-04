import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_weekly_creator_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';

class PacketS2CWeeklyCreatorInfo extends PacketS2CCommon
{
  PacketS2CWeeklyCreatorInfo()
  {
    type = e_packet_type.s2c_weekly_creator_info;
  }

  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int modelWeeklyCreatorInfoCount = getUint32();
    print('modelWeeklyCreatorInfoCount : $modelWeeklyCreatorInfoCount');


    List<ModelWeeklyCreatorInfo> list = new List<ModelWeeklyCreatorInfo>();
    for(int countIndex=0; countIndex<modelWeeklyCreatorInfoCount; ++countIndex)
    {
      ModelWeeklyCreatorInfo modelWeeklyCreatorInfo = new ModelWeeklyCreatorInfo();

      modelWeeklyCreatorInfo.userId = readStringToByteBuffer();
      modelWeeklyCreatorInfo.comicId = readStringToByteBuffer();
      modelWeeklyCreatorInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelWeeklyCreatorInfo.userId, modelWeeklyCreatorInfo.comicId);
      modelWeeklyCreatorInfo.url = url;
      modelWeeklyCreatorInfo.thumbnailUrl = url;

      modelWeeklyCreatorInfo.image = await ManageResource.fetchImage(url);

      print(modelWeeklyCreatorInfo.toString());

      list.add(modelWeeklyCreatorInfo);
    }

    ModelWeeklyCreatorInfo.list = list;
  }

}