import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:sparky/models/model_user_info.dart';

// https://sheeeng.github.io/dart/firebase/flutter/authentication/2019/01/20/sign-in-failed-on-flutter.html
// https://codeday.me/ko/qa/20190324/96545.html

class ManageFirebaseAuth
{
  static GoogleSignIn _googleSignIn;

  static Future<bool> signInWithGoogle() async
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
          return  true;
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
    print(currentUser.uid);

    //set
    ModelUserInfo.getInstance().socialProviderType = e_social_provider_type.google;
    ModelUserInfo.getInstance().displayName = user.displayName;
    ModelUserInfo.getInstance().photoUrl = user.photoUrl;
    ModelUserInfo.getInstance().email = user.email;
    ModelUserInfo.getInstance().uId = user.uid;
    print('signInWithGoogle : ${ModelUserInfo.getInstance().toString()}');

    //test
    //ModelUserInfo.getInstance().loggedIn = true;

    return true;
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


  static GoogleSignIn processGoogleSignIn()
  {
    return new GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }


  static void googleSignOut() async
  {
    GoogleSignIn googleSignIn = processGoogleSignIn();
    if(true == await googleSignIn.isSignedIn())
    {
      await  googleSignIn.signOut();
    }
  }

  static Future<FirebaseUser> googleSignIn() async
  {
    GoogleSignIn googleSignIn = ManageFirebaseAuth.processGoogleSignIn();

    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
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
    return currentUser;
  }

}