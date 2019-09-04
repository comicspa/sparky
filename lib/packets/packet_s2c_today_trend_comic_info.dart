import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_today_trend_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';


class PacketS2CTodayTrendComicInfo extends PacketS2CCommon
{
  PacketS2CTodayTrendComicInfo()
  {
    type = e_packet_type.s2c_today_trend_comic_info;
  }

  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int todayPopularComicInfoCount = getUint32();
    print('todayPopularComicInfoCount : $todayPopularComicInfoCount');


    List<ModelTodayTrendComicInfo> list = new List<ModelTodayTrendComicInfo>();
    for(int countIndex=0; countIndex<todayPopularComicInfoCount; ++countIndex)
    {
      ModelTodayTrendComicInfo modelTodayTrendComicInfo = new ModelTodayTrendComicInfo();

      modelTodayTrendComicInfo.userId = readStringToByteBuffer();
      modelTodayTrendComicInfo.comicId = readStringToByteBuffer();
      modelTodayTrendComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelTodayTrendComicInfo.userId, modelTodayTrendComicInfo.comicId);
      modelTodayTrendComicInfo.url = url;
      modelTodayTrendComicInfo.thumbnailUrl = url;

      modelTodayTrendComicInfo.image = await ManageResource.fetchImage(url);

      print(modelTodayTrendComicInfo.toString());

      list.add(modelTodayTrendComicInfo);
    }

    ModelTodayTrendComicInfo.list = list;
  }

}