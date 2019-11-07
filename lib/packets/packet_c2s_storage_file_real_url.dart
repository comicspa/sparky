import 'dart:convert';
import 'dart:io';

import 'package:sparky/models/model_preset.dart';
import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_storage_file_real_url.dart';



class PacketC2SStorageFileRealUrl extends PacketC2SCommon
{

  String _creatorId;
  String _comicId;
  String _partId;
  String _seasonId;
  String _episodeId;
  String _imageId;

  PacketC2SStorageFileRealUrl()
  {
    type = e_packet_type.c2s_storage_file_real_url;
  }

  void generate(String creatorId,String comicId,String partId,String seasonId,String episodeId,String imageId)
  {
    _creatorId = creatorId;
    _comicId = comicId;
    _partId = partId;
    _seasonId = seasonId;
    _episodeId = episodeId;
    _imageId = imageId;
  }

  Future<void> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<void> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SStorageFileRealUrl : fetchFireBaseDB started');

    String fileRealUrl;


    fileRealUrl = await ModelPreset.getRepresentationHorizontalImageDownloadUrl(_creatorId,_comicId);
    fileRealUrl = await ModelPreset.getRepresentationSquareImageDownloadUrl(_creatorId,_comicId);
    fileRealUrl = await ModelPreset.getBannerImageDownloadUrl(_creatorId,_comicId);
    fileRealUrl = await ModelPreset.getThumbnailImageDownloadUrl(_creatorId,_comicId,_partId,_seasonId,_episodeId);
    fileRealUrl = await ModelPreset.getCutImageDownloadUrl(_creatorId,_comicId,_partId,_seasonId,_episodeId,_imageId);

    PacketS2CStorageFileRealUrl packet = new PacketS2CStorageFileRealUrl();
    packet.parseFireBaseDBJson(onFetchDone);
  }


}