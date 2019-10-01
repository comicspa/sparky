import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:sparky/models/model_user_info.dart';

// https://sheeeng.github.io/dart/firebase/flutter/authentication/2019/01/20/sign-in-failed-on-flutter.html
// https://codeday.me/ko/qa/20190324/96545.html

class ManageFirebaseAuth
{
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