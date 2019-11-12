
enum e_social_provider_type
{
  none,
  google,
  facebook,
  twitter,
}


class ModelUserInfo
{
  static const String ModelName = "model_user_info";

  String _uId;
  List<String> _creatorIdList;
  List<String> _translatorIdList;
  e_social_provider_type _socialProviderType = e_social_provider_type.none;
  int _comi = 0;
  bool _signedIn = false;
  String _email;
  String _userName;
  String _displayName;
  String _photoUrl;
  String _accessToken;
  String _bio;
  String _cloudMessagingToken;
  int _followers = 0;
  int _following = 0;
  int _likes = 0;

  String get uId => _uId;
  List<String> get creatorIdList => _creatorIdList;
  List<String> get translatorIdList => _translatorIdList;
  e_social_provider_type get socialProviderType => _socialProviderType;
  int get comi => _comi;
  bool get signedIn => _signedIn;
  String get email => _email;
  String get userName => _userName;
  String get displayName => _displayName;
  String get photoUrl => _photoUrl;
  String get accessToken => _accessToken;
  String get bio => _bio;
  String get cloudMessagingToken => _cloudMessagingToken;
  int get followers => _followers;
  int get following => _following;
  int get likes => _likes;

  set creatorIdList(List<String> creatorIdList)
  {
    _creatorIdList = creatorIdList;
  }

  set translatorIdList(List<String> translatorIdList)
  {
    _translatorIdList = translatorIdList;
  }

  set socialProviderType(e_social_provider_type socialProviderType)
  {
    _socialProviderType = socialProviderType;
  }

  set comi(int comi)
  {
    _comi = comi;
  }

  set signedIn(bool signedIn)
  {
    _signedIn = signedIn;
  }

  set email(String email)
  {
    _email = email;
  }

  set displayName(String displayName)
  {
    _displayName = displayName;
  }

  set photoUrl(String photoUrl)
  {
    _photoUrl = photoUrl;
  }

  set uId(String uId)
  {
    _uId = uId;
  }

  set accessToken(String accessToken)
  {
    _accessToken = accessToken;
  }

  set userName(String userName)
  {
    _userName = userName;
  }

  set bio(String bio)
  {
    _bio = bio;
  }

  set followers(int followers)
  {
    _followers = followers;
  }

  set following (int following)
  {
    _following = following;
  }

  set likes(int likes)
  {
    _likes = likes;
  }

  set cloudMessagingToken(String cloudMessagingToken)
  {
    _cloudMessagingToken = cloudMessagingToken;
  }

  int getCreatorIdCount()
  {
    if(null == _creatorIdList)
      return 0;
    return _creatorIdList.length;
  }

  void searchAddCreatorId(String creatorId)
  {
    if(null == _creatorIdList)
      _creatorIdList = new List<String>();
    if(-1 != _creatorIdList.indexOf(creatorId))
      return;
    _creatorIdList.add(creatorId);
  }

  void removeCreatorId(String creatorId)
  {
    if(null == _creatorIdList)
      return;
    if(-1 == _creatorIdList.indexOf(creatorId))
      return;
    _creatorIdList.remove(creatorId);
  }


  void removeCreatorIdAt(int countIndex)
  {
    if(null == _creatorIdList)
      return;
    if(0 == _creatorIdList.length)
      return;
    _creatorIdList.removeAt(countIndex);
  }


  void searchAddTranslatorId(String translatorId)
  {
    if(null == _translatorIdList)
      _translatorIdList = new List<String>();
    if(-1 != _translatorIdList.indexOf(translatorId))
      return;
    _translatorIdList.add(translatorId);
  }

  void removeTranslatorId(String translatorId)
  {
    if(null == _translatorIdList)
      return;
    if(-1 == _translatorIdList.indexOf(translatorId))
      return;
    _translatorIdList.remove(translatorId);
  }

  void removeTranslatorIdAt(int countIndex)
  {
    if(null == _translatorIdList)
      return;
    if(0 == _translatorIdList.length)
      return;
    _translatorIdList.removeAt(countIndex);
  }

  int getTranslatorIdCount()
  {
    if(null == _translatorIdList)
      return 0;
    return _translatorIdList.length;
  }

  void signOut()
  {
    displayName = null;
    photoUrl = null;
    email = null;
    signedIn = false;
    followers = 0;
    following = 0;
    likes = 0;
    comi = 0;
    creatorIdList = null;
    translatorIdList = null;
  }

  void withdrawal()
  {
    signOut();

    socialProviderType = e_social_provider_type.none;
    uId = null;
  }

  @override
  String toString()
  {
    return 'email : $_email , displayName : $_displayName , photoUrl : $_photoUrl , _followers : $_followers , bio : $_bio , uid : $_uId';
  }

  static ModelUserInfo _instance;
  static ModelUserInfo getInstance()
  {
    if(_instance == null)
    {
        _instance = ModelUserInfo();
        return _instance;
    }

    return _instance;
  }

}



