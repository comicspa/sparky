import 'package:shared_preferences/shared_preferences.dart';


class ManageSharedPreference
{

  static void clear() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static void remove(String key) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<int> getInt(String key) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(key))
      return prefs.getInt(key);

    return null;
  }

  static Future<bool> getBool(String key) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(key))
      return prefs.getBool(key);

    return null;
  }

  static Future<String> getString(String key) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(key))
      return prefs.getString(key);

    return null;
  }

  static Future<List<String>> getStringList(String key) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(key))
      return prefs.getStringList(key);

    return null;
  }

  static Future<double> getDouble(String key) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(key))
      return prefs.getDouble(key);

    return null;
  }

  static Future<Map<String,dynamic>> gets(List<String> keyList) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String,dynamic> resultMap;

    for(int countIndex=0; countIndex<keyList.length; ++countIndex)
    {
      if(null == resultMap)
        resultMap = new Map<String,dynamic>();

      if(prefs.containsKey(keyList[countIndex]))
      {
        resultMap[keyList[countIndex]] = prefs.get(keyList[countIndex]);
      }
    }
    return resultMap;
  }


  static void setInt(String key,int value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key,value);
  }

  static void setBool(String key,bool value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static void setString(String key,String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static void setStringList(String key,List<String> value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }

  static void setDouble(String key,double value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  static void sets(Map<String,dynamic> prefMap) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var entry in prefMap.entries)
    {
      switch(entry.value.runtimeType)
      {
        case int:
          {
            await prefs.setInt(entry.key, entry.value);
          }
          break;

        case double:
          {
            await prefs.setDouble(entry.key, entry.value);
          }
          break;

        case bool:
          {
            await prefs.setBool(entry.key, entry.value);
          }
          break;

        case String:
          {
            await prefs.setString(entry.key, entry.value);
          }
          break;
      }
    }
  }
}