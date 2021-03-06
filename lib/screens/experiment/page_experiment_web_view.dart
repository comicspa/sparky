
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:sparky/manage/manage_toast_message.dart';


class PageExperimentWebview extends StatefulWidget {
  @override
  _PageExperimentWebviewState createState() => new _PageExperimentWebviewState();
}

class _PageExperimentWebviewState extends State<PageExperimentWebview> {
  // TODO Add build() method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webview Experiment'),
      ),

      //body: _buildSuggestions(context),
      body: WebView(
        initialUrl: 'https://www.google.co.kr',
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String url) {

          print('finished:' + url);
          ManageToastMessage.showShort('finished:'+url);
        },
      ),
    );
  }

  @override
  void dispose() {
    ManageToastMessage.cancel();
    super.dispose();
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
            title: Text('webview1'),
            onTap: (){


            },
          ),



        ], ).toList(), ); }

}