
import 'dart:typed_data';


import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/models/model_featured_comic_info.dart';
import 'package:sparky/models/model_recommended_comic_info.dart';
import 'package:sparky/models/model_real_time_trend_info.dart';
import 'package:sparky/models/model_new_comic_info.dart';
import 'package:sparky/models/model_today_trend_comic_info.dart';
import 'package:sparky/models/model_weekly_trend_comic_info.dart';
import 'package:sparky/manage/manage_resource.dart';



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

      modelFeaturedComicInfo.userId = readStringToByteBuffer();
      modelFeaturedComicInfo.comicId = readStringToByteBuffer();
      modelFeaturedComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getBannerImageDownloadUrl(modelFeaturedComicInfo.userId, modelFeaturedComicInfo.comicId);
      modelFeaturedComicInfo.url = url;
      modelFeaturedComicInfo.thumbnailUrl = url;

      modelFeaturedComicInfo.image = await ManageResource.fetchImage(url);

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

      modelRecommendedComicInfo.userId = readStringToByteBuffer();
      modelRecommendedComicInfo.comicId = readStringToByteBuffer();
      modelRecommendedComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelRecommendedComicInfo.userId, modelRecommendedComicInfo.comicId);
      modelRecommendedComicInfo.url = url;
      modelRecommendedComicInfo.thumbnailUrl = url;

      modelRecommendedComicInfo.image = await ManageResource.fetchImage(url);

      print(modelRecommendedComicInfo.toString());

      list2.add(modelRecommendedComicInfo);
    }

    ModelRecommendedComicInfo.list = list2;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int modelRealTimeTrendInfoCount = getUint32();
    print('modelRealTimeTrendInfoCount : $modelRealTimeTrendInfoCount');


    List<ModelRealTimeTrendInfo> list3 = new List<ModelRealTimeTrendInfo>();
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

      list3.add(modelRealTimeTrendInfo);
    }

    ModelRealTimeTrendInfo.list = list3;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int modelNewComicInfoCount = getUint32();
    print('modelNewComicInfoCount : $modelNewComicInfoCount');

    List<ModelNewComicInfo> list4 = new List<ModelNewComicInfo>();
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

      modelTodayTrendComicInfo.userId = readStringToByteBuffer();
      modelTodayTrendComicInfo.comicId = readStringToByteBuffer();
      modelTodayTrendComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelTodayTrendComicInfo.userId, modelTodayTrendComicInfo.comicId);
      modelTodayTrendComicInfo.url = url;
      modelTodayTrendComicInfo.thumbnailUrl = url;

      modelTodayTrendComicInfo.image = await ManageResource.fetchImage(url);

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

      modelWeeklyTrendComicInfo.userId = readStringToByteBuffer();
      modelWeeklyTrendComicInfo.comicId = readStringToByteBuffer();
      modelWeeklyTrendComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(modelWeeklyTrendComicInfo.userId, modelWeeklyTrendComicInfo.comicId);
      modelWeeklyTrendComicInfo.url = url;
      modelWeeklyTrendComicInfo.thumbnailUrl = url;

      modelWeeklyTrendComicInfo.image = await ManageResource.fetchImage(url);

      print(modelWeeklyTrendComicInfo.toString());

      list6.add(modelWeeklyTrendComicInfo);
    }

    ModelWeeklyTrendComicInfo.list = list6;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if(null != onFetchDone)
      onFetchDone(this);

  }

}
