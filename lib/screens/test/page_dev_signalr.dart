
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:signalr_client/signalr_client.dart';

typedef HubConnectionProvider = Future<HubConnection> Function();

class ChatMessage
{

  final String senderName;
  final String message;

  int id = 0;
  String title = 'title';
  String content = 'content';
  bool completed = false;

  // Methods
  ChatMessage(this.senderName, this.message);

  static List<ChatMessage> list;
}


class PageDevSignalR extends StatefulWidget
{
  @override
  _PageDevSignalRState createState() => _PageDevSignalRState();
}


class _PageDevSignalRState extends State<PageDevSignalR>
{

  String serverUrl = 'http://localhost:5000';
  HubConnection hubConnection;
  bool connectionIsOpen;

  String userName = 'app';
  String chatMessage = 'testMessage';


  StreamController<List<ChatMessage>> streamController = StreamController();
  Timer __timer;


  Future<void> openChatConnection() async
  {
    if (hubConnection == null) {
      hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
      hubConnection.onclose((error) => connectionIsOpen = false);
      hubConnection.on("OnMessage", _handleIncommingChatMessage);
    }

    if (hubConnection.state != HubConnectionState.Connected) {
      await hubConnection.start();
      connectionIsOpen = true;
    }
  }

  Future<void> sendChatMessage(String chatMessage) async {
    if( chatMessage == null ||chatMessage.length == 0){
      return;
    }
    await openChatConnection();
    hubConnection.invoke("Send", args: <Object>[userName, chatMessage] );
  }

  void _handleIncommingChatMessage(List<Object> args)
  {
    final String senderName = args[0];
    final String message = args[1];

    if(null == ChatMessage.list)
      ChatMessage.list = new List<ChatMessage>();
    ChatMessage.list.add( ChatMessage(senderName, message));
  }


  @override
  void initState()
  {
    super.initState();


    openChatConnection();

    const duration = const Duration(seconds:5);
    if(null == __timer)
      __timer = new Timer.periodic(duration, update);
  }

  void update(Timer timer)
  {
    /*
    getTodo().then((todos) {
      streamController.add(todos); // 스트림 컨트롤러에 데이터가 추가된다.
    });

     */

    if (hubConnection.state == HubConnectionState.Connected)
      sendChatMessage(DateTime.now().toString());

  }


  Future<List<ChatMessage>> getTodo() async
  {

    return null;
  }


  /*
  Future<List<ChatMessage>> getTodo() async {
    String url = "https://jsonplaceholder.typicode.com/todos"; // http request를 보낼 url
    http.Client _client = http.Client(); // http 클라이언트 사용
    List<ChatMessage> list = [];

    await _client.get(url) // http 리퀘스트를 보낸다.
        .then((res) => res.body) // http 응답을 받으면, 그 중에서 body만 가져옴
        .then(json.decode) // json을 형태로 파싱하고
        .then((todos) =>
        todos.forEach((todo) => list.add(ChatMessage.fromJson(todo))) // json을 클래스 형태로 바꿔서 리스트에 더해준다.
    );

    //list.removeRange(1, list.length-1);

    if(null == ChatMessage.list)
      ChatMessage.list = new List<ChatMessage>();

    DateTime now = DateTime.now();


    List<String> contens = [
      'test1',
      'test2',
      'test3',
      'test4',
      'test5',
      'test6'
    ];


    Random(now.millisecondsSinceEpoch);

    list[0].id = ChatMessage.list.length + 1;
    list[0].content = contens[new Random().nextInt(4)];
    list[0].title = now.toString();

    ChatMessage.list.add(list[0]);

    return ChatMessage.list;
  }
  */




  Widget _buildListTile (AsyncSnapshot snapshot, int index) {
    // 리스트 뷰에 들어갈 타일(작은 리스트뷰)를 만든다.
    var id = snapshot.data[index].id;
    var title = snapshot.data[index].title;
    bool completed = snapshot.data[index].completed;
    String content = snapshot.data[index].content;

    return ListTile(
      leading: Text("$id"),
      title: Text("$title"),
      subtitle: Text("$content",
        style: TextStyle(color: completed ? Colors.lightBlue : Colors.red),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("SignalR Test")),
        body: Column(
          children: <Widget>[
            Center(
              child: RaisedButton(
                child: Text("알림"),
                color: Colors.lightBlueAccent,
                textColor: Colors.white,
                onPressed: () { // 버튼을 누르면 서버에서 데이터를 가져옴
                  //getTodo().then((todos) {
                  //streamController.add(todos); // 스트림 컨트롤러에 데이터가 추가된다.
                  //});
                },
              ),
            ),


            Flexible(
              child: StreamBuilder(
                stream: streamController.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) { // 스냅샷에 데이터가 없으면 그냥 텍스트를 그린다.
                    return Text("wait data");
                  } else { // 스냅샷에 데이터가 있으면, 즉 스트림에 데이터가 추가되면 리스트뷰를 그린다.
                    return ListView.builder(
                      itemCount: snapshot.data.length, // 스냅샷의 데이터 크기만큼 뷰 크기를 정한다.
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

