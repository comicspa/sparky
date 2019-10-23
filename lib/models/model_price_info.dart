import 'package:sparky/manage/manage_device_info.dart';


class ModelPriceInfo
{

  static dynamic getCreditCard(String unit)
  {
    return map[unit]['credit_card'];
  }

  static dynamic getGift(String unit)
  {
    return map[unit]['gift'];
  }

  static dynamic getHappyMoney(String unit)
  {
    return map[unit]['happy_money'];
  }

  static dynamic getPhone(String unit)
  {
    return map[unit]['phone'];
  }

  static dynamic getWire(String unit)
  {
    return map[unit]['wire'];
  }

  static dynamic getPlatform(String unit)
  {
    switch(ManageDeviceInfo.platformType)
    {
      case e_platform_type.ios:
        return map[unit]['apple'];

      case e_platform_type.android:
        return map[unit]['google'];

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

    return map[unit][type];
  }

  static Map<dynamic,dynamic> map;
}

//usage
//ModelPriceInfo.get('10','gift');
//ModelPriceInfo.get('10','platform');