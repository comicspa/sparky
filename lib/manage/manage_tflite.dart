
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
//import 'package:tflite_native/tflite.dart' as tfl;
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;


class ManageTFLite
{

  static const String balloonWithText = "balloonWithText";
  static const String mobile = "MobileNet";
  static const String ssd = "SSD MobileNet";
  static const String yolo = "Tiny YOLOv2";
  static const String deeplab = "DeepLab";
  static const String posenet = "PoseNet";

  static File _image;
  static List _recognitions;
  static String _model = yolo;//balloonWithText;//
  static double _imageHeight;
  static double _imageWidth;
  static bool _busy = false;


  static void readModel(File file) async
  {
    Tflite.close();

    String res;

    /*
    res = await Tflite.loadModel(
        model: 'data/tflite/model.tflite',
        labels: 'data/tflite/dict.txt',
        numThreads: 1 // defaults to 1
    );

     */


      try {

        switch (_model) {
          case balloonWithText:
            res = await Tflite.loadModel(
                model: 'data/tflite/model.tflite',
                labels: 'data/tflite/dict.txt',
            );
            break;

          case yolo:
            res = await Tflite.loadModel(
              model: "data/tflite/yolov2_tiny.tflite",
              labels: "data/tflite/yolov2_tiny.txt",
            );
            break;
          case ssd:
            res = await Tflite.loadModel(
                model: "data/tflite/ssd_mobilenet.tflite",
                labels: "data/tflite/ssd_mobilenet.txt");
            break;
          case deeplab:
            res = await Tflite.loadModel(
                model: "data/tflite/deeplabv3_257_mv_gpu.tflite",
                labels: "data/tflite/deeplabv3_257_mv_gpu.txt");
            break;
          case posenet:
            res = await Tflite.loadModel(
                model: "data/tflite/posenet_mv1_075_float_from_checkpoints.tflite");
            break;
          default:
            res = await Tflite.loadModel(
              model: "data/tflite/mobilenet_v1_1.0_224.tflite",
              labels: "data/tflite/mobilenet_v1_1.0_224.txt",
            );
        }
        print(res);
      } on PlatformException {
        print('Failed to load model.');
      }



    print('readModel - $res');

    /*
    var recognitions = await Tflite.detectObjectOnImage(
        path: filePath,       // required
        model: "",
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.4,       // defaults to 0.1
        numResultsPerClass: 2,// defaults to 5
        asynch: true          // defaults to true
    );

     */


    await predictImage(file);



    //Tflite.close();


  }


  static Future<void> readbyImagePicker() async
  {

      File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (null == imageFile)
      {
        print("null == imageFile");
        return;

      }

      await readModel(imageFile);


  }


  static Future predictImage(File image) async
  {
    if (image == null) return;

    switch (_model) {
      case balloonWithText:
        await balloonWithTextt(image);
        break;

      case yolo:
        await yolov2Tiny(image);
        break;
      case ssd:
        await ssdMobileNet(image);
        break;
      case deeplab:
        await segmentMobileNet(image);
        break;
      case posenet:
        await poseNet(image);
        break;
      default:
        //await recognizeImage(image);
     await recognizeImageBinary(image);
    }

    /*
    new FileImage(image)
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {

    }));
    */



  }


  static Uint8List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  static Uint8List imageToByteListUint8(img.Image image, int inputSize) {
    var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
    var buffer = Uint8List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = img.getRed(pixel);
        buffer[pixelIndex++] = img.getGreen(pixel);
        buffer[pixelIndex++] = img.getBlue(pixel);
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  static Future recognizeImage(File image) async {

    print('recognizeImage');

    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    print('recognizeImage : ${recognitions.toString()}');
  }


  static Future recognizeImageBinary(File image) async
  {
    print('recognizeImageBinary');

    var imageBytes = (await rootBundle.load(image.path)).buffer;
    img.Image oriImage = img.decodeJpg(imageBytes.asUint8List());
    //img.Image resizedImage = img.copyResize(oriImage, {224, 224,Interpolation:img.Interpolation.nearest});
    var recognitions = await Tflite.runModelOnBinary(
      binary: imageToByteListFloat32(oriImage, 224, 127.5, 127.5),
      numResults: 6,
      threshold: 0.05,
    );

    print('recognizeImageBinary : ${recognitions.toString()}');
  }


  static Future balloonWithTextt(File image) async {

    print('balloonWithText');


    var recognitions = await Tflite.detectObjectOnImage(
      path: image.path,
      model: "YOLO",
      threshold: 0.3,
      imageMean: 0.0,
      imageStd: 255.0,
      numResultsPerClass: 1,
    );
    // var imageBytes = (await rootBundle.load(image.path)).buffer;
    // img.Image oriImage = img.decodeJpg(imageBytes.asUint8List());
    // img.Image resizedImage = img.copyResize(oriImage, 416, 416);
    // var recognitions = await Tflite.detectObjectOnBinary(
    //   binary: imageToByteListFloat32(resizedImage, 416, 0.0, 255.0),
    //   model: "YOLO",
    //   threshold: 0.3,
    //   numResultsPerClass: 1,
    // );
    print('balloonWithText : ${recognitions.toString()}');
  }


  static Future yolov2Tiny(File image) async {

    print('yolov2Tiny');


    var recognitions = await Tflite.detectObjectOnImage(
      path: image.path,
      model: "YOLO",
      threshold: 0.3,
      imageMean: 0.0,
      imageStd: 255.0,
      numResultsPerClass: 1,
    );
    // var imageBytes = (await rootBundle.load(image.path)).buffer;
    // img.Image oriImage = img.decodeJpg(imageBytes.asUint8List());
    // img.Image resizedImage = img.copyResize(oriImage, 416, 416);
    // var recognitions = await Tflite.detectObjectOnBinary(
    //   binary: imageToByteListFloat32(resizedImage, 416, 0.0, 255.0),
    //   model: "YOLO",
    //   threshold: 0.3,
    //   numResultsPerClass: 1,
    // );
    print('yolov2Tiny : ${recognitions.toString()}');
  }

  static Future ssdMobileNet(File image) async {

    print('ssdMobileNet');

    var recognitions = await Tflite.detectObjectOnImage(
      path: image.path,
      numResultsPerClass: 1,
    );
    // var imageBytes = (await rootBundle.load(image.path)).buffer;
    // img.Image oriImage = img.decodeJpg(imageBytes.asUint8List());
    // img.Image resizedImage = img.copyResize(oriImage, 300, 300);
    // var recognitions = await Tflite.detectObjectOnBinary(
    //   binary: imageToByteListUint8(resizedImage, 300),
    //   numResultsPerClass: 1,
    // );
    print('ssdMobileNet : ${recognitions.toString()}');
  }

  static Future segmentMobileNet(File image) async
  {
    print('segmentMobileNet');

    var recognitions = await Tflite.runSegmentationOnImage(
      path: image.path,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    print('segmentMobileNet : ${recognitions.toString()}');
  }

  static Future poseNet(File image) async
  {
    print('poseNet');

    var recognitions = await Tflite.runPoseNetOnImage(
      path: image.path,
      numResults: 2,
    );

    print('poseNet : ${recognitions.toString()}');


  }



}