import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.
import 'package:auto_size_text/auto_size_text.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:sparky/models/model_text_detection.dart';
import 'package:sparky/models/model_view_comic.dart';

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
      body: SingleChildScrollView(
          // Todo add loading indicator here
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: FutureBuilder<List<ModelTextDetection>>(
              future: ModelTextDetection.generate(
                  ModelViewComic.list[0].imageUrlList, useCloud),
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
                              width: boundingBoxInfo.width,
                              //ManageDeviceInfo.resolutionWidth / (ModelTextDetection.list[0].manageImage.width / boundingBoxInfo.boundingBox.width),
                              height: boundingBoxInfo.height,
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

          /* child: Stack(
          children: <Widget>[
            Container(
              child: FutureBuilder<List<ModelTextDetection>>(
                  future:  ModelTextDetection.generate(urlList,useCloud),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return FittedBox(
                        child: SizedBox(
                          width: null != ModelTextDetection.list
                              ? ManageDeviceInfo.resolutionWidth *
                              //(manageImage1.width / ManageDeviceInfo.resolutionWidth),
                              (ModelTextDetection.list[0].manageImage.width /
                                  ManageDeviceInfo.resolutionWidth)
                              : ManageDeviceInfo.resolutionWidth,
                          height: ManageDeviceInfo.resolutionHeight *
                              //(totalImageHeight / ManageDeviceInfo.resolutionHeight),
                              (ModelTextDetection.imageTotalHeight /
                                  ManageDeviceInfo.resolutionHeight),
                          child: _buildImage(),
                        ),
                      );
                    {
                      return FittedBox(
                        child: SizedBox(
                          width: null != ModelTextDetection.list
                              ? ManageDeviceInfo.resolutionWidth *
                              //(manageImage1.width / ManageDeviceInfo.resolutionWidth),
                              (ModelTextDetection.list[0].manageImage.width /
                                  ManageDeviceInfo.resolutionWidth)
                              : ManageDeviceInfo.resolutionWidth,
                          height: ManageDeviceInfo.resolutionHeight *
                              //(totalImageHeight / ManageDeviceInfo.resolutionHeight),
                              (ModelTextDetection.imageTotalHeight /
                                  ManageDeviceInfo.resolutionHeight),
                          child: _buildImage(),
                        ),
                      );
                    }
                  }
              ),
            ),
//            FittedBox(
//              child: SizedBox(
//                width: null != ModelTextDetection.list? ManageDeviceInfo.resolutionWidth *
//                    //(manageImage1.width / ManageDeviceInfo.resolutionWidth),
//                    (ModelTextDetection.list[0].manageImage.width/ ManageDeviceInfo.resolutionWidth) : ManageDeviceInfo.resolutionWidth,
//                height: ManageDeviceInfo.resolutionHeight *
//                    //(totalImageHeight / ManageDeviceInfo.resolutionHeight),
//                    (ModelTextDetection.imageTotalHeight / ManageDeviceInfo.resolutionHeight),
//                child: _buildImage(),
//
//              ),
//            ),
            //for(var boundingBoxInfo in boundingBoxInfoList)
            if(true == ModelTextDetection.finished)
              for(var boundingBoxInfo in ModelTextDetection.boundingBoxInfoList)
                Positioned(
                  left: ManageDeviceInfo.resolutionWidth /
                      //(manageImage1.width / boundingBoxInfo.boundingBox.left),
                      (ModelTextDetection.list[0].manageImage.width / boundingBoxInfo.boundingBox.left),
                  top: boundingBoxInfo.boundingBox.top /
                      //(manageImage1.width / ManageDeviceInfo.resolutionWidth),
                      (ModelTextDetection.list[0].manageImage.width / ManageDeviceInfo.resolutionWidth),
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
                        width: ManageDeviceInfo.resolutionWidth /
                            //(manageImage1.width / boundingBoxInfo.boundingBox.width),
                            (ModelTextDetection.list[0].manageImage.width / boundingBoxInfo.boundingBox.width),
                        height: ManageDeviceInfo.resolutionHeight /
                            //(totalImageHeight / boundingBoxInfo.boundingBox.height) +
                            (ModelTextDetection.imageTotalHeight / boundingBoxInfo.boundingBox.height) +
                            ManageDeviceInfo.statusBarHeight,
                        decoration: textBoxDecoration(boundingBoxInfo.changed),
                        child: Text(
                          /*textController.text*/boundingBoxInfo.text)
                    ),
                  ),
                ),
          ],
        ), */
          ),
    );
  }

  AlertDialog buildTranslatePopUp(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Form(
        key: _formKey,
        child: SizedBox(
          height: ManageDeviceInfo.resolutionHeight * 0.38,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                height: ManageDeviceInfo.resolutionHeight * 0.2,
                child: TextFormField(
                  controller: textController,
                  textInputAction: TextInputAction.send,
                  autofocus: true,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                      hintText: 'You may start typing',
                      contentPadding: EdgeInsets.all(
                          ManageDeviceInfo.resolutionHeight * 0.01)

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
                    padding: const EdgeInsets.symmetric(vertical: 15),
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
                    width: ManageDeviceInfo.resolutionWidth * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: SizedBox(
                      height: ManageDeviceInfo.resolutionHeight * 0.035,
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState.validate()) {
                            ModelTextDetection
                                .boundingBoxInfoList[tappedCountIndex]
                                .text = textController.text;
                            ModelTextDetection
                                .boundingBoxInfoList[tappedCountIndex]
                                .changed = true;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(
                        ManageDeviceInfo.resolutionHeight * 0.02),
                    child: SizedBox(
                      height: ManageDeviceInfo.resolutionHeight * 0.035,
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState.validate()) {
                            // Process data.
                          }
                        },
                        child: Text('Language'),
                      ),
                    ),
                  ),
                ],
              )
            ],
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
