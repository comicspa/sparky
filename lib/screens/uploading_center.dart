import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sparky/manage/manage_file_picker.dart';
import 'package:sparky/manage/manage_firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

// Coming soon page for multi-purpose

class _UploadData {
  String creator = '';
  String password = '';
  String description = '';
}

class UploadingCenterScreen extends StatefulWidget {
  UploadingCenterScreen(this.titleText);

  final String titleText;

  @override
  _UploadingCenterScreenState createState() =>
      new _UploadingCenterScreenState(titleText);
}

class _UploadingCenterScreenState extends State<UploadingCenterScreen>
    with WidgetsBindingObserver {
  _UploadingCenterScreenState(this.titleText);

  String titleText;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _UploadData _data = new _UploadData();
  Map<String, String> _filePathsMap;

  // need validate packages to use below validations
  /*String _validateCreator(String value) {
    // If empty value, the isCreator function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isCreator(value);
    } catch (e) {
      return 'The Creator Name must be a valid.';
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }

    return null;
  }*/

  void submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print('Printing the uploading data.');
      print('Creator: ${_data.creator}');
      print('Password: ${_data.password}');
      print('Password: ${_data.description}');
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    print('titleText : $titleText');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(ManageDeviceInfo.resolutionHeight * 0.055),
        child: SafeArea(
          child: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 1,
            backgroundColor: Colors
                .white, //Color.fromRGBO(21, 24, 45, 1.0), //Color(0xff202a30), //Colors.black87, // Color(0xFF5986E1),
            title: Text(
              titleText,
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Form(
        key: this._formKey,
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(
                  ManageDeviceInfo.resolutionWidth * 0.05,
                  ManageDeviceInfo.resolutionWidth * 0.05,
                  ManageDeviceInfo.resolutionWidth * 0.05,
                  ManageDeviceInfo.resolutionWidth * 0.01),
              child: SizedBox(
                height: ManageDeviceInfo.resolutionHeight * 0.08,
                child: TextFormField(
                    keyboardType:
                        TextInputType.text, // Use text input type for text.
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Creator Name',
                        labelText: 'Creator Name'),
//                          validator: this._validateCreator,
                    onSaved: (String value) {
                      this._data.creator = value;
                    }),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  ManageDeviceInfo.resolutionWidth * 0.05,
                  ManageDeviceInfo.resolutionWidth * 0.01,
                  ManageDeviceInfo.resolutionWidth * 0.05,
                  ManageDeviceInfo.resolutionWidth * 0.01),
              child: SizedBox(
                height: ManageDeviceInfo.resolutionHeight * 0.08,
                child: TextFormField(
                    obscureText: true, // Use secure text for passwords.
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                        labelText: 'Enter your password'),
//                          validator: this._validatePassword,
                    onSaved: (String value) {
                      this._data.password = value;
                    }),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  ManageDeviceInfo.resolutionWidth * 0.05,
                  ManageDeviceInfo.resolutionWidth * 0.01,
                  ManageDeviceInfo.resolutionWidth * 0.05,
                  ManageDeviceInfo.resolutionWidth * 0.02),
              child: SizedBox(
                height: ManageDeviceInfo.resolutionHeight * 0.2,
                child: TextFormField(
                    maxLines: 10, // Use secure text for passwords.
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Description',
                        labelText: 'Enter description about this title'),
//                          validator: this._validatePassword,
                    onSaved: (String value) {
                      this._data.description = value;
                    }),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  ManageDeviceInfo.resolutionWidth * 0.25,
                  ManageDeviceInfo.resolutionWidth * 0.01,
                  ManageDeviceInfo.resolutionWidth * 0.25,
                  ManageDeviceInfo.resolutionWidth * 0.02),
              child: SizedBox(
                width: ManageDeviceInfo.resolutionWidth * 0.15,
                height: ManageDeviceInfo.resolutionHeight * 0.06,
                child: RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.black54),
                  ),
                  onPressed: this.submit,
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  ManageDeviceInfo.resolutionWidth * 0.25,
                  ManageDeviceInfo.resolutionWidth * 0.01,
                  ManageDeviceInfo.resolutionWidth * 0.25,
                  ManageDeviceInfo.resolutionWidth * 0.02),
              child: SizedBox(
                width: ManageDeviceInfo.resolutionWidth * 0.2,
                height: ManageDeviceInfo.resolutionHeight * 0.06,
                child: OutlineButton(
                  onPressed: chooseImage,
                  child: Text('Choose Image'),
                ),
              ),
            ),
            SizedBox(
              height: ManageDeviceInfo.resolutionHeight * 0.04,
            ),
            showImage(),
            SizedBox(
              height: ManageDeviceInfo.resolutionHeight * 0.04,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  ManageDeviceInfo.resolutionWidth * 0.25,
                  ManageDeviceInfo.resolutionWidth * 0.01,
                  ManageDeviceInfo.resolutionWidth * 0.25,
                  ManageDeviceInfo.resolutionWidth * 0.02),
              child: SizedBox(
                height: ManageDeviceInfo.resolutionHeight * 0.04,
                child: OutlineButton(
                  onPressed: startUpload,
                  child: Text('Upload Image'),
                ),
              ),
            ),
            SizedBox(
              height: ManageDeviceInfo.resolutionHeight * 0.04,
            ),
            Container(
              height: ManageDeviceInfo.resolutionHeight * 0.04,
              child: Text(
                status,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<File> file;
  String status = '';
  String base64Image;
  String errMessage = 'Error Uploading Image';
  File tmpFile;

  chooseImage() async {
    //_filePathsMap = await ManageFilePicker.getMultiFilePath();
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (null == imageFile) {
      print("null == imageFile");
      setStatus('');
    } else {
      String fileName = basename(imageFile.path);
      if (null == _filePathsMap)
        _filePathsMap = new Map<String, String>();
      else
        _filePathsMap.clear();

      _filePathsMap[fileName] = imageFile.path;

      setStatus('Image Selected ');
    }
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  Future<File> loadFile() async {
    String fileName = _filePathsMap.keys.toList()[0];
    print('loadFile : $fileName');
    return new File(_filePathsMap[fileName]);
  }

  startUpload() async {
    setStatus('Uploading Image...');
    if (null == _filePathsMap) {
      setStatus(errMessage);
      return;
    }

    ManageFirebaseStorage.uploadFiles('test', _filePathsMap).then((value) {
      //value == String
      print(value.toString());
      print('success');

      file = loadFile();
    }, onError: (error) {
      print('error : $error');
    }).catchError((error) {
      print('catchError : $error');
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          print('tmpFile path : ${tmpFile.path}');
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
}

/*class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();

  String _validateCreator(String value) {
    // If empty value, the isCreator function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isCreator(value);
    } catch (e) {
      return 'The Creator Name must be a valid.';
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }

    return null;
  }

  void submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print('Printing the login data.');
      print('Creator: ${_data.creator}');
      print('Password: ${_data.password}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                    keyboardType:
                        TextInputType.text, // Use text input type for text.
                    decoration: new InputDecoration(
                        hintText: 'you@example.com',
                        labelText: 'E-mail Address'),
                    validator: this._validateCreator,
                    onSaved: (String value) {
                      this._data.creator = value;
                    }),
                new TextFormField(
                    obscureText: true, // Use secure text for passwords.
                    decoration: new InputDecoration(
                        hintText: 'Password', labelText: 'Enter your password'),
                    validator: this._validatePassword,
                    onSaved: (String value) {
                      this._data.password = value;
                    }),
                new Container(
                  width: screenSize.width,
                  child: new RaisedButton(
                    child: new Text(
                      'Login',
                      style: new TextStyle(color: Colors.white),
                    ),
                    onPressed: this.submit,
                    color: Colors.blue,
                  ),
                  margin: new EdgeInsets.only(top: 20.0),
                )
              ],
            ),
          )),
    );
  }
}*/
