import 'dart:convert';
import 'dart:io';

import 'package:sparky/models/model_featured_comic_info.dart';
import 'package:sparky/models/model_library_continue_comic_info.dart';
import 'package:sparky/models/model_library_owned_comic_info.dart';
import 'package:sparky/models/model_library_recent_comic_info.dart';
import 'package:sparky/models/model_library_view_list_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/models/model_recommended_comic_info.dart';
import 'package:sparky/models/model_real_time_trend_comic_info.dart';
import 'package:sparky/models/model_new_comic_info.dart';
import 'package:sparky/models/model_today_trend_comic_info.dart';
import 'package:sparky/models/model_weekly_trend_comic_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_s2c_storage_file_real_url.dart';


class PacketC2SStorageFileRealUrl extends PacketC2SCommon
{
  String _modelName;
  OnFetchDone _onFetchDone;

  String get modelName => _modelName;
  set modelName(String modelName)
  {
    _modelName = modelName;
  }

  PacketC2SStorageFileRealUrl()
  {
    type = e_packet_type.c2s_storage_file_real_url;
  }

  void generate(String modelName,{OnFetchDone onFetchDone})
  {
    _onFetchDone = onFetchDone;

    if(null == respondPacket)
      respondPacket = new PacketS2CStorageFileRealUrl();
    _modelName = modelName;
    (respondPacket as PacketS2CStorageFileRealUrl).modelName = modelName;
  }

  Future<void> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<void> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SStorageFileRealUrl : fetchFireBaseDB started - $modelName');

