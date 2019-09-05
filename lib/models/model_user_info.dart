
enum e_social_provider_type
{
  none,
  google,
  facebook,
  twitter,
}


class ModelUserInfo
{
  String _id;
  String _creatorId;
  e_social_provider_type _socialProviderType = e_social_provider_type.none;
  int _comi;
  bool _loggedIn = false;
  String _email;
  String _displayName;
  String _photoUrl;
  String _uId;
  String _accessToken;

  String get id => _id;
  String get creatorId => _creatorId;
  e_social_provider_type get socialProviderType => _socialProviderType;
  int get comi => _comi;
  bool get loggedIn => _loggedIn;
  bool get me => _loggedIn;
  String get email => _email;
  String get displayName => _displayName;
  String get photoUrl => _photoUrl;
  String get uId => _uId;
  String get accessToken => _accessToken;

  set id(String id)
  {
    _id = id;
  }

  set creatorId(String creatorId)
  {
    _creatorId = creatorId;
  }

  set socialProviderType(e_social_provider_type socialProviderType)
  {
    _socialProviderType = socialProviderType;
  }

  set comi(int comi)
  {
    _comi = comi;
  }

  set loggedIn(bool loggedIn)
  {
    _loggedIn = loggedIn;
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
    _photoUrl = photoUrl;;
  }

  set uId(String uId)
  {
    _uId = uId;
  }

  set accessToken(String accessToken)
  {
    _accessToken = accessToken;
  }


  static ModelUserInfo _instance;
  static ModelUserInfo getInstance() {
    if(_instance == null) {
      _instance = ModelUserInfo();
      return _instance;
    }
    return _instance;
  }

  @override
  String toString()
  {
    return 'email : $_email , displayName : $_displayName , photoUrl : $_photoUrl , uId : $uId';
  }

}