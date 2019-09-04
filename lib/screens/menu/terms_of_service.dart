import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sparky/manage/manage_service_center_info.dart';
import 'package:sparky/models/model_preset.dart';




// Coming soon page for multi-purpose

class TermsOfServiceWebview extends StatefulWidget {
  TermsOfServiceWebview(this.titleText);
  final String titleText;


  @override
  _TermsOfServiceWebviewState createState() => new _TermsOfServiceWebviewState(titleText);
}

class _TermsOfServiceWebviewState extends State<TermsOfServiceWebview> {
  _TermsOfServiceWebviewState(this.titleText);
  String titleText;

  @override
  void initState()
  {
    super.initState();

    print('titleText : $titleText');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
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
//      body:
//      WebView(
//        initialUrl: ModelPreset.termsOfUseUrl,
//        javascriptMode: JavascriptMode.unrestricted,
//        onPageFinished: (String url){
//          print('Finished:' + url);
//        },
//      )
    );
  }
}
