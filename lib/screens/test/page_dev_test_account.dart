
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_firebase_auth.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:sparky/manage/manage_toast_message.dart';
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



class PageDevTestAccount extends StatefulWidget {
  @override
  _PageDevTestAccountState createState() => new _PageDevTestAccountState();
}

class _PageDevTestAccountState extends State<PageDevTestAccount> {

  List<PacketC2SCommon> _requestPacketList = new List<PacketC2SCommon>();

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

                case e_packet_type.c2s_sign_in:
                  {
                    PacketC2SSignIn packetC2SSignIn = current as PacketC2SSignIn;
                    packetC2SSignIn.generate(ModelUserInfo.getInstance().uId);
                    packetC2SSignIn.fetch(_onFetchDone);
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


  Widget
  _buildSuggestions(BuildContext context)
  {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [

          ListTile(
            title: Text('Go to Next Page !!'),
            onTap: (){

              Navigator.of(context).pushReplacementNamed('/PageDevTestApply');

            },
          ),

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
              _requestPacketList.add(packetC2SSignInWithSocial);

              PacketC2SSignUp packetC2SSignUp = new PacketC2SSignUp();
              _requestPacketList.add(packetC2SSignUp);

              packetC2SSignInWithSocial.fetch(_onFetchDone);
            },
          ),
          ListTile(
            title: Text('Sign in'),
            onTap: (){

              PacketC2SSignInWithSocial packetC2SSignInWithSocial = new PacketC2SSignInWithSocial();
              packetC2SSignInWithSocial.generate(e_social_provider_type.google);
              _requestPacketList.add(packetC2SSignInWithSocial);

              PacketC2SSignIn packetC2SSignIn = new PacketC2SSignIn();
              _requestPacketList.add(packetC2SSignIn);

              packetC2SSignInWithSocial.fetch(_onFetchDone);

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
              _requestPacketList.add(packetC2SSignOut);

              PacketC2SSignOutWithSocial packetC2SSignOutWithSocial = new PacketC2SSignOutWithSocial();
              packetC2SSignOutWithSocial.generate(e_social_provider_type.google);
              _requestPacketList.add(packetC2SSignOutWithSocial);

              packetC2SSignOut.fetch(_onFetchDone);

            },
          ),

          ListTile(
            title: Text('Withdrawal'),
            onTap: (){

              PacketC2SWithdrawal packetC2SWithdrawal = new PacketC2SWithdrawal();
              packetC2SWithdrawal.generate(ModelUserInfo.getInstance().uId);
              _requestPacketList.add(packetC2SWithdrawal);

              PacketC2SSignOutWithSocial packetC2SSignOutWithSocial = new PacketC2SSignOutWithSocial();
              packetC2SSignOutWithSocial.generate(e_social_provider_type.google);
              _requestPacketList.add(packetC2SSignOutWithSocial);

              packetC2SWithdrawal.fetch(_onFetchDone);

            },
          ),

        ], ).toList(), ); }

}