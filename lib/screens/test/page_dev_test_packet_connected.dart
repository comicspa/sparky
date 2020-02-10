import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_c2s_echo.dart';
import 'package:sparky/packets/packet_s2c_echo.dart';


class Message
{
  int id;
  String content;
  String title;

  static List<Message> list;
}


class PageDevTestPacketConnected extends StatefulWidget {
  @override
  _PageDevTestPacketConnectedState createState() => _PageDevTestPacketConnectedState();
}



class _PageDevTestPacketConnectedState extends State<PageDevTestPacketConnected>
{
  Timer _timer;
  StreamController<List<Message>> _streamController = StreamController();
  PacketC2SEcho _packetC2SEcho = new PacketC2SEcho();

  @override
  void initState()
  {
    super.initState();

    const duration = const Duration(seconds:5);
    if(null == _timer)
      _timer = new Timer.periodic(duration, update);

    _packetC2SEcho.generate();
    _packetC2SEcho.fetch(_onFetchDone);
  }


  void _onFetchDone(PacketS2CCommon s2cPacket)
  {
    switch(s2cPacket.type)
    {
      case e_packet_type.s2c_echo:
        {
          String content = (s2cPacket as PacketS2CEcho).message;
          print('content : $content');
          List<String> contentList = content.split('&&');
          print('content length : ${contentList.length}');

          if(null == Message.list)
            Message.list = new List<Message>();

          bool searched = false;
          if(Message.list.length > 0)
            {
              if(0 == Message.list[Message.list.length-1].content.compareTo(contentList[1]))
                {
                  searched = true;
                }
            }


          if(false == searched)
          {
            Message message = new Message();
            message.id = Message.list.length + 1;
            message.title = contentList[0];
            message.content = contentList[1];

            Message.list.add(message);

            _streamController.add(Message.list);
          }
        }
        break;

      default:
        break;
    }


    setState(() {

    });
  }

  void update(Timer timer)
  {
    //_packetC2SEcho.send();
  }


  Widget _buildListTile (AsyncSnapshot snapshot, int index) {
    var id = snapshot.data[index].id;
    var title = snapshot.data[index].title;
    String content = snapshot.data[index].content;

    return ListTile(
      leading: Text("$id"),
      title: Text("$title"),
      subtitle: Text("$content",
        style: TextStyle(color: Colors.red),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("connected test")),
        body: Column(
          children: <Widget>[
            Center(
              child: RaisedButton(
                child: Text("Notification"),
                color: Colors.lightBlueAccent,
                textColor: Colors.white,
                onPressed: () {
                  //getTodo().then((todos) {
                  //streamController.add(todos);
                  //});
                },
              ),
            ),


            Flexible(
              child: StreamBuilder(
                stream: _streamController.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Text("wait data");
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => _buildListTile(snapshot, index),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }


}