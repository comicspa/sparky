import 'dart:io';
import 'dart:typed_data';


class ModelCommon
{
  static final String _testServiceServerBaseURL = 'http://221.165.42.119:9000';
  static final String _testStorageServerBaseURL = 'http://221.165.42.119/ComicSpa';
  static final String _fireBaseStorageServerBaseURL = 'gs://comicspa-248608.appspot.com/comics';

  static String get testServiceServerBaseURL => _testServiceServerBaseURL;
  static String get testStorageServerBaseURL => _testStorageServerBaseURL;
  static String get fireBaseStorageServerBaseURL => _fireBaseStorageServerBaseURL;

  static Future<Socket> createServiceSocket()
  {
    return Socket.connect('221.165.42.119', 9000);
  }


  static Future<Uint8List> getUint8ListFromFile(File file) async
  {
    if(null == file)
    {
      print('null == file');
      return null;
    }

    Uint8List readFileBytes = await file.readAsBytes();
    return readFileBytes;
  }


  static Future<ByteBuffer> getByteBufferFromFile(File file) async
  {
    Uint8List readFileBytes = await getUint8ListFromFile(file);
    if(null == readFileBytes)
      return null;

    ByteBuffer  readFileByteBuffer = readFileBytes.buffer;
    return readFileByteBuffer;
  }


  static Future<ByteData> getByteDataFromFilFile(File file) async
  {
    ByteBuffer  readFileByteBuffer = await getByteBufferFromFile(file);
    if(null == readFileByteBuffer)
      return null;

    ByteData byteData = ByteData.view(readFileByteBuffer);
    return byteData;
  }



  static Future<Uint8List> getUint8ListFromFilePath(String filePathFullName) async
  {
    File file = new File(filePathFullName);
    return getUint8ListFromFile(file);
  }


  static Future<ByteBuffer> getByteBufferFromFilePath(String filePathFullName) async
  {
    Uint8List readFileBytes = await getUint8ListFromFilePath(filePathFullName);
    if(null == readFileBytes)
      return null;

    ByteBuffer  readFileByteBuffer = readFileBytes.buffer;
    return readFileByteBuffer;
  }


  static Future<ByteData> getByteDataFromFilFilePath(String filePathFullName) async
  {
    ByteBuffer  readFileByteBuffer = await getByteBufferFromFilePath(filePathFullName);
    if(null == readFileByteBuffer)
      return null;

    ByteData byteData = ByteData.view(readFileByteBuffer);
    return byteData;
  }



}