
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_shared_preference.dart';
import 'package:sparky/manage/manage_toast_message.dart';


class PageExperimentSharedPreference extends StatefulWidget {
  @override
  _PageExperimentSharedPreferenceState createState() => new _PageExperimentSharedPreferenceState();
}

class _PageExperimentSharedPreferenceState extends State<PageExperimentSharedPreference> {
  // TODO Add build() method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreference Experiment'),
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
            title: Text('Go to Next Page !!'),
            onTap: (){

              Navigator.of(context).pushReplacementNamed('/PageExperimentApply');

            },
          ),


          ListTile(
            title: Text('clear'),
            onTap: (){

              ManageSharedPreference.clear();
              ManageToastMessage.showShort('Clear All Shared Preference.');
            },
          ),


          ListTile(
            title: Text('set'),
            onTap: (){

              ManageSharedPreference.setString('test', 'test11');
              ManageToastMessage.showShort('set string  Shared Preference.');
            },
          ),

          ListTile(
            title: Text('get'),
            onTap: (){

              ManageSharedPreference.getString('test').then((value)
              {
                if(null != value)
                {
                  print(value.toString());
                  print('success');

                  ManageToastMessage.showShort('get string  Shared Preference. : ${value.toString()}');
                }
                else
                {
                  ManageToastMessage.showShort('get string  Shared Preference. : null');
                }

              },
                  onError: (error)
                  {
                    print('error : $error');
                  }).catchError( (error)
              {
                print('catchError : $error');
              });

            },
          ),


          ListTile(
            title: Text('remove'),
            onTap: (){

              ManageSharedPreference.remove('test');
              ManageToastMessage.showShort('remove string  Shared Preference.');
            },
          ),


        ], ).toList(), ); }

}