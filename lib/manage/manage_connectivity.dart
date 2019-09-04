import 'package:connectivity/connectivity.dart';




class ManageConnectivity
{
  static Future<String> check() async
  {
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult.toString();
  }

}


