
import 'dart:typed_data';


import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/models/model_featured_comic_info.dart';
import 'package:sparky/models/model_recommended_comic_info.dart';
import 'package:sparky/models/model_real_time_trend_comic_info.dart';
import 'package:sparky/models/model_new_comic_info.dart';
import 'package:sparky/models/model_today_trend_comic_info.dart';
import 'package:sparky/models/model_weekly_trend_comic_info.dart';




class PacketS2CPresetComicInfo extends PacketS2CCommon
{
  PacketS2CPresetComicInfo()
  {
    type = e_packet_type.s2c_preset_comic_info;
  }


  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize,onFetchDone) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int modelFeaturedComicInfoCount = getUint32();
    print('modelFeaturedComicInfoCount : $modelFeaturedComicInfoCount');

    List<ModelFeaturedComicInfo>  list1 = new List<ModelFeaturedComicInfo>();

    for(int countIndex=0; countIndex<modelFeaturedComicInfoCount; ++countIndex)
    {
      ModelFeaturedComicInfo modelFeaturedComicInfo = new ModelFeaturedComicInfo();

      modelFeaturedComicInfo.creatorId = readStringToByteBuffer();
      modelFeaturedComicInfo.comicNumber = readStringToByteBuffer();
      modelFeaturedComicInfo.titleName = readStringToByteBuffer();

      String url = await ModelPreset.getBannerImageDownloadUrl(modelFeaturedComicInfo.creatorId, modelFeaturedComicInfo.comicNumber);
      modelFeaturedComicInfo.url = url;

      print(modelFeaturedComicInfo.toString());

      list1.add(modelFeaturedComicInfo);
    }


    ModelFeaturedComicInfo.list = list1;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int modelRecommendedComicInfoCount = getUint32();
    print('modelRecommendedComicInfoCount : $modelRecommendedComicInfoCount');

    List<ModelRecommendedComicInfo> list2 = new List<ModelRecommendedComicInfo>();
    for(int countIndex=0; countIndex<modelRecommendedComicInfoCount; ++countIndex)
    {
      ModelRecommendedComicInfo modelRecommendedComicInfo = new ModelRecommendedComicInfo();

      modelRecommendedComicInfo.creatorId = readStringToByteBuffer();
      modelRecommendedComicInfo.comicNumber = readStringToByteBuffer();
      modelRecommendedComicInfo.titleName = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelRecommendedComicInfo.creatorId, modelRecommendedComicInfo.comicNumber);
      modelRecommendedComicInfo.url = url;

      print(modelRecommendedComicInfo.toString());

      list2.add(modelRecommendedComicInfo);
    }

    ModelRecommendedComicInfo.list = list2;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int modelRealTimeTrendInfoCount = getUint32();
    print('modelRealTimeTrendInfoCount : $modelRealTimeTrendInfoCount');


    List<ModelRealTimeTrendComicInfo> list3 = new List<ModelRealTimeTrendComicInfo>();
    for(int countIndex=0; countIndex<modelRealTimeTrendInfoCount; ++countIndex)
    {
      ModelRealTimeTrendComicInfo modelRealTimeTrendInfo = new ModelRealTimeTrendComicInfo();

      modelRealTimeTrendInfo.creatorId = readStringToByteBuffer();
      modelRealTimeTrendInfo.comicNumber = readStringToByteBuffer();
      modelRealTimeTrendInfo.titleName = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelRealTimeTrendInfo.creatorId, modelRealTimeTrendInfo.comicNumber);
      modelRealTimeTrendInfo.url = url;

      print(modelRealTimeTrendInfo.toString());

      list3.add(modelRealTimeTrendInfo);
    }

    ModelRealTimeTrendComicInfo.list = list3;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int modelNewComicInfoCount = getUint32();
    print('modelNewComicInfoCount : $modelNewComicInfoCount');

    List<ModelNewComicInfo> list4 = new List<ModelNewComicInfo>();
    for(int countIndex=0; countIndex<modelNewComicInfoCount; ++countIndex)
    {
      ModelNewComicInfo modelNewComicInfo = new ModelNewComicInfo();

      modelNewComicInfo.creatorId = readStringToByteBuffer();
      modelNewComicInfo.comicNumber = readStringToByteBuffer();
      modelNewComicInfo.titleName = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelNewComicInfo.creatorId, modelNewComicInfo.comicNumber);
      modelNewComicInfo.url = url;

      print(modelNewComicInfo.toString());

      list4.add(modelNewComicInfo);
    }

    ModelNewComicInfo.list = list4;


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int todayPopularComicInfoCount = getUint32();
    print('todayPopularComicInfoCount : $todayPopularComicInfoCount');


    List<ModelTodayTrendComicInfo> list5 = new List<ModelTodayTrendComicInfo>();
    for(int countIndex=0; countIndex<todayPopularComicInfoCount; ++countIndex)
    {
      ModelTodayTrendComicInfo modelTodayTrendComicInfo = new ModelTodayTrendComicInfo();

      modelTodayTrendComicInfo.creatorId = readStringToByteBuffer();
      modelTodayTrendComicInfo.comicNumber = readStringToByteBuffer();
      modelTodayTrendComicInfo.titleName = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelTodayTrendComicInfo.creatorId, modelTodayTrendComicInfo.comicNumber);
      modelTodayTrendComicInfo.url = url;

      print(modelTodayTrendComicInfo.toString());

      list5.add(modelTodayTrendComicInfo);
    }

    ModelTodayTrendComicInfo.list = list5;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int weeklyPopularComicInfoCount = getUint32();
    print('weeklyPopularComicInfoCount : $weeklyPopularComicInfoCount');


    List<ModelWeeklyTrendComicInfo> list6 = new List<ModelWeeklyTrendComicInfo>();
    for(int countIndex=0; countIndex<weeklyPopularComicInfoCount; ++countIndex)
    {
      ModelWeeklyTrendComicInfo modelWeeklyTrendComicInfo = new ModelWeeklyTrendComicInfo();

      modelWeeklyTrendComicInfo.creatorId = readStringToByteBuffer();
      modelWeeklyTrendComicInfo.comicNumber = readStringToByteBuffer();
      modelWeeklyTrendComicInfo.titleName = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelWeeklyTrendComicInfo.creatorId, modelWeeklyTrendComicInfo.comicNumber);
      modelWeeklyTrendComicInfo.url = url;

      print(modelWeeklyTrendComicInfo.toString());

      list6.add(modelWeeklyTrendComicInfo);
    }

    ModelWeeklyTrendComicInfo.list = list6;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if(null != onFetchDone)
      onFetchDone(this);

  }

}
