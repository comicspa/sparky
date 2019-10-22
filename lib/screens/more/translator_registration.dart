import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.
import 'package:sparky/manage/manage_toast_message.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_c2s_register_translator.dart';
import 'package:sparky/packets/packet_c2s_unregister_translator.dart';


// Coming soon page for multi-purpose

class TranslatorRegistrationWidget extends StatelessWidget {
   TranslatorRegistrationWidget({
    Key key,
    this.titleText,
    }) : super(key: key);
  
  final String titleText;

   void _onFetchDone(PacketS2CCommon s2cPacket)
   {
     print('[TranslatorRegistrationWidget] : onFetchDone');


     switch (s2cPacket.type)
     {
       case e_packet_type.s2c_register_translator:
         {
           ManageToastMessage.showShort('Register Translator !!');
         }
         break;

       case e_packet_type.s2c_unregister_translator:
         {
           ManageToastMessage.showShort('Unregister Translator !!');
         }
         break;

       default:
         break;
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ManageDeviceInfo.resolutionHeight * 0.055),
        child: SafeArea(
          child: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 1,
            backgroundColor: Colors.white, //Color.fromRGBO(21, 24, 45, 1.0), //Color(0xff202a30), //Colors.black87, // Color(0xFF5986E1),
            title: Text(titleText,
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(CupertinoIcons.info),
              title: Text('This is the Translator registration page.'),
              subtitle: Text('Please follow the steps'),
              isThreeLine: true,
              onTap:(){
                print('onTap');

                if(true == ModelUserInfo.getInstance().signedIn)
                {
                  if(null == ModelUserInfo.getInstance().translatorList || 0 == ModelUserInfo.getInstance().translatorList.length)
                  {
                    PacketC2SRegisterTranslator packetC2SRegisterTranslator = new PacketC2SRegisterTranslator();
                    packetC2SRegisterTranslator.generate(ModelUserInfo.getInstance().uId);
                    packetC2SRegisterTranslator.fetch(_onFetchDone);
                  }
                  else
                  {
                    PacketC2SUnregisterTranslator packetC2SUnregisterTranslator = new PacketC2SUnregisterTranslator();
                    packetC2SUnregisterTranslator.generate(ModelUserInfo.getInstance().uId);
                    packetC2SUnregisterTranslator.fetch(_onFetchDone);
                  }
                }
                else
                {
                  ManageToastMessage.showShort('Required SiginUp or SignIn');
                }

              },
            ),
          ),
          
          
         
        ],
      ),
    );
  }
}


