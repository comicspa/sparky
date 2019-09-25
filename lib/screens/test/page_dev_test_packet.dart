
import 'package:flutter/material.dart';

import 'package:sparky/packets/packet_c2s_featured_comic_info.dart';
import 'package:sparky/packets/packet_s2c_common.dart';

class PageDevTestPacket extends StatefulWidget {
  @override
  _PageDevTestPacketState createState() => new _PageDevTestPacketState();
}

class _PageDevTestPacketState extends State<PageDevTestPacket> {
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
            title: Text('Feature Comic Info'),
            onTap: (){

              PacketC2SFeaturedComicInfo c2SFeaturedComicInfo = new PacketC2SFeaturedComicInfo();
              c2SFeaturedComicInfo.generate(0, 0);
              c2SFeaturedComicInfo.fetch(_onFetchDone);


            },
          ),


        ], ).toList(), ); }

}