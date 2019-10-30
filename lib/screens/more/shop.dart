import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.

import 'package:sparky/screens/more/uploading_center.dart';
import 'package:sparky/screens/coming_soon.dart';
import 'package:sparky/models/model_price_info.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_c2s_price_info.dart';


// Coming soon page for multi-purpose

class ShopMenuScreen extends StatefulWidget {
  ShopMenuScreen(this.titleText);
  final String titleText;

  @override
  _ShopMenuScreenState createState() =>
      new _ShopMenuScreenState(titleText);
}

class _ShopMenuScreenState extends State<ShopMenuScreen>
    with WidgetsBindingObserver {
  _ShopMenuScreenState(this.titleText);
  String titleText;
  PacketC2SPriceInfo _packetC2SPriceInfo;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    print('titleText : $titleText');

    if(null == _packetC2SPriceInfo)
    {
      _packetC2SPriceInfo = new PacketC2SPriceInfo();
      _packetC2SPriceInfo.generate();
      _packetC2SPriceInfo.fetch(_onFetchDone);
    }
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


  void _onFetchDone(PacketS2CCommon s2cPacket)
  {

    switch(s2cPacket.type)
    {
      case e_packet_type.s2c_price_info:
        {



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
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(ManageDeviceInfo.resolutionHeight * 0.055),
        child: SafeArea(
          child: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 1,
            backgroundColor: Colors
                .white, //Color.fromRGBO(21, 24, 45, 1.0), //Color(0xff202a30), //Colors.black87, // Color(0xFF5986E1),
            title: Text(
              titleText,
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text(
                '내 코미 수:   ${ModelUserInfo.getInstance().comi} 코미', 
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              trailing: null
              /* onTap: () {
                Navigator.push<Widget>(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ComingSoonScreen(),
                  ),
                );
              }, */
            ),
            Divider(),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(15, 20, 0, 5),
              child: Text(
                'Package Lists',
                style: TextStyle(
                    fontSize: ManageDeviceInfo.resolutionHeight * 0.024,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: EdgeInsets.all( ManageDeviceInfo.resolutionWidth * 0.02 ),
              color: Colors.grey,
              child: Container(
                color: Colors.white,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, index) =>
                    Divider(
                      height: ManageDeviceInfo.resolutionHeight * 0.004,
                    ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: /*6,*/ (null != ModelPriceInfo.priceIndexList)? ModelPriceInfo.priceIndexList.length : 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: SizedBox(
                        height: ManageDeviceInfo.resolutionHeight * 0.04,
                        child: Image.asset('images/Comi.png')
                      ),
                      title: Text(
                        /*'코미10',*/'코미${ModelPriceInfo.priceIndexList[index]}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      
                      trailing: Container(
                        color: Colors.redAccent,
                        width: ManageDeviceInfo.resolutionWidth * 0.3,
                        height: ManageDeviceInfo.resolutionWidth * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            
                            Text(
                              /*'10',*/'${ModelPriceInfo.getPlatform(ModelPriceInfo.priceIndexList[index])}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),


                        ],)
                      ),
                      onTap: () {
                        Navigator.push<Widget>(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ComingSoonScreen(),
                          ),
                        );
                      },
                    );
                  }
                ),
              ),
            ),
          ],
      ),
    ),
    );
  }
}
