import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_weekly_trend_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';

class PacketS2CWeeklyTrendComicInfo extends PacketS2CCommon
{
  PacketS2CWeeklyTrendComicInfo()
  {
    type = e_packet_type.s2c_weekly_trend_comic_info;
  }

  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int weeklyPopularComicInfoCount = getUint32();
    print('weeklyPopularComicInfoCount : $weeklyPopularComicInfoCount');


    List<ModelWeeklyTrendComicInfo> list = new List<ModelWeeklyTrendComicInfo>();
    for(int countIndex=0; countIndex<weeklyPopularComicInfoCount; ++countIndex)
    {
      ModelWeeklyTrendComicInfo modelWeeklyTrendComicInfo = new ModelWeeklyTrendComicInfo();

      modelWeeklyTrendComicInfo.userId = readStringToByteBuffer();
      modelWeeklyTrendComicInfo.comicId = readStringToByteBuffer();
      modelWeeklyTrendComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelWeeklyTrendComicInfo.userId, modelWeeklyTrendComicInfo.comicId);
      modelWeeklyTrendComicInfo.url = url;
      modelWeeklyTrendComicInfo.thumbnailUrl = url;

      modelWeeklyTrendComicInfo.image = await ManageResource.fetchImage(url);

      print(modelWeeklyTrendComicInfo.toString());

      list.add(modelWeeklyTrendComicInfo);
    }

    ModelWeeklyTrendComicInfo.list = list;
  }

}