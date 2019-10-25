import 'package:sparky/manage/manage_device_info.dart';


class ModelPriceInfo
{

  static dynamic getCreditCard(String unit)
  {
    return _map[unit]['credit_card'];
  }

  static dynamic getGift(String unit)
  {
    return _map[unit]['gift'];
  }

  static dynamic getHappyMoney(String unit)
  {
    return _map[unit]['happy_money'];
  }

  static dynamic getPhone(String unit)
  {
    return _map[unit]['phone'];
  }

  static dynamic getWire(String unit)
  {
    return _map[unit]['wire'];
  }

  static dynamic getPlatform(String unit)
  {
    switch(ManageDeviceInfo.platformType)
    {
      case e_platform_type.ios:
        return _map[unit]['apple'];

      case e_platform_type.android:
        return _map[unit]['google'];

      default:
        break;
    }

    return null;
  }


  static dynamic get(String unit,String type)
  {
    if(0 == type.compareTo('platform'))
      {
        return getPlatform(unit);
      }

    return _map[unit][type];
  }

  static Map<dynamic,dynamic> _map;
  static List<String> priceIndexList;

  static Map<dynamic,dynamic> get map => _map;
  static set map(Map<dynamic,dynamic> map)
  {
    _map = map;

    priceIndexList = _map.keys.toList().cast<String>();
    priceIndexList.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
    //priceIndexList = ModelPriceInfo.map.keys.toList()..sort((a, b) => (int.parse(a)).compareTo(int.parse(b)));

    for(int i=0; i<priceIndexList.length; ++i)
    {
      print('$i:${priceIndexList[i]}');
    }

  }


}

//usage
//ModelPriceInfo.get('10','gift');
//ModelPriceInfo.get('10','platform');