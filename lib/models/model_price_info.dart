import 'package:sparky/manage/manage_device_info.dart';


class ModelPriceInfo
{
  static dynamic get(String unit,String type)
  {
    if(0 == type.compareTo('platform'))
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
      }

    return map[unit][type];
  }

  static Map<dynamic,dynamic> map;
}