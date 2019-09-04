import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sparky/screens/more.dart';
import 'package:flutter/foundation.dart';

Future<List<Creators>> fetchHotCreators(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/photos');

  // Use the compute function to run parseCreators in a separate isolate
  return compute(parseHotCreators, response.body);
  //  return response.body;
}

// A function that will convert a response body into a List<Creators>
List<Creators> parseHotCreators(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Creators>((json) => Creators.fromJson(json)).toList();
}

class Creators {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Creators({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Creators.fromJson(Map<String, dynamic> json) {
    return Creators(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

class FutureBuildHotCreators extends StatefulWidget {
  FutureBuildHotCreators({
    Key key,
  }) : super(key: key);

  @override
  _FutureBuildHotCreatorsState createState() => _FutureBuildHotCreatorsState();
}

class _FutureBuildHotCreatorsState extends State<FutureBuildHotCreators> with WidgetsBindingObserver{
  /*
  @override
  void initState() async {
    List<Creators> myFuture = await fetchHotCreators(http.Client());
    super.initState();
  }
  */

//  List data;
//
//  void getList() async {
//    this.data = (await fetchHotCreators(http.Client()));
//  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)
  {
    print('state = $state');
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child:
//      data == null
//          ? Container(
//              child: Card(
//              child: Text("data"),
//            )):
          FutureBuilder<List<Creators>>(
        future: fetchHotCreators(http.Client()),
        builder: (BuildContext context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('');
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            //
            case ConnectionState.done:
              //default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return BuildHotCreatorCards(hotCreators: snapshot.data);
          }

          return Text('Result: ${snapshot.data}');
        },

//          if (snapshot.hasError) print(snapshot.error);
//
//          return snapshot.hasData
//              ? BuildHotCreatorCards(hotCreators: snapshot.data)
//              : Center(child: CircularProgressIndicator());
//        },
      ),
    );
  }
}

class BuildHotCreatorCards extends StatefulWidget {
  final List<Creators> hotCreators;

  BuildHotCreatorCards({Key key, this.hotCreators}) : super(key: key);

  @override
  _BuildHotCreatorCardsState createState() => _BuildHotCreatorCardsState();
}

class _BuildHotCreatorCardsState extends State<BuildHotCreatorCards> {
//  int present = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
//      itemCount: (present <= widget.hotCreators.length)
//          ? widget.hotCreators.length + 1
//          : widget.hotCreators.length,
      itemCount: widget.hotCreators.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Container(
//                  Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MoreScreen())); //Todo testing route so update this later
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Image.network(
                            widget.hotCreators[index].thumbnailUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        //                            AspectRatio(
                        //                              aspectRatio: 1.0,
                        //                              child: Container(
                        //                                decoration: const BoxDecoration(
                        ////                                image: DecorationImage(
                        ////                                    image: NetworkImage(
                        ////                                        snapshot.data[index].picture)
                        ////                                ),
                        //                                    color: Colors.pink),
                        //                              ),
                        //                            ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.hotCreators[index].title,
                                        //Todo update this testing data
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 2.0)),
                                      Text(
                                        widget.hotCreators[index].title,
                                        //Todo update this testing data
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        widget.hotCreators[index].title,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        'Date published · views ★', //Todo update this testing data
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
