

import 'package:permission_handler/permission_handler.dart';


class ManagePermission
{

  static Future<bool> checkRequest() async
  {
    Map<PermissionGroup, PermissionStatus> permissions;
    PermissionStatus permissionStatus = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    switch(permissionStatus)
    {
      case PermissionStatus.denied:
      case PermissionStatus.disabled:
        {
          permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
          permissionStatus = permissions[PermissionGroup.storage];
          print(permissionStatus.toString());

          switch(permissionStatus) {
            case PermissionStatus.denied:
            case PermissionStatus.disabled:
              return false;
          }
        }
        break;

    }
    return true;
  }
}