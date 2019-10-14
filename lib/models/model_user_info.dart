
enum e_social_provider_type
{
  none,
  google,
  facebook,
  twitter,
}


class ModelUserInfo
{
  String _uId;
  String _creatorId;
  String _translatorId;
  e_social_provider_type _socialProviderType = e_social_provider_type.none;
  int _comi = 0;
  bool _signedIn = false;
  String _email;
  String _userName;
  String _displayName;
  String _photoUrl;
  String _accessToken;
  String _bio;
  int _followers = 0;
  int _following = 0;
  int _likes = 0;

  String get uId => _uId;
  String get creatorId => _creatorId;
  String get translatorId => _translatorId;
  e_social_provider_type get socialProviderType => _socialProviderType;
  int get comi => _comi;
  bool get signedIn => _signedIn;
  String get email => _email;
  String get userName => _userName;
  String get displayName => _displayName;
  String get photoUrl => _photoUrl;
  String get accessToken => _accessToken;
  String get bio => _bio;
  int get followers => _followers;
  int get following => _following;
  int get likes => _likes;

  set creatorId(String creatorId)
  {
    _creatorId = creatorId;
  }

  set translatorId(String translatorId)
  {
    _translatorId = translatorId;
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
    creatorId = null;
    translatorId = null;
  }

  void withdrawal()
  {
    signOut();

    socialProviderType = e_social_provider_type.none;
    uId = null;
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
    return 'email : $_email , displayName : $_displayName , photoUrl : $_photoUrl , _followers : $_followers , bio : $_bio , uid : $_uId';
  }

}