import "package:flutter/material.dart";
import 'package:sparky/manage/manage_device_info.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'main.dart'; //for currentuser & google signin instance
// import 'models/user.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  changeProfilePhoto(BuildContext parentContext) {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Photo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Changing your profile photo has not been implemented yet'),
              ],
            ),
          ),
        );
      },
    );
  }

 /*  applyChanges() {
    Firestore.instance
        .collection('insta_users')
        .document(currentUserModel.id)
        .updateData({
      "displayName": nameController.text,
      "bio": bioController.text,
    });
  } */

  Widget buildTextField({String name, TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            name,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: name,
          ),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(ManageDeviceInfo.resolutionHeight * 0.055),
        child: SafeArea(
          child: AppBar(
            elevation: 1,
            iconTheme: IconThemeData(
              color: Colors.black, 
            ),
            backgroundColor: Colors.white, //Color.fromRGBO(21, 24, 45, 1.0),
            //Color(0xff202a30), //Colors.black87, // Color(0xFF5986E1),
            centerTitle: true,

            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: SizedBox(
                width: ManageDeviceInfo.resolutionWidth * 0.7,
                /* child: ModelUserInfo.getInstance().photoUrl == null
                    ? Text(
                        'Loading...',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          fontSize: ManageDeviceInfo.resolutionHeight * 0.025,
                          color: Colors.black87,
                        ),
                      )
                    : */ 
                  child: Text(
                        'Profile',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          fontSize: ManageDeviceInfo.resolutionHeight * 0.025,
                          color: Colors.black87,
                        ),
                      ),
              ),
            ),
            /*SvgPicture.asset(
              'images/sparky_logo.svg',
              width: ManageDeviceInfo.resolutionWidth * 0.045,
              height: ManageDeviceInfo.resolutionHeight * 0.025,
            
            ),*/
          ),
        ),
      ), 
    body: ListView(
        padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/야옹이.png'),
                  radius: 50.0,
                ),
              ),
              FlatButton(
                  onPressed: () {
                    changeProfilePhoto(context);
                  },
                  child: Text(
                    "Change Photo",
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    buildTextField(name: "Name", controller: nameController),
                    buildTextField(name: "Bio", controller: bioController),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MaterialButton(
                    onPressed: () => { /*_logout(context)*/ },
                    child: Text("Logout")

                )
              )
            ],
          )
        ],
      ),
    );
    }

  
}/* FutureBuilder(
        future: Firestore.instance
            .collection('insta_users')
            .document(currentUserModel.id)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator());

          User user = User.fromDocument(snapshot.data);

          nameController.text = user.displayName;
          bioController.text = user.bio;

          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(currentUserModel.photoUrl),
                  radius: 50.0,
                ),
              ),
              FlatButton(
                  onPressed: () {
                    changeProfilePhoto(context);
                  },
                  child: Text(
                    "Change Photo",
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    buildTextField(name: "Name", controller: nameController),
                    buildTextField(name: "Bio", controller: bioController),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MaterialButton(
                    onPressed: () => {_logout(context)},
                    child: Text("Logout")

                )
              )
            ],
          );
        });
  }

  void _logout(BuildContext context) async {
    print("logout");
    await auth.signOut();
    await googleSignIn.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    currentUserModel = null;

    Navigator.pop(context);
  }
}


class User {
  final String email;
  final String id;
  final String photoUrl;
  final String username;
  final String displayName;
  final String bio;
  final Map followers;
  final Map following;

  const User(
      {this.username,
      this.id,
      this.photoUrl,
      this.email,
      this.displayName,
      this.bio,
      this.followers,
      this.following});

  factory User.fromDocument(DocumentSnapshot document) {
    return User(
      email: document['email'],
      username: document['username'],
      photoUrl: document['photoUrl'],
      id: document.documentID,
      displayName: document['displayName'],
      bio: document['bio'],
      followers: document['followers'],
      following: document['following'],
    );
  }
} */