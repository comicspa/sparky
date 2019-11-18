
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';


class PacketS2CStorageFileRealUrl extends PacketS2CCommon
{
  int _totalCount;
  int _currentCount;
  String _modelName;
  String get modelName => _modelName;
  set modelName(String modelName)
  {
    _modelName = modelName;
  }

  PacketS2CStorageFileRealUrl()
  {
    type = e_packet_type.s2c_storage_file_real_url;
  }


  Future<void> parseFireBaseDBJson(onFetchDone,int totalCount,int currentCount) async
  {
    status = e_packet_status.start_dispatch_respond;

    _totalCount = totalCount;
    _currentCount = currentCount;

    status = e_packet_status.finish_dispatch_respond;

    if(null != onFetchDone)
      onFetchDone(this);
  }

  bool isFinished()
  {
    if(_totalCount == _currentCount)
      return true;

    return false;
  }


}