import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:sparky/models/model_user_info.dart';


class ManageFirebaseAuth
{
  static GoogleSignIn _googleSignIn;

  static Future<ModelUserInfo> signInWithGoogle() async
  {
    if(null == _googleSignIn)
    {
      _googleSignIn = new GoogleSignIn(
        scopes: <String>[
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
    }
    else
      {
        if(true == await _googleSignIn.isSignedIn())
          return  ModelUserInfo.getInstance();
      }

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final FirebaseUser user = await FirebaseAuth.instance.signInWithCredential(authCredential);

    //print('userMail : ${user.email}');
    //print('userDisplayName : ${user.displayName}');

    //assert(user.email != null);
    //assert(user.displayName != null);
    //assert(!user.isAnonymous);
    //assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    assert(user.uid == currentUser.uid);
    //print(currentUser.uid);

    //set
    ModelUserInfo.getInstance().socialProviderType = e_social_provider_type.google;
    ModelUserInfo.getInstance().displayName = user.displayName;
    ModelUserInfo.getInstance().photoUrl = user.photoUrl;
    ModelUserInfo.getInstance().email = user.email;
    ModelUserInfo.getInstance().uId = user.uid;
    print('signInWithGoogle : ${ModelUserInfo.getInstance().toString()}');

    //test
    //ModelUserInfo.getInstance().loggedIn = true;

    return ModelUserInfo.getInstance();
  }


  static Future<bool> signOutWithGoogle() async
  {
    if(null == _googleSignIn)
      return false;

    if(false == await _googleSignIn.isSignedIn())
      return false;

    await _googleSignIn.signOut();

    //set
    ModelUserInfo.getInstance().socialProviderType = e_social_provider_type.none;
    ModelUserInfo.getInstance().displayName = '';
    ModelUserInfo.getInstance().photoUrl = '';
    ModelUserInfo.getInstance().email = '';
    ModelUserInfo.getInstance().uId = '';
    print('signOutWithGoogle : ${ModelUserInfo.getInstance().toString()}');

    //test
    //ModelUserInfo.getInstance().loggedIn = false;
    return true;
  }


  static void simpleUsageSignInWithGoogle()
  {
    print('simpleUsageSignInWithGoogle - start');

    ManageFirebaseAuth.signInWithGoogle().then((value)
    {
      //value == ModelUserInfo.getInstance()
      print(value.toString());
      print('success');
    },
        onError: (error)
        {
          print('error : $error');
        }).catchError( (error)
    {
      print('catchError : $error');
    });

    print('simpleUsageSignInWithGoogle - finish');
  }

}