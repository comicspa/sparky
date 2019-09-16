
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
  String _userName;
  String _displayName;
  String _photoUrl;
  String _uId;
  String _accessToken;
  String _bio;
  int _followers;
  int _following;
  int _likes;

  String get id => _id;
  String get creatorId => _creatorId;
  e_social_provider_type get socialProviderType => _socialProviderType;
  int get comi => _comi;
  bool get loggedIn => _loggedIn;
  bool get me => _loggedIn;
  String get email => _email;
  String get userName => _userName;
  String get displayName => _displayName;
  String get photoUrl => _photoUrl;
  String get uId => _uId;
  String get accessToken => _accessToken;
  String get bio => _bio;
  int get followers => _followers;
  int get foloowing => _following;
  int get likes => _likes;

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
    return 'email : $_email , displayName : $_displayName , photoUrl : $_photoUrl , _followers : $_followers , bio : $_bio';
  }

}