
import 'package:sparky/models/model_price_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';


class PacketS2CPriceInfo extends PacketS2CCommon
{

  PacketS2CPriceInfo()
  {
    type = e_packet_type.s2c_price_info;
  }

  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    status = e_packet_status.start_dispatch_respond;


    for(var key in jsonMap.keys)
    {
      print(key);

      //print('${jsonMap[key]['gift']}');
      //print('${jsonMap[key]['credit_card']}');
      //print('${jsonMap[key]['apple']}');
      //print('${jsonMap[key]['google']}');
      //print('${jsonMap[key]['happy_money']}');
      //print('${jsonMap[key]['phone']}');
      //print('${jsonMap[key]['wire']}');
    }

    ModelPriceInfo.map = jsonMap;

    //print('${ModelPriceInfo.get('10','gift')}');
    //print('${ModelPriceInfo.get('10','platform')}');

    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
  }


}


