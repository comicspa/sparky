import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.
import 'package:auto_size_text/auto_size_text.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:sparky/models/model_text_detection.dart';
import 'package:sparky/models/model_view_comic.dart';

import 'common_widgets.dart';

class DrawRectAndImage extends StatefulWidget {
  DrawRectAndImage();

  @override
  _DrawRectAndImageState createState() => _DrawRectAndImageState();
}

class _DrawRectAndImageState extends State<DrawRectAndImage>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  int isImageLoaded = 0;
  int tappedCountIndex = -1;
  bool useCloud = true;
  //List<String> urlList = new List<String>();

  @override
  void dispose() {
    // Clean up the controller when the text widget is disposed.
    textController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    init();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
  }

  init() async {
    //urlList.add('01.jpg');
    //urlList.add('04.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              'Text Editor',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
          // Todo add loading indicator here
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: FutureBuilder<List<ModelTextDetection>>(
              future: ModelTextDetection.generate(
                  ModelViewComic.getInstance().imageUrlList, useCloud),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Container(
                    height: ManageDeviceInfo.resolutionHeight,
                    child: Center(
                      child: new CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 4.0,
                        animation: true,
                        animationDuration: 2700,
                        percent: 0.75,
                        footer: new Text(
                          "This Processing may take some time",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  ManageDeviceInfo.resolutionHeight * 0.02),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.redAccent,
                      ),
                    ),
                  );
                {
                  return Stack(children: <Widget>[
                    FittedBox(
                      child: SizedBox(
                        width: ModelTextDetection.sizeBoxWidth,
                        // ManageDeviceInfo.resolutionWidth * (ModelTextDetection.list[0].manageImage.width / ManageDeviceInfo.resolutionWidth),
                        height: ModelTextDetection.sizeBoxHeight,
                        //ManageDeviceInfo.resolutionHeight * (ModelTextDetection.imageTotalHeight / ManageDeviceInfo.resolutionHeight),
                        child: _buildImage(),
                      ),
                    ),
                    for (var boundingBoxInfo
                        in ModelTextDetection.boundingBoxInfoList)
                      Positioned(
                        left: boundingBoxInfo.left,
                        //ManageDeviceInfo.resolutionWidth / (ModelTextDetection.list[0].manageImage.width / boundingBoxInfo.boundingBox.left),
                        top: boundingBoxInfo.top,
                        //(boundingBoxInfo.boundingBox.top / (ModelTextDetection.list[0].manageImage.width / ManageDeviceInfo.resolutionWidth)) + (boundingBoxInfo.previousImageTotalHeight/(ModelTextDetection.list[0].manageImage.width / ManageDeviceInfo.resolutionWidth)),
                        child: GestureDetector(
                          onTap: () {
                            tappedCountIndex = boundingBoxInfo.countIndex;

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return buildTranslatePopUp(context);
                              },
                            );
                            debugPrint("hello");
                          },
                          child: Container(
                              alignment: Alignment.center,
                              width: boundingBoxInfo.width + 4,
                              //ManageDeviceInfo.resolutionWidth / (ModelTextDetection.list[0].manageImage.width / boundingBoxInfo.boundingBox.width),
                              height: boundingBoxInfo.height + 4,
                              //ManageDeviceInfo.resolutionHeight / (ModelTextDetection.imageTotalHeight / boundingBoxInfo.boundingBox.height) + ManageDeviceInfo.statusBarHeight,
                              decoration:
                                  textBoxDecoration(boundingBoxInfo.changed),
                              child: SizedBox(
                                width: boundingBoxInfo.width,
                                height: boundingBoxInfo.height,
                                child: AutoSizeText(
                                  /*textController.text*/
                                  boundingBoxInfo.text,
                                  style: TextStyle(
                                      fontSize:
                                          ManageDeviceInfo.resolutionHeight *
                                              0.03),
                                  textAlign: TextAlign.center,
                                  maxLines: boundingBoxInfo.textLineCount,
                                  minFontSize: 4,
                                ),
                              )),
                        ),
                      ),
                  ]);
                }
              })

        
          ),
    );
  }

  AlertDialog buildTranslatePopUp(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: SingleChildScrollView(  // need this to avoid bottom widget overflow issue when keyboard popup
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: ManageDeviceInfo.resolutionHeight * 0.38,
            width: ManageDeviceInfo.resolutionWidth * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  height: ManageDeviceInfo.resolutionHeight * 0.3,
                  child: TextFormField(
                    controller: textController,
                    textInputAction: TextInputAction.newline,
                    autofocus: true,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                        hintText: 'You may start typing',
                        contentPadding: EdgeInsets.all(
                            ManageDeviceInfo.resolutionHeight * 0.009)

                        //                              border: OutlineInputBorder(),
                        //                              focusedBorder: OutlineInputBorder(
                        //                                borderSide: BorderSide(
                        //                                  color: Colors.greenAccent,
                        //                                ),
                        //                              ),
                        //                              enabledBorder: OutlineInputBorder(
                        //                                borderSide: BorderSide(
                        //                                  color: Colors.redAccent,
                        //                                ),
                        //                              ),
                        //                              contentPadding: EdgeInsets.all(
                        //                                  ManageDeviceInfo.resolutionWidth * 0.02),
                        ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: ManageDeviceInfo.resolutionHeight * 0.02),
                      child: SizedBox(
                        height: ManageDeviceInfo.resolutionHeight * 0.035,
                        child: RaisedButton(
                          shape: StadiumBorder(),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ManageDeviceInfo.resolutionWidth * 0.05,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: ManageDeviceInfo.resolutionHeight * 0.02),
                      child: SizedBox(
                        height: ManageDeviceInfo.resolutionHeight * 0.035,
                        child: RaisedButton(
                          shape: StadiumBorder(),
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState.validate()) {
                              ModelTextDetection.boundingBoxInfoList[tappedCountIndex].text = textController.text;
                              ModelTextDetection.boundingBoxInfoList[tappedCountIndex].changed = true;
                              textController.text = '';
                              setState(() {});

                              // Process data.
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ),
                    ),
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration textBoxDecoration(bool changed) {
    return BoxDecoration(
      color: changed
          ? Colors.white.withOpacity(1.0)
          : Colors.amberAccent.withOpacity(0.1),
      border: Border.all(
          color: changed ? Colors.white.withOpacity(1.0) : Colors.blueAccent,
          width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );
  }

  Widget _buildImage() {
    return new CustomPaint(
      painter: new PaintingImage(),
    );
  }

   Widget _simplePopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text('Kor'),
          ),
          PopupMenuItem(
            value: 2,
            child: Text('Eng'),
          ),
          
        ],
      );

}

class PaintingImage extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (null != ModelTextDetection.list) {
      for (int countIndex = 0;
          countIndex < ModelTextDetection.list.length;
          ++countIndex) {
        //print('PaintingImage[$countIndex/${ModelTextDetection.list.length}] : ${ModelTextDetection.list[countIndex].image.height}');

        canvas.drawImage(
            ModelTextDetection.list[countIndex].image,
            new Offset(
                0.0,
                ModelTextDetection.list[countIndex].previousImageTotalHeight
                    .toDouble()),
            new Paint());
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