    switch(_modelName)
    {
      case ModelFeaturedComicInfo.ModelName:
        {
          print('PacketC2SStorageFileRealUrl - ${ModelFeaturedComicInfo.ModelName} , ${ModelFeaturedComicInfo.list.length}');

          int countIndex = 0;
          while(countIndex < ModelFeaturedComicInfo.list.length)
          {
            if(null == ModelFeaturedComicInfo.list[countIndex].url || '' == ModelFeaturedComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000';//modelRecommendedComicInfo.creatorId;

              //ModelFeaturedComicInfo.list[countIndex].url =
              await ModelPreset.getBannerImageDownloadUrl(creatorId, ModelFeaturedComicInfo.list[countIndex].comicNumber).then((data)
              {
                ModelFeaturedComicInfo.list[countIndex].url = data;

                (respondPacket as PacketS2CStorageFileRealUrl).status = e_packet_status.finish_dispatch_respond;
                //if (null != _onFetchDone)
                //  _onFetchDone(respondPacket);

                ++ countIndex;
              });

            }
          }

          if (null != _onFetchDone)
            _onFetchDone(respondPacket);


          /*
          for(int countIndex=0; countIndex<ModelFeaturedComicInfo.list.length; ++countIndex)
          {
            if(null == ModelFeaturedComicInfo.list[countIndex].url || '' == ModelFeaturedComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000';//modelRecommendedComicInfo.creatorId;

              ModelFeaturedComicInfo.list[countIndex].url =
              await ModelPreset.getBannerImageDownloadUrl(creatorId,
                  ModelFeaturedComicInfo.list[countIndex].comicNumber);

              (respondPacket as PacketS2CStorageFileRealUrl).status =
                  e_packet_status.finish_dispatch_respond;
              if (null != _onFetchDone)
                _onFetchDone(respondPacket);
            }
          }
           */


        }
        break;

      case ModelRecommendedComicInfo.ModelName:
        {
          print('PacketC2SStorageFileRealUrl - ${ModelRecommendedComicInfo.ModelName} , ${ModelRecommendedComicInfo.list.length}');


          int countIndex = 0;
          while(countIndex < ModelRecommendedComicInfo.list.length)
          {
            if(null == ModelRecommendedComicInfo.list[countIndex].url || '' == ModelRecommendedComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000';//modelRecommendedComicInfo.creatorId;

              //ModelRecommendedComicInfo.list[countIndex].url =
              await ModelPreset.getRepresentationHorizontalImageDownloadUrl(creatorId, ModelRecommendedComicInfo.list[countIndex].comicNumber).then((data)
              {
                ModelRecommendedComicInfo.list[countIndex].url = data;

                (respondPacket as PacketS2CStorageFileRealUrl).status = e_packet_status.finish_dispatch_respond;
                //if (null != _onFetchDone)
                //  _onFetchDone(respondPacket);

                ++ countIndex;
              });

            }
          }

          if (null != _onFetchDone)
            _onFetchDone(respondPacket);

          /*
          for(int countIndex=0; countIndex<ModelRecommendedComicInfo.list.length; ++countIndex)
            {
              if(null == ModelFeaturedComicInfo.list[countIndex].url || '' == ModelFeaturedComicInfo.list[countIndex].url)
              {
                String creatorId = '1566811403000'; //modelRecommendedComicInfo.creatorId;
                ModelRecommendedComicInfo.list[countIndex].url =
                await ModelPreset.getRepresentationHorizontalImageDownloadUrl(
                    creatorId,
                    ModelRecommendedComicInfo.list[countIndex].comicNumber);
                (respondPacket as PacketS2CStorageFileRealUrl).status =
                    e_packet_status.finish_dispatch_respond;

                if (null != _onFetchDone)
                  _onFetchDone(respondPacket);
              }
            }

           */


        }
        break;

      case ModelRealTimeTrendComicInfo.ModelName:
      {
        print('PacketC2SStorageFileRealUrl - ${ModelRealTimeTrendComicInfo.ModelName} , ${ModelRealTimeTrendComicInfo.list.length}');

        int countIndex = 0;
        while(countIndex < ModelRealTimeTrendComicInfo.list.length)
        {
          if(null == ModelRealTimeTrendComicInfo.list[countIndex].url || '' == ModelRealTimeTrendComicInfo.list[countIndex].url)
          {
            String creatorId = '1566811403000';//modelRecommendedComicInfo.creatorId;

            //ModelRecommendedComicInfo.list[countIndex].url =
            await ModelPreset.getRepresentationHorizontalImageDownloadUrl(creatorId, ModelRealTimeTrendComicInfo.list[countIndex].comicNumber).then((data)
            {
              ModelRealTimeTrendComicInfo.list[countIndex].url = data;

              (respondPacket as PacketS2CStorageFileRealUrl).status = e_packet_status.finish_dispatch_respond;
              //if (null != _onFetchDone)
              //  _onFetchDone(respondPacket);

              ++ countIndex;
            });

          }
        }

        if (null != _onFetchDone)
          _onFetchDone(respondPacket);



        /*
        for(int countIndex=0; countIndex<ModelRealTimeTrendComicInfo.list.length; ++countIndex)
        {
          if(null == ModelRealTimeTrendComicInfo.list[countIndex].url || '' == ModelRealTimeTrendComicInfo.list[countIndex].url)
          {
            String creatorId = '1566811403000'; //modelRecommendedComicInfo.creatorId;
            ModelRealTimeTrendComicInfo.list[countIndex].url =
            await ModelPreset.getRepresentationHorizontalImageDownloadUrl(
                creatorId,
                ModelRealTimeTrendComicInfo.list[countIndex].comicNumber);
            (respondPacket as PacketS2CStorageFileRealUrl).status =
                e_packet_status.finish_dispatch_respond;

            if (null != _onFetchDone)
              _onFetchDone(respondPacket);
          }
        }

         */



      }
      break;

      case ModelNewComicInfo.ModelName:
        {
          print('PacketC2SStorageFileRealUrl - ${ModelNewComicInfo.ModelName} , ${ModelNewComicInfo.list.length}');


          int countIndex = 0;
          while(countIndex < ModelNewComicInfo.list.length)
          {
            //if(false == ModelNewComicInfo.list[countIndex].urlRequested)
            {
              //ModelNewComicInfo.list[countIndex].urlRequested = true;

              if (null == ModelNewComicInfo.list[countIndex].url ||
                  '' == ModelNewComicInfo.list[countIndex].url) {
                String creatorId = '1566811403000'; //modelRecommendedComicInfo.creatorId;

                //ModelRecommendedComicInfo.list[countIndex].url =
                await ModelPreset.getRepresentationHorizontalImageDownloadUrl(
                    creatorId, ModelNewComicInfo.list[countIndex].comicNumber)
                    .then((data) {
                  ModelNewComicInfo.list[countIndex].url = data;

                  (respondPacket as PacketS2CStorageFileRealUrl).status =
                      e_packet_status.finish_dispatch_respond;
                  //if (null != _onFetchDone)
                  //  _onFetchDone(respondPacket);

                  ++countIndex;
                });
              }
            }


          }

          if (null != _onFetchDone)
            _onFetchDone(respondPacket);


          /*
          for(int countIndex=0; countIndex<ModelNewComicInfo.list.length; ++countIndex)
          {
            if(null == ModelNewComicInfo.list[countIndex].url || '' == ModelNewComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000'; //modelRecommendedComicInfo.creatorId;
              ModelNewComicInfo.list[countIndex].url =
              await ModelPreset.getRepresentationHorizontalImageDownloadUrl(
                  creatorId, ModelNewComicInfo.list[countIndex].comicNumber);
              (respondPacket as PacketS2CStorageFileRealUrl).status =
                  e_packet_status.finish_dispatch_respond;

              if (null != _onFetchDone)
                _onFetchDone(respondPacket);
            }

          }
          */


        }
        break;

      case ModelTodayTrendComicInfo.ModelName:
        {
          print('PacketC2SStorageFileRealUrl - ${ModelTodayTrendComicInfo.ModelName} , ${ModelTodayTrendComicInfo.list.length}');

          int countIndex = 0;
          while(countIndex < ModelTodayTrendComicInfo.list.length)
          {
            if(null == ModelTodayTrendComicInfo.list[countIndex].url || '' == ModelTodayTrendComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000';//modelRecommendedComicInfo.creatorId;

              //ModelRecommendedComicInfo.list[countIndex].url =
              await ModelPreset.getRepresentationHorizontalImageDownloadUrl(creatorId, ModelTodayTrendComicInfo.list[countIndex].comicNumber).then((data)
              {
                ModelTodayTrendComicInfo.list[countIndex].url = data;

                (respondPacket as PacketS2CStorageFileRealUrl).status = e_packet_status.finish_dispatch_respond;
                //if (null != _onFetchDone)
                //  _onFetchDone(respondPacket);

                ++ countIndex;
              });
            }
          }

          if (null != _onFetchDone)
            _onFetchDone(respondPacket);

          /*
          for(int countIndex=0; countIndex<ModelTodayTrendComicInfo.list.length; ++countIndex)
          {
            if(null == ModelTodayTrendComicInfo.list[countIndex].url || '' == ModelTodayTrendComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000'; //modelRecommendedComicInfo.creatorId;
              ModelTodayTrendComicInfo.list[countIndex].url =
              await ModelPreset.getRepresentationHorizontalImageDownloadUrl(
                  creatorId,
                  ModelTodayTrendComicInfo.list[countIndex].comicNumber);
              (respondPacket as PacketS2CStorageFileRealUrl).status =
                  e_packet_status.finish_dispatch_respond;

              if (null != _onFetchDone)
                _onFetchDone(respondPacket);
            }
          }

           */


        }
        break;

      case ModelWeeklyTrendComicInfo.ModelName:
        {
          print('PacketC2SStorageFileRealUrl - ${ModelWeeklyTrendComicInfo.ModelName} , ${ModelWeeklyTrendComicInfo.list.length}');


          int countIndex = 0;
          while(countIndex < ModelWeeklyTrendComicInfo.list.length)
          {
            if(null == ModelWeeklyTrendComicInfo.list[countIndex].url || '' == ModelWeeklyTrendComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000';//modelRecommendedComicInfo.creatorId;

              //ModelRecommendedComicInfo.list[countIndex].url =
              await ModelPreset.getRepresentationHorizontalImageDownloadUrl(creatorId, ModelWeeklyTrendComicInfo.list[countIndex].comicNumber).then((data)
              {
                ModelWeeklyTrendComicInfo.list[countIndex].url = data;

                (respondPacket as PacketS2CStorageFileRealUrl).status = e_packet_status.finish_dispatch_respond;
                //if (null != _onFetchDone)
                //  _onFetchDone(respondPacket);

                ++ countIndex;
              });
            }
          }


          if (null != _onFetchDone)
            _onFetchDone(respondPacket);


          /*
          for(int countIndex=0; countIndex<ModelWeeklyTrendComicInfo.list.length; ++countIndex)
          {
            if(null == ModelWeeklyTrendComicInfo.list[countIndex].url || '' == ModelWeeklyTrendComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000'; //modelRecommendedComicInfo.creatorId;
              ModelWeeklyTrendComicInfo.list[countIndex].url =
              await ModelPreset.getRepresentationHorizontalImageDownloadUrl(
                  creatorId,
                  ModelWeeklyTrendComicInfo.list[countIndex].comicNumber);
              (respondPacket as PacketS2CStorageFileRealUrl).status =
                  e_packet_status.finish_dispatch_respond;

              if (null != _onFetchDone)
                _onFetchDone(respondPacket);
            }
          }

           */


        }
        break;

      case ModelLibraryContinueComicInfo.ModelName:
        {
          print('PacketC2SStorageFileRealUrl - ${ModelLibraryContinueComicInfo.list.length}');

          int countIndex = 0;
          while(countIndex < ModelLibraryContinueComicInfo.list.length)
          {
            if(null == ModelLibraryContinueComicInfo.list[countIndex].url || '' == ModelLibraryContinueComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000';//modelRecommendedComicInfo.creatorId;

              //ModelRecommendedComicInfo.list[countIndex].url =
              await ModelPreset.getRepresentationHorizontalImageDownloadUrl(creatorId, ModelLibraryContinueComicInfo.list[countIndex].comicNumber).then((data)
              {
                ModelLibraryContinueComicInfo.list[countIndex].url = data;

                (respondPacket as PacketS2CStorageFileRealUrl).status = e_packet_status.finish_dispatch_respond;
                //if (null != _onFetchDone)
                //  _onFetchDone(respondPacket);

                ++ countIndex;
              });
            }
          }

          if (null != _onFetchDone)
            _onFetchDone(respondPacket);

          /*
          for(int countIndex=0; countIndex<ModelLibraryContinueComicInfo.list.length; ++countIndex)
          {
            if(null == ModelLibraryContinueComicInfo.list[countIndex].url || '' == ModelLibraryContinueComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000'; //modelRecommendedComicInfo.creatorId;
              ModelLibraryContinueComicInfo.list[countIndex].url =
              await ModelPreset.getRepresentationHorizontalImageDownloadUrl(
                  creatorId,
                  ModelLibraryContinueComicInfo.list[countIndex].comicNumber);
              (respondPacket as PacketS2CStorageFileRealUrl).status =
                  e_packet_status.finish_dispatch_respond;

              if (null != _onFetchDone)
                _onFetchDone(respondPacket);
            }
          }
           */
        }
        break;

      case ModelLibraryOwnedComicInfo.ModelName:
        {
          print('PacketC2SStorageFileRealUrl - ${ModelLibraryOwnedComicInfo.list.length}');

          int countIndex = 0;
          while(countIndex < ModelLibraryOwnedComicInfo.list.length)
          {
            if(null == ModelLibraryOwnedComicInfo.list[countIndex].url || '' == ModelLibraryOwnedComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000';//modelRecommendedComicInfo.creatorId;

              //ModelRecommendedComicInfo.list[countIndex].url =
              await ModelPreset.getRepresentationHorizontalImageDownloadUrl(creatorId, ModelLibraryOwnedComicInfo.list[countIndex].comicNumber).then((data)
              {
                ModelLibraryOwnedComicInfo.list[countIndex].url = data;

                (respondPacket as PacketS2CStorageFileRealUrl).status = e_packet_status.finish_dispatch_respond;
                //if (null != _onFetchDone)
                //  _onFetchDone(respondPacket);

                ++ countIndex;
              });
            }
          }

          if (null != _onFetchDone)
            _onFetchDone(respondPacket);

          /*
          for(int countIndex=0; countIndex<ModelLibraryOwnedComicInfo.list.length; ++countIndex)
          {
            if(null == ModelLibraryOwnedComicInfo.list[countIndex].url || '' == ModelLibraryOwnedComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000'; //modelRecommendedComicInfo.creatorId;
              ModelLibraryOwnedComicInfo.list[countIndex].url =
              await ModelPreset.getRepresentationHorizontalImageDownloadUrl(
                  creatorId,
                  ModelLibraryOwnedComicInfo.list[countIndex].comicNumber);
              (respondPacket as PacketS2CStorageFileRealUrl).status =
                  e_packet_status.finish_dispatch_respond;

              if (null != _onFetchDone)
                _onFetchDone(respondPacket);
            }

          }

           */


        }
        break;

      case ModelLibraryRecentComicInfo.ModelName:
        {
          print('PacketC2SStorageFileRealUrl - ${ModelLibraryRecentComicInfo.list.length}');


          int countIndex = 0;
          while(countIndex < ModelLibraryRecentComicInfo.list.length)
          {
            if(null == ModelLibraryRecentComicInfo.list[countIndex].url || '' == ModelLibraryRecentComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000';//modelRecommendedComicInfo.creatorId;

              //ModelRecommendedComicInfo.list[countIndex].url =
              await ModelPreset.getRepresentationHorizontalImageDownloadUrl(creatorId, ModelLibraryRecentComicInfo.list[countIndex].comicNumber).then((data)
              {
                ModelLibraryRecentComicInfo.list[countIndex].url = data;

                (respondPacket as PacketS2CStorageFileRealUrl).status = e_packet_status.finish_dispatch_respond;
                //if (null != _onFetchDone)
                //  _onFetchDone(respondPacket);

                ++ countIndex;
              });
            }
          }

          if (null != _onFetchDone)
            _onFetchDone(respondPacket);



          /*
          for(int countIndex=0; countIndex<ModelLibraryRecentComicInfo.list.length; ++countIndex)
          {
            if(null == ModelLibraryRecentComicInfo.list[countIndex].url || '' == ModelLibraryRecentComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000'; //modelRecommendedComicInfo.creatorId;
              ModelLibraryRecentComicInfo.list[countIndex].url =
              await ModelPreset.getRepresentationHorizontalImageDownloadUrl(
                  creatorId,
                  ModelLibraryRecentComicInfo.list[countIndex].comicNumber);
              (respondPacket as PacketS2CStorageFileRealUrl).status =
                  e_packet_status.finish_dispatch_respond;

              if (null != _onFetchDone)
                _onFetchDone(respondPacket);
            }
          }

           */


        }
        break;

      case ModelLibraryViewListComicInfo.ModelName:
        {
          print('PacketC2SStorageFileRealUrl - ${ModelLibraryViewListComicInfo.list.length}');


          int countIndex = 0;
          while(countIndex < ModelLibraryViewListComicInfo.list.length)
          {
            if(null == ModelLibraryViewListComicInfo.list[countIndex].url || '' == ModelLibraryViewListComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000';//modelRecommendedComicInfo.creatorId;

              //ModelRecommendedComicInfo.list[countIndex].url =
              await ModelPreset.getRepresentationHorizontalImageDownloadUrl(creatorId, ModelLibraryViewListComicInfo.list[countIndex].comicNumber).then((data)
              {
                ModelLibraryViewListComicInfo.list[countIndex].url = data;

                (respondPacket as PacketS2CStorageFileRealUrl).status = e_packet_status.finish_dispatch_respond;
                //if (null != _onFetchDone)
                //  _onFetchDone(respondPacket);

                ++ countIndex;
              });
            }
          }

          if (null != _onFetchDone)
            _onFetchDone(respondPacket);



          /*
          for(int countIndex=0; countIndex<ModelLibraryViewListComicInfo.list.length; ++countIndex)
          {

            if(null == ModelLibraryViewListComicInfo.list[countIndex].url || '' == ModelLibraryViewListComicInfo.list[countIndex].url)
            {
              String creatorId = '1566811403000'; //modelRecommendedComicInfo.creatorId;
              ModelLibraryViewListComicInfo.list[countIndex].url =
              await ModelPreset.getRepresentationHorizontalImageDownloadUrl(creatorId, ModelLibraryViewListComicInfo.list[countIndex].comicNumber);

              (respondPacket as PacketS2CStorageFileRealUrl).status =
                  e_packet_status.finish_dispatch_respond;

              if (null != _onFetchDone)
                _onFetchDone(respondPacket);
            }
          }

           */


        }
        break;

      default:
        return;
    }

    /*
    fileRealUrl = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(_creatorId,_comicId);
    fileRealUrl = await ModelPreset.getRepresentationSquareImageDownloadUrl(_creatorId,_comicId);
    fileRealUrl = await ModelPreset.getBannerImageDownloadUrl(_creatorId,_comicId);
    fileRealUrl = await ModelPreset.getThumbnailImageDownloadUrl(_creatorId,_comicId,_partId,_seasonId,_episodeId);
    fileRealUrl = await ModelPreset.getCutImageDownloadUrl(_creatorId,_comicId,_partId,_seasonId,_episodeId,_imageId);
    */
  }


}