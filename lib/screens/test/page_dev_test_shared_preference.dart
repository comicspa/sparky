
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_shared_preference.dart';
import 'package:fluttertoast/fluttertoast.dart';


class PageDevTestSharedPreference extends StatefulWidget {
  @override
  _PageDevTestSharedPreferenceState createState() => new _PageDevTestSharedPreferenceState();
}

class _PageDevTestSharedPreferenceState extends State<PageDevTestSharedPreference> {
  // TODO Add build() method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreference Test'),
      ),
      body: _buildSuggestions(context),
    );
  }

  @override
  void dispose() {
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
            title: Text('clear'),
            onTap: (){

              ManageSharedPreference.clear();

              Fluttertoast.showToast(
                  msg: "Clear All Shared Preference.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            },
          ),


        ], ).toList(), ); }

}