
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

      modelLibraryRecentComicInfo.creatorId = readStringToByteBuffer();
      modelLibraryRecentComicInfo.comicNumber = readStringToByteBuffer();
      modelLibraryRecentComicInfo.titleName = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationSquareImageDownloadUrl(modelLibraryRecentComicInfo.creatorId, modelLibraryRecentComicInfo.comicNumber);
      modelLibraryRecentComicInfo.url = url;

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

      modelLibraryViewListComicInfo.creatorId = readStringToByteBuffer();
      modelLibraryViewListComicInfo.comicNumber = readStringToByteBuffer();
      modelLibraryViewListComicInfo.titleName = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationSquareImageDownloadUrl(modelLibraryViewListComicInfo.creatorId, modelLibraryViewListComicInfo.comicNumber);
      modelLibraryViewListComicInfo.url = url;

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

      modelLibraryOwnedComicInfo.creatorId = readStringToByteBuffer();
      modelLibraryOwnedComicInfo.comicNumber = readStringToByteBuffer();
      modelLibraryOwnedComicInfo.titleName = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationSquareImageDownloadUrl(modelLibraryOwnedComicInfo.creatorId, modelLibraryOwnedComicInfo.comicNumber);
      modelLibraryOwnedComicInfo.url = url;

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

      modelLibraryContinueComicInfo.creatorId = readStringToByteBuffer();
      modelLibraryContinueComicInfo.comicNumber = readStringToByteBuffer();
      modelLibraryContinueComicInfo.titleName = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationSquareImageDownloadUrl(modelLibraryContinueComicInfo.creatorId, modelLibraryContinueComicInfo.comicNumber);
      modelLibraryContinueComicInfo.url = url;
      //modelLibraryContinueComicInfo.thumbnailUrl = url;

      print(modelLibraryContinueComicInfo.toString());

      list4.add(modelLibraryContinueComicInfo);

    }

    ModelLibraryContinueComicInfo.list = list4;


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if(null != onFetchDone)
      onFetchDone(this);

  }

}
