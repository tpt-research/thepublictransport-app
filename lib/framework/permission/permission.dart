import 'package:permission_handler/permission_handler.dart';

class PermissionFramework {
  Future<PermissionStatus> checkPermission(PermissionGroup group) async {
    PermissionStatus permission =
        await PermissionHandler().checkPermissionStatus(group);
    return permission;
  }

  bool resolvePermission(PermissionStatus permission) {
    if (permission == PermissionStatus.granted)
      return true;
    else
      return false;
  }
}
