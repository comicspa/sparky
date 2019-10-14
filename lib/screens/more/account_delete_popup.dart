import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sparky/manage/manage_firebase_storage.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_c2s_sign_out_with_social.dart';
import 'package:sparky/packets/packet_c2s_withdrawal.dart';
import 'package:fluttertoast/fluttertoast.dart';


// Coming soon page for multi-purpose


class AccountDeleteWidget extends StatefulWidget {
  const AccountDeleteWidget({
    Key key,
    this.titleText,
    }) : super(key: key);
  
  final String titleText;

  _AccountDeleteWidgetState createState() => _AccountDeleteWidgetState(this.titleText);
}


class _AccountDeleteWidgetState extends State<AccountDeleteWidget> with WidgetsBindingObserver{
  _AccountDeleteWidgetState(this.titleText);
  String titleText;

  TextEditingController _textInputController = TextEditingController();
  String _showText = "";
  List<PacketC2SCommon> _requestPacketList = new List<PacketC2SCommon>();

  @override
    void initState() {
      WidgetsBinding.instance.addObserver(this);
      super.initState();

      print('titleText : $titleText');
    }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
  }


  _onPressed() {

    PacketC2SWithdrawal packetC2SWithdrawal = new PacketC2SWithdrawal();
    packetC2SWithdrawal.generate(ModelUserInfo.getInstance().uId);
    _requestPacketList.add(packetC2SWithdrawal);

    PacketC2SSignOutWithSocial packetC2SSignOutWithSocial = new PacketC2SSignOutWithSocial();
    packetC2SSignOutWithSocial.generate(ModelUserInfo.getInstance().socialProviderType);
    _requestPacketList.add(packetC2SSignOutWithSocial);

    packetC2SWithdrawal.fetch(_onFetchDone);

    setState(() {
      _showText = _textInputController.text;
    });
  }


  void _onFetchDone(PacketS2CCommon s2cPacket)
  {
    print('[PageDevTestAccount] : onFetchDone');


    switch(s2cPacket.type)
    {

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

          _requestPacketList.removeAt(0);

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
                  packetC2SSignOutWithSocial.generate(ModelUserInfo.getInstance().socialProviderType);
                  packetC2SSignOutWithSocial.fetch(_onFetchDone);
                }
                break;

              default:
                break;
            }
          }

        }
        break;

      default:
        break;
    }



    setState(() {

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Text Input Value'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Submitted Text: $_showText"),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: _textInputController,
                  autocorrect: true,
                  decoration: InputDecoration(hintText: 'Enter a \'delete\' here'),
                ),
              ),
              RaisedButton(
                onPressed: _onPressed,
                child: Text('Submit'),
              )
            ],
          ),
        ));
  }
}

