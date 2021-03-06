import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart';// use this to make all the widget size responsive to the device size.
import 'package:sparky/manage/manage_toast_message.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/gestures.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_c2s_sign_up.dart';
import 'package:sparky/packets/packet_c2s_sign_in.dart';
import 'package:sparky/packets/packet_c2s_sign_out.dart';
import 'package:sparky/packets/packet_c2s_withdrawal.dart';
import 'package:sparky/packets/packet_c2s_sign_in_with_social.dart';
import 'package:sparky/packets/packet_c2s_sign_out_with_social.dart';
import 'package:sparky/packets/packet_c2s_unregister_creator.dart';
import 'package:sparky/packets/packet_c2s_unregister_translator.dart';



class SignInUpLandPage extends StatefulWidget {


  @override
  _SignInUpLandPageState createState() => new _SignInUpLandPageState();
}

class _SignInUpLandPageState extends State<SignInUpLandPage>  with WidgetsBindingObserver {
 

  List<PacketC2SCommon> _requestPacketList = new List<PacketC2SCommon>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

  }


  void _onFetchDone(PacketS2CCommon packetS2CCommon)
  {
    print('[SignInUpLandPage] : onFetchDone');


    switch(packetS2CCommon.type)
    {
      case e_packet_type.s2c_sign_in_with_social:
        {
          //ManageToastMessage.showShortLength('Sign in with social !!');

          _requestPacketList.removeAt(0);
          if(_requestPacketList.length > 0)
          {
            PacketC2SCommon current = _requestPacketList[0];
            switch(current.type)
            {
              case e_packet_type.c2s_sign_up:
                {
                  PacketC2SSignUp packetC2SSignUp = current as PacketC2SSignUp;
                  packetC2SSignUp.generate(ModelUserInfo.getInstance().uId, ModelUserInfo.getInstance().socialProviderType,ModelUserInfo.getInstance().email);
                  packetC2SSignUp.fetch(_onFetchDone);
                }
                break;

              default:
                break;
            }
          }


        }
        break;

      case e_packet_type.s2c_sign_out_with_social:
        {
          //ManageToastMessage.showShortLength('Sign out with social !!');
          _requestPacketList.removeAt(0);

        }
        break;

      case e_packet_type.s2c_sign_up:
        {
          _requestPacketList.removeAt(0);

          ManageToastMessage.showShort('SignUp !!');
        }
        break;

      case e_packet_type.s2c_withdrawal:
        {

          ManageToastMessage.showShort('Withdrawal !!');
          _requestPacketList.removeAt(0);
          //print('_list.length : ${_list.length}');

          if(_requestPacketList.length > 0)
          {
            PacketC2SCommon current = _requestPacketList[0];
            switch(current.type)
            {
              case e_packet_type.c2s_sign_out_with_social:
                {
                  PacketC2SSignOutWithSocial packetC2SSignOutWithSocial = current as PacketC2SSignOutWithSocial;
                  packetC2SSignOutWithSocial.generate(e_social_provider_type.google);
                  packetC2SSignOutWithSocial.fetch(_onFetchDone);
                }
                break;

              default:
                break;
            }
          }


        }
        break;

      case e_packet_type.s2c_sign_in:
        {
          ManageToastMessage.showShort('SignIn !!');
        }
        break;

      case e_packet_type.s2c_sign_out:
        {
          ManageToastMessage.showShort('SignOut !!');
        }
        break;

      case e_packet_type.s2c_register_creator:
        {
          ManageToastMessage.showShort('Register Creator !!');
        }
        break;

      case e_packet_type.s2c_unregister_creator:
        {
          ManageToastMessage.showShort('Unregister Creator !!');
        }
        break;

      default:
        break;
    }

    setState(() {

    });
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
                size: 20,
              ),
            ),
            SizedBox(
              width: ManageDeviceInfo.resolutionWidth * 0.7,
              child: Padding(padding: EdgeInsets.all(15.0),
                child: Text(
                  'Please Sign-In or Sign-Up',
                  maxLines: 2,
                  textAlign: TextAlign.center,
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


                if(false == ModelUserInfo.getInstance().signedIn)
                {
                  PacketC2SSignIn packetC2SSignIn = new PacketC2SSignIn();
                  packetC2SSignIn.generate(ModelUserInfo.getInstance().uId,_onFetchDone);
                  packetC2SSignIn.fetch(_onFetchDone);
                }
                else
                  {
                    PacketC2SSignOut packetC2SSignOut = new PacketC2SSignOut();
                    packetC2SSignOut.generate(ModelUserInfo
                        .getInstance()
                        .uId);
                    packetC2SSignOut.fetch(_onFetchDone);
                  }

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
                            Navigator.pop(context);
                            showModalBottomSheet(
                              isScrollControlled: false, // true if model needs to cover entire screen
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (BuildContext context){
                                return signUpPage();
                              },
                            );
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

              if(null == ModelUserInfo.getInstance().uId)
              {
                PacketC2SSignInWithSocial packetC2SSignInWithSocial = new PacketC2SSignInWithSocial();
                packetC2SSignInWithSocial.generate(e_social_provider_type.google);
                _requestPacketList.add(packetC2SSignInWithSocial);

                PacketC2SSignUp packetC2SSignUp = new PacketC2SSignUp();
                _requestPacketList.add(packetC2SSignUp);

                packetC2SSignInWithSocial.fetch(_onFetchDone);
              }
              else
                {

                  PacketC2SUnregisterCreator packetC2SUnregisterCreator = new PacketC2SUnregisterCreator();
                  packetC2SUnregisterCreator.generate(ModelUserInfo.getInstance().uId);
                  _requestPacketList.add(packetC2SUnregisterCreator);

                  PacketC2SUnregisterTranslator packetC2SUnregisterTranslator = new PacketC2SUnregisterTranslator();
                  packetC2SUnregisterTranslator.generate(ModelUserInfo.getInstance().uId);
                  _requestPacketList.add(packetC2SUnregisterTranslator);

                  PacketC2SWithdrawal packetC2SWithdrawal = new PacketC2SWithdrawal();
                  packetC2SWithdrawal.generate(ModelUserInfo.getInstance().uId);
                  _requestPacketList.add(packetC2SWithdrawal);

                  PacketC2SSignOutWithSocial packetC2SSignOutWithSocial = new PacketC2SSignOutWithSocial();
                  packetC2SSignOutWithSocial.generate(ModelUserInfo.getInstance().socialProviderType);
                  _requestPacketList.add(packetC2SSignOutWithSocial);

                  //packetC2SWithdrawal.fetch(_onFetchDone);
                  packetC2SUnregisterCreator.fetch(_onFetchDone);
                }

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
                            Navigator.pop(context);
                            showModalBottomSheet(
                              isScrollControlled: false, // true if model needs to cover entire screen
                              backgroundColor: Colors.white,                              
                              context: context,
                              builder: (BuildContext context){
                                return signInPage();
                                },
                            );
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

