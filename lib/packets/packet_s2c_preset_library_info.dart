
import 'dart:typed_data';


import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/models/model_library_recent_comic_info.dart';
import 'package:sparky/models/model_library_continue_comic_info.dart';
import 'package:sparky/models/model_library_owned_comic_info.dart';
import 'package:sparky/models/model_library_view_list_comic_info.dart';
import 'package:sparky/manage/manage_resource.dart';



class PacketS2CPresetLibraryInfo extends PacketS2CCommon
{
  PacketS2CPresetLibraryInfo()
  {
    type = e_packet_type.s2c_preset_library_info;
  }


  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize,onFetchDone) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int modelMyLockerComicRecentCount = getUint32();
    print('modelMyLockerComicRecentCount : $modelMyLockerComicRecentCount');


    List<ModelLibraryRecentComicInfo> list1 = new List<ModelLibraryRecentComicInfo>();

    for(int countIndex=0; countIndex<modelMyLockerComicRecentCount; ++countIndex)
    {
      ModelLibraryRecentComicInfo modelLibraryRecentComicInfo = new ModelLibraryRecentComicInfo();

      modelLibraryRecentComicInfo.userId = readStringToByteBuffer();
      modelLibraryRecentComicInfo.comicId = readStringToByteBuffer();
      modelLibraryRecentComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationSquareImageDownloadUrl(modelLibraryRecentComicInfo.userId, modelLibraryRecentComicInfo.comicId);
      modelLibraryRecentComicInfo.url = url;
      modelLibraryRecentComicInfo.thumbnailUrl = url;

      modelLibraryRecentComicInfo.image = await ManageResource.fetchImage(url);

      print(modelLibraryRecentComicInfo.toString());

      list1.add(modelLibraryRecentComicInfo);
    }

    ModelLibraryRecentComicInfo.list = list1;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int modelMyLockerComicViewListCount = getUint32();
    print('modelMyLockerComicViewListCount : $modelMyLockerComicViewListCount');


    List<ModelLibraryViewListComicInfo> list2 = new List<ModelLibraryViewListComicInfo>();

    for(int countIndex=0; countIndex<modelMyLockerComicViewListCount; ++countIndex)
    {
      ModelLibraryViewListComicInfo modelLibraryViewListComicInfo = new ModelLibraryViewListComicInfo();

      modelLibraryViewListComicInfo.userId = readStringToByteBuffer();
      modelLibraryViewListComicInfo.comicId = readStringToByteBuffer();
      modelLibraryViewListComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationSquareImageDownloadUrl(modelLibraryViewListComicInfo.userId, modelLibraryViewListComicInfo.comicId);
      modelLibraryViewListComicInfo.url = url;
      modelLibraryViewListComicInfo.thumbnailUrl = url;

      modelLibraryViewListComicInfo.image = await ManageResource.fetchImage(url);

      print(modelLibraryViewListComicInfo.toString());

      list2.add(modelLibraryViewListComicInfo);
    }

    ModelLibraryViewListComicInfo.list = list2;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int modelMyLockerComicOwnedCount = getUint32();
    print('modelMyLockerComicOwnedCount : $modelMyLockerComicOwnedCount');


    List<ModelLibraryOwnedComicInfo> list3 = new List<ModelLibraryOwnedComicInfo>();

    for(int countIndex=0; countIndex<modelMyLockerComicOwnedCount; ++countIndex)
    {
      ModelLibraryOwnedComicInfo modelLibraryOwnedComicInfo = new ModelLibraryOwnedComicInfo();

      modelLibraryOwnedComicInfo.userId = readStringToByteBuffer();
      modelLibraryOwnedComicInfo.comicId = readStringToByteBuffer();
      modelLibraryOwnedComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationSquareImageDownloadUrl(modelLibraryOwnedComicInfo.userId, modelLibraryOwnedComicInfo.comicId);
      modelLibraryOwnedComicInfo.url = url;
      modelLibraryOwnedComicInfo.thumbnailUrl = url;

      modelLibraryOwnedComicInfo.image = await ManageResource.fetchImage(url);

      print(modelLibraryOwnedComicInfo.toString());

      list3.add(modelLibraryOwnedComicInfo);
    }

    ModelLibraryOwnedComicInfo.list = list3;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int modelMyLockerComicContinueCount = getUint32();
    print('modelMyLockerComicContinueCount : $modelMyLockerComicContinueCount');


    List<ModelLibraryContinueComicInfo> list4 = new List<ModelLibraryContinueComicInfo>();
    for(int countIndex=0; countIndex<modelMyLockerComicContinueCount; ++countIndex)
    {
      ModelLibraryContinueComicInfo modelLibraryContinueComicInfo = new ModelLibraryContinueComicInfo();

      modelLibraryContinueComicInfo.userId = readStringToByteBuffer();
      modelLibraryContinueComicInfo.comicId = readStringToByteBuffer();
      modelLibraryContinueComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationSquareImageDownloadUrl(modelLibraryContinueComicInfo.userId, modelLibraryContinueComicInfo.comicId);
      modelLibraryContinueComicInfo.url = url;
      modelLibraryContinueComicInfo.thumbnailUrl = url;

      modelLibraryContinueComicInfo.image = await ManageResource.fetchImage(url);

      print(modelLibraryContinueComicInfo.toString());

      list4.add(modelLibraryContinueComicInfo);

    }

    ModelLibraryContinueComicInfo.list = list4;


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if(null != onFetchDone)
      onFetchDone(this);

  }

}
