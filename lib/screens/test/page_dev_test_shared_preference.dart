
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
            title: Text('Go to Next Page !!'),
            onTap: (){

              Navigator.of(context).pushReplacementNamed('/PageDevTestApply');

            },
          ),


          ListTile(
            title: Text('clear'),
            onTap: (){

              ManageSharedPreference.clear();

              Fluttertoast.showToast(
                  msg: "Clear All Shared Preference.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            },
          ),


          ListTile(
            title: Text('set'),
            onTap: (){

              ManageSharedPreference.setString('test', 'test11');

              Fluttertoast.showToast(
                  msg: "set string  Shared Preference.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            },
          ),

          ListTile(
            title: Text('get'),
            onTap: (){

               ManageSharedPreference.getString('test').then((value)
               {
                 if(null != value) {
                   print(value.toString());
                   print('success');

                   Fluttertoast.showToast(
                       msg: 'get string  Shared Preference. : ${value.toString()}',
                       toastLength: Toast.LENGTH_SHORT,
                       gravity: ToastGravity.BOTTOM,
                       timeInSecForIos: 1,
                       backgroundColor: Colors.red,
                       textColor: Colors.white,
                       fontSize: 16.0
                   );
                 }
                 else
                   {
                     Fluttertoast.showToast(
                         msg: 'get string  Shared Preference. : null',
                         toastLength: Toast.LENGTH_SHORT,
                         gravity: ToastGravity.BOTTOM,
                         timeInSecForIos: 1,
                         backgroundColor: Colors.red,
                         textColor: Colors.white,
                         fontSize: 16.0
                     );
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

              Fluttertoast.showToast(
                  msg: "remove string  Shared Preference.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            },
          ),


        ], ).toList(), ); }

}