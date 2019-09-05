import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_library_view_list_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';


class PacketS2CLibraryViewListComicInfo extends PacketS2CCommon
{
  PacketS2CLibraryViewListComicInfo()
  {
    type = e_packet_type.s2c_library_view_list_comic_info;
  }

  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int modelMyLockerComicViewListCount = getUint32();
    print('modelMyLockerComicViewListCount : $modelMyLockerComicViewListCount');


    List<ModelLibraryViewListComicInfo> list = new List<ModelLibraryViewListComicInfo>();

    for(int countIndex=0; countIndex<modelMyLockerComicViewListCount; ++countIndex)
    {
      ModelLibraryViewListComicInfo modelLibraryViewListComicInfo = new ModelLibraryViewListComicInfo();

      modelLibraryViewListComicInfo.userId = readStringToByteBuffer();
      modelLibraryViewListComicInfo.comicId = readStringToByteBuffer();
      modelLibraryViewListComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationVerticalImageDownloadUrl(modelLibraryViewListComicInfo.userId, modelLibraryViewListComicInfo.comicId);
      modelLibraryViewListComicInfo.url = url;
      modelLibraryViewListComicInfo.thumbnailUrl = url;

      modelLibraryViewListComicInfo.image = await ManageResource.fetchImage(url);

      print(modelLibraryViewListComicInfo.toString());

      list.add(modelLibraryViewListComicInfo);
    }

    ModelLibraryViewListComicInfo.list = list;

  }

}