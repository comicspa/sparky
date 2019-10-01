import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart';// use this to make all the widget size responsive to the device size.
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/gestures.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/manage/manage_firebase_auth.dart';



class NotificationLandingPage extends StatefulWidget {
  @override
  _NotificationLandingPageState createState() => new _NotificationLandingPageState();
}

class _NotificationLandingPageState extends State<NotificationLandingPage>  with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)
  {
    print('state = $state');
  }


  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: ManageDeviceInfo.resolutionHeight * 0.15,),
            Container(
              child: Icon(
                Icons.info_outline,
                size: 35,
              ),
            ),
            SizedBox(
              width: ManageDeviceInfo.resolutionWidth * 0.7,
              child: Padding(padding: EdgeInsets.all(15.0),
                child: Text(
                  'Notification feature requires sign in, please sign in or sign up!',
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
            ),
            SizedBox(height: ManageDeviceInfo.resolutionHeight * 0.1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blueAccent,
                  child: Text('Sing in'),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: false, // true if model needs to cover entire screen
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (BuildContext context){
                        return signInPage();

                      },
                    );
                  },
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  child: Text('Sign up'),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: false, // true if model needs to cover entire screen
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (BuildContext context){
                        return signUpPage();

                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );

  }

  Center signInPage() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text('Sign in',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: ManageDeviceInfo.resolutionWidth * .07,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            Divider(),
            SignInButton(
              Buttons.Google,
              onPressed: () {

                /*
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

                 */
              },
            ),
            SignInButton(
              Buttons.Facebook,
              onPressed: () {},
            ),
            SignInButton(
              Buttons.Twitter,
              text: "Use Twitter",
              onPressed: () {},
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SignInButton(
                  Buttons.LinkedIn,
                  mini: true,
                  onPressed: () {},
                ),
                SignInButton(
                  Buttons.Tumblr,
                  mini: true,
                  onPressed: () {},
                ),

              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Go to Sign up',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          fontSize: ManageDeviceInfo.resolutionHeight * 0.02,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          signUpPage();
                        },
                      )
                    ]
                  )
                ),
              ),
            ),
          ],
        ),
      );
  }


  Center signUpPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text('Sign up',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ManageDeviceInfo.resolutionWidth * .07,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
              ),
            ),
          ),
          Divider(),
          SignInButton(
            Buttons.Google,
            onPressed: () {

              /*
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

               */
            },
          ),
          SignInButton(
            Buttons.Facebook,
            onPressed: () {},
          ),
          SignInButton(
            Buttons.Twitter,
            text: "Use Twitter",
            onPressed: () {},
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SignInButton(
                Buttons.LinkedIn,
                mini: true,
                onPressed: () {},
              ),
              SignInButton(
                Buttons.Tumblr,
                mini: true,
                onPressed: () {},
              ),

            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Go to Sign in',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            fontSize: ManageDeviceInfo.resolutionHeight * 0.02,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            signInPage();
                          },
                        )
                      ]
                  )
              ),
            ),
          ),

        ],
      ),
    );
  }

}

