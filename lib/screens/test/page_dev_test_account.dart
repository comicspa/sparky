
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_firebase_auth.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_sign_up.dart';
import 'package:sparky/packets/packet_c2s_withdrawal.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_c2s_sign_in_with_social.dart';
import 'package:sparky/packets/packet_c2s_sign_out_with_social.dart';
import 'package:sparky/packets/packet_c2s_sign_in.dart';
import 'package:sparky/packets/packet_c2s_sign_out.dart';
import 'package:sparky/packets/packet_c2s_register_creator.dart';
import 'package:sparky/packets/packet_c2s_unregister_creator.dart';
import 'package:fluttertoast/fluttertoast.dart';


class PageDevTestAccount extends StatefulWidget {
  @override
  _PageDevTestAccountState createState() => new _PageDevTestAccountState();
}

class _PageDevTestAccountState extends State<PageDevTestAccount> {


  List<PacketC2SCommon> _list = new List<PacketC2SCommon>();


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

          /*
          Fluttertoast.showToast(
              msg: "Sign in with social !!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);

           */



          _list.removeAt(0);
          if(_list.length > 0)
            {
              PacketC2SCommon current = _list[0];
              switch(current.type)
              {
                case e_packet_type.c2s_sign_up:
                  {
                    PacketC2SSignUp packetC2SSignUp = current as PacketC2SSignUp;
                    packetC2SSignUp.generate(ModelUserInfo.getInstance().uId, ModelUserInfo.getInstance().socialProviderType);
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

          /*
          Fluttertoast.showToast(
              msg: "Sign out with social !!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
          */


          _list.removeAt(0);

        }
        break;

      case e_packet_type.s2c_sign_up:
        {
          _list.removeAt(0);


          Fluttertoast.showToast(
              msg: "SignUp !!",
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
              msg: "Withdrawal !!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);

          _list.removeAt(0);
          //print('_list.length : ${_list.length}');

          if(_list.length > 0)
          {
            PacketC2SCommon current = _list[0];
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

          Fluttertoast.showToast(
              msg: "SignIn !!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);

        }
        break;

      case e_packet_type.s2c_sign_out:
        {

          Fluttertoast.showToast(
              msg: "SignOut !!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);

        }
        break;

      case e_packet_type.s2c_register_creator:
        {

          Fluttertoast.showToast(
              msg: "Register Creator !!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);

        }
        break;

      case e_packet_type.s2c_unregister_creator:
        {

          Fluttertoast.showToast(
              msg: "Unregister Creator !!",
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

          /*
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

           */

          ListTile(
            title: Text('Sign up'),
            onTap: (){

              PacketC2SSignInWithSocial packetC2SSignInWithSocial = new PacketC2SSignInWithSocial();
              packetC2SSignInWithSocial.generate(e_social_provider_type.google);
              _list.add(packetC2SSignInWithSocial);

              PacketC2SSignUp packetC2SSignUp = new PacketC2SSignUp();
              _list.add(packetC2SSignUp);

              packetC2SSignInWithSocial.fetch(_onFetchDone);
            },
          ),
          ListTile(
            title: Text('Sign in'),
            onTap: (){

              PacketC2SSignIn packetC2SSignIn = new PacketC2SSignIn();
              packetC2SSignIn.generate(ModelUserInfo.getInstance().uId);
              packetC2SSignIn.fetch(_onFetchDone);

            },
          ),

          ListTile(
            title: Text('Register Creator'),
            onTap: (){

              PacketC2SRegisterCreator packetC2SRegisterCreator = new PacketC2SRegisterCreator();
              packetC2SRegisterCreator.generate(ModelUserInfo.getInstance().uId);
              packetC2SRegisterCreator.fetch(_onFetchDone);

            },
          ),

          ListTile(
            title: Text('Unregister Creator'),
            onTap: (){

              PacketC2SUnregisterCreator packetC2SUnregisterCreator = new PacketC2SUnregisterCreator();
              packetC2SUnregisterCreator.generate(ModelUserInfo.getInstance().uId);
              packetC2SUnregisterCreator.fetch(_onFetchDone);


            },
          ),


          ListTile(
            title: Text('Sign out'),
            onTap: (){

              PacketC2SSignOut packetC2SSignOut = new PacketC2SSignOut();
              packetC2SSignOut.generate(ModelUserInfo.getInstance().uId);
              packetC2SSignOut.fetch(_onFetchDone);

            },
          ),

          ListTile(
            title: Text('Withdrawal'),
            onTap: (){

              PacketC2SWithdrawal packetC2SWithdrawal = new PacketC2SWithdrawal();
              packetC2SWithdrawal.generate(ModelUserInfo.getInstance().uId);
              _list.add(packetC2SWithdrawal);

              PacketC2SSignOutWithSocial packetC2SSignOutWithSocial = new PacketC2SSignOutWithSocial();
              packetC2SSignOutWithSocial.generate(e_social_provider_type.google);
              _list.add(packetC2SSignOutWithSocial);

              packetC2SWithdrawal.fetch(_onFetchDone);

            },
          ),

        ], ).toList(), ); }

}