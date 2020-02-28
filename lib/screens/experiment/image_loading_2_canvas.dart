import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.

import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:typed_data';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/manage/manage_flutter_cache_manager.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:sparky/manage/manage_firebase_ml_vision.dart';

class ImageLoading2Canvas extends StatefulWidget {
  ImageLoading2Canvas({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ImageLoading2CanvasState createState() => new _ImageLoading2CanvasState();
}

class _ImageLoading2CanvasState extends State<ImageLoading2Canvas> {
  ui.Image image;
  bool isImageLoaded = false;
  List<TextBlock> textBlockList;
//  var imageData = await rootBundle.load('images/Comi01.jpg');

  void initState() {
    super.initState();
    init();
  }

  init() async {
//    final ByteData data = await rootBundle.load('http://221.165.42.119/ComicSpa/creator/100000/1000001/04.jpg');
    // final ByteData data = await rootBundle.load('images/04.jpg');

    File file = await ManageFlutterCacheManager.getSingleFile(
        'http://221.165.42.119/ComicSpa/creator/100000/1000001/04.jpg');
    if (!file.existsSync()) {
      print('!file.existsSync()');
    }

    VisionText visionText =
    await ManageFirebaseMLVision.detectTextFromFile(file,true);

    textBlockList = new List<TextBlock>();

    if (null != visionText.blocks) {
      for (int i = 0; i < visionText.blocks.length; ++i) {
        TextBlock textBlock = visionText.blocks[i];

        textBlockList.add(textBlock);

        /*
        if (null != textBlock.recognizedLanguages)
        {
          for (int m = 0; m < textBlock.recognizedLanguages.length; ++m)
          {
            print('recognizedLanguages[$m] : ${textBlock.recognizedLanguages.elementAt(m).toString()}');
          }
        }
        */

        //print('text[$i] : ${textBlock.text}');
        // print('boundingBox[$i] : ${textBlock.boundingBox.toString()}');
        //print('cornerPoints[$i] : ${textBlock.cornerPoints.toString()}');

        if (null != textBlock.lines) {
          for (int j = 0; j < textBlock.lines.length; ++j) {
            // print('linetext[$i][$j] : ${textBlock.lines[j].text}');
          }
        }
      }
    }

    //ByteBuffer data = await ModelCommon.getByteBufferFromFile(file);
    Uint8List list = await ModelCommon.getUint8ListFromFile(file);
    print('aaaaaa : ${list.length}');

    image = await loadImage(list);
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        print('fffffffffffff');
        isImageLoaded = true;
      });
      return completer.complete(img);
    });
    return completer.future;
  }

  Widget _buildImage() {
    if (this.isImageLoaded) {
      return new CustomPaint(
        painter: new PaintingImage(image: image),
      );
    } else {
      return new Center(child: new Text('loading'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView(
        children: <Widget>[
          FittedBox(
            child: SizedBox(
              width: image.width.toDouble(),
              height: image.height.toDouble(),
              child: _buildImage(),
            ),
          ),
        ],
      ),
    );
  }
}

class PaintingImage extends CustomPainter {
  PaintingImage({
    this.image,
  });

  ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    print('sdjifoeifye : ${image.height}');

    //ByteData data = await image.toByteData();

    canvas.drawImage(image, new Offset(0.0, 0.0), new Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
