
import 'package:flutter/material.dart';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_featured_comic_info.dart';
import 'package:sparky/packets/packet_c2s_comic_detail_info.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_c2s_price_info.dart';
import 'package:sparky/screens/experiment/page_experiment_packet_connected.dart';

class PageExperimentPacket extends StatefulWidget {
  @override
  _PageExperimentPacketState createState() => new _PageExperimentPacketState();
}

class _PageExperimentPacketState extends State<PageExperimentPacket> {
  // TODO Add build() method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Packet Test'),
      ),
      body: _buildSuggestions(context),
    );
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

              Navigator.of(context).pushReplacementNamed('/PageExperimentApply');

            },
          ),

          ListTile(
            title: Text('connected test'),
            onTap: (){


              Navigator.push<Widget>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageExperimentPacketConnected(),
                  ));




            },
          ),

          ListTile(
            title: Text('Feature Comic Info'),
            onTap: (){

              PacketC2SFeaturedComicInfo c2SFeaturedComicInfo = new PacketC2SFeaturedComicInfo();
              c2SFeaturedComicInfo.generate(_onFetchDone);
              c2SFeaturedComicInfo.fetch(_onFetchDone);


            },
          ),

          ListTile(
            title: Text('Comic Detail Info'),
            onTap: (){

              PacketC2SComicDetailInfo c2SComicDetailInfo = new PacketC2SComicDetailInfo();
              c2SComicDetailInfo.generate('1566811403000','000001','001','001');
              c2SComicDetailInfo.fetch(_onFetchDone);


            },
          ),


          ListTile(
            title: Text('Price Info'),
            onTap: (){

              PacketC2SPriceInfo packetC2SPriceInfo = new PacketC2SPriceInfo();
              packetC2SPriceInfo.generate();
              packetC2SPriceInfo.fetch(_onFetchDone);

            },
          ),



        ], ).toList(), ); }

}