import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_real_time_trend_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';

class PacketS2CRealTimeTrendInfo extends PacketS2CCommon
{
  PacketS2CRealTimeTrendInfo()
  {
    type = e_packet_type.s2c_real_time_trend_info;
  }

  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int modelRealTimeTrendInfoCount = getUint32();
    print('modelRealTimeTrendInfoCount : $modelRealTimeTrendInfoCount');


    List<ModelRealTimeTrendInfo> list = new List<ModelRealTimeTrendInfo>();
    for(int countIndex=0; countIndex<modelRealTimeTrendInfoCount; ++countIndex)
    {
      ModelRealTimeTrendInfo modelRealTimeTrendInfo = new ModelRealTimeTrendInfo();

      modelRealTimeTrendInfo.userId = readStringToByteBuffer();
      modelRealTimeTrendInfo.comicId = readStringToByteBuffer();
      modelRealTimeTrendInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelRealTimeTrendInfo.userId, modelRealTimeTrendInfo.comicId);
      modelRealTimeTrendInfo.url = url;
      modelRealTimeTrendInfo.thumbnailUrl = url;

      modelRealTimeTrendInfo.image = await ManageResource.fetchImage(url);

      print(modelRealTimeTrendInfo.toString());

      list.add(modelRealTimeTrendInfo);
    }

    ModelRealTimeTrendInfo.list = list;
  }
}