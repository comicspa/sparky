

class ModelLocalizationInfo
{
  static Map<dynamic,dynamic> _languagePack;
  static Map<dynamic,dynamic> get languagePack  => _languagePack;

  static set languagePack(Map<dynamic,dynamic> languagePack)
  {
    _languagePack = languagePack;
  }

  static String getText(String category,String key)
  {
    if(null == _languagePack)
      return '';
    return _languagePack[category][key];
  }

}


//usage
// String buttonText = ModelLocalizationInfo.getText('trend','button_1');