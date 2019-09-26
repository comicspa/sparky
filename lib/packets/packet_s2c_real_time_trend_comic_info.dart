import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_real_time_trend_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';

class PacketS2CRealTimeTrendComicInfo extends PacketS2CCommon
{
  PacketS2CRealTimeTrendComicInfo()
  {
    type = e_packet_type.s2c_real_time_trend_comic_info;
  }

  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int modelRealTimeTrendInfoCount = getUint32();
    print('modelRealTimeTrendInfoCount : $modelRealTimeTrendInfoCount');


    List<ModelRealTimeTrendComicInfo> list = new List<ModelRealTimeTrendComicInfo>();
    for(int countIndex=0; countIndex<modelRealTimeTrendInfoCount; ++countIndex)
    {
      ModelRealTimeTrendComicInfo modelRealTimeTrendInfo = new ModelRealTimeTrendComicInfo();

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

    ModelRealTimeTrendComicInfo.list = list;
  }
}