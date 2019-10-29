
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';



class PacketS2CSubscribeComic extends PacketS2CCommon
{
  PacketS2CSubscribeComic()
  {
    type = e_packet_type.s2c_subscribe_comic;
  }

  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    status = e_packet_status.start_dispatch_respond;

    /*
    int countIndex = 0;
    bool switchFlag = false;
    List<ModelLibraryViewListComicInfo> modelLibraryViewListComicInfoList = null;
    if(true == switchFlag)
    {
      if(null == ModelLibraryViewListComicInfo.list )
        ModelLibraryViewListComicInfo.list  = new List<ModelLibraryViewListComicInfo>();
      else
        ModelLibraryViewListComicInfo.list .clear();
    }

    for(var key in jsonMap.keys)
    {
      print(key);
      List<String> splitList = key.toString().split('_');
      switch(splitList.length)
      {
        case 2:
          {
            //String creatorId = splitList[0];
            //String comicId = splitList[1];
          }
          break;

        default:
          continue;
      }

      var comicInfo = jsonMap[key];

      ModelLibraryViewListComicInfo modelLibraryViewListComicInfo = new ModelLibraryViewListComicInfo();

      modelLibraryViewListComicInfo.title = comicInfo['title'];
      modelLibraryViewListComicInfo.creatorName = comicInfo['creator_name'];
      modelLibraryViewListComicInfo.comicId = comicInfo['comic_id'];
      modelLibraryViewListComicInfo.userId = comicInfo['user_id'];
      modelLibraryViewListComicInfo.creatorId = comicInfo['creator_id'];

      String url = await ModelPreset.getRepresentationSquareImageDownloadUrl(modelLibraryViewListComicInfo.userId, modelLibraryViewListComicInfo.comicId);
      modelLibraryViewListComicInfo.url = url;
      modelLibraryViewListComicInfo.thumbnailUrl = url;
      modelLibraryViewListComicInfo.image = await ManageResource.fetchImage(url);

      print(modelLibraryViewListComicInfo.toString());


      if(false == switchFlag)
      {
        if(null == modelLibraryViewListComicInfoList)
          modelLibraryViewListComicInfoList = new List<ModelLibraryViewListComicInfo>();
        modelLibraryViewListComicInfoList.add(modelLibraryViewListComicInfo);
      }
      else
      {
        ModelLibraryViewListComicInfo.list .add(modelLibraryViewListComicInfo);
        if(0 == countIndex % 3)
        {
          if (null != onFetchDone)
            onFetchDone(this);
        }
      }

      ++ countIndex;

    }

    if(false == switchFlag)
    {
      ModelLibraryViewListComicInfo.list = modelLibraryViewListComicInfoList;
    }
    */
    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
  }








}