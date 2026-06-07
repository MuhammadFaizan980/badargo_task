import 'package:permission_handler/permission_handler.dart' as ph;

class AppPermissionHandler {
  Future<bool> requestLocationPermissions() async {
    ph.PermissionStatus status = await ph.Permission.location.request();
    if (status == ph.PermissionStatus.granted) {
      return true;
    }

    return false;
  }
}
