
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_firebase_auth.dart';


class PageDevTestAccount extends StatefulWidget {
  @override
  _PageDevTestAccountState createState() => new _PageDevTestAccountState();
}

class _PageDevTestAccountState extends State<PageDevTestAccount> {
  // TODO Add build() method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Test'),
      ),
      body: _buildSuggestions(context),
    );
  }


  Widget
  _buildSuggestions(BuildContext context)
  {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [

          ListTile(
            title: Text('Google SignIn'),
            onTap: (){

              ManageFirebaseAuth.signInWithGoogle();

            },
          ),
          ListTile(
            title: Text('Google SignOut'),
            onTap: (){

              ManageFirebaseAuth.signOutWithGoogle();

            },
          ),



          ListTile(
            title: Text('Sign up'),
            onTap: (){


            },
          ),
          ListTile(
            title: Text('Log in'),
            onTap: (){


            },
          ),

          ListTile(
            title: Text('Register Creator'),
            onTap: (){


            },
          ),

          ListTile(
            title: Text('Unregister Creator'),
            onTap: (){


            },
          ),


          ListTile(
            title: Text('Log out'),
            onTap: (){


            },
          ),

          ListTile(
            title: Text('Withdrawal'),
            onTap: (){


            },
          ),

        ], ).toList(), ); }

}