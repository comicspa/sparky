
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_firebase_auth.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_signup.dart';
import 'package:sparky/packets/packet_c2s_withdrawal.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_s2c_signup.dart';
import 'package:sparky/packets/packet_s2c_withdrawal.dart';
import 'package:sparky/packets/packet_c2s_sign_in_with_social.dart';
import 'package:sparky/packets/packet_c2s_sign_out_with_social.dart';
import 'package:fluttertoast/fluttertoast.dart';


class PageDevTestAccount extends StatefulWidget {
  @override
  _PageDevTestAccountState createState() => new _PageDevTestAccountState();
}

class _PageDevTestAccountState extends State<PageDevTestAccount> {
  // TODO Add build() method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Test'),
      ),
      body: _buildSuggestions(context),
    );
  }

  void _onFetchDone(PacketS2CCommon s2cPacket)
  {
    print('[PageDevTestAccount] : onFetchDone');


    switch(s2cPacket.type)
    {
      case e_packet_type.s2c_sign_in_with_social:
        {
          Fluttertoast.showToast(
              msg: "Sign in with social",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        break;

      case e_packet_type.s2c_sign_out_with_social:
        {
          Fluttertoast.showToast(
              msg: "Sign out with social",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        break;

      case e_packet_type.s2c_sign_up:
        {

          Fluttertoast.showToast(
              msg: "회원가입 되었습니다.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);

        }
        break;

      case e_packet_type.s2c_withdrawal:
        {

          Fluttertoast.showToast(
              msg: "회원탈퇴 되었습니다.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);

        }
        break;

      default:
        break;
    }



    setState(() {

    });
  }


  Widget
  _buildSuggestions(BuildContext context)
  {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [


          ListTile(
            title: Text('Check uid'),
            onTap: (){

              ManageFirebaseDatabase.checkUserInfo('000011111');

            },
          ),

          ListTile(
            title: Text('Google SignIn'),
            onTap: (){

              PacketC2SSignInWithSocial packetC2SSignInWithSocial = new PacketC2SSignInWithSocial();
              packetC2SSignInWithSocial.generate(e_social_provider_type.google);
              packetC2SSignInWithSocial.fetch(_onFetchDone);

            },
          ),
          ListTile(
            title: Text('Google SignOut'),
            onTap: (){

              PacketC2SSignOutWithSocial packetC2SSignOutWithSocial = new PacketC2SSignOutWithSocial();
              packetC2SSignOutWithSocial.generate(e_social_provider_type.google);
              packetC2SSignOutWithSocial.fetch(_onFetchDone);

            },
          ),



          ListTile(
            title: Text('Sign up'),
            onTap: (){

                PacketC2SSignUp packetC2SSignUp = new PacketC2SSignUp();
                packetC2SSignUp.generate(ModelUserInfo.getInstance().uId, ModelUserInfo.getInstance().socialProviderType);
                packetC2SSignUp.fetch(_onFetchDone);

            },
          ),
          ListTile(
            title: Text('Sign in'),
            onTap: (){


            },
          ),

          ListTile(
            title: Text('Register Creator'),
            onTap: (){


            },
          ),

          ListTile(
            title: Text('Unregister Creator'),
            onTap: (){


            },
          ),


          ListTile(
            title: Text('Sign out'),
            onTap: (){


            },
          ),

          ListTile(
            title: Text('Withdrawal'),
            onTap: (){

              PacketC2SWithdrawal packetC2SWithdrawal = new PacketC2SWithdrawal();
              packetC2SWithdrawal.generate(ModelUserInfo.getInstance().uId);
              packetC2SWithdrawal.fetch(_onFetchDone);

            },
          ),

        ], ).toList(), ); }

}