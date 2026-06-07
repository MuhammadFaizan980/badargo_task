import 'package:badargo_task/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class AppPermissionHandler {
  Future<bool> requestLocationPermissions({bool showDialog = false}) async {
    ph.PermissionStatus status = await ph.Permission.location.request();
    if (status == ph.PermissionStatus.granted) {
      return true;
    }

    if (showDialog) {
      showPermissionMessageDialog();
    }

    return false;
  }
}
