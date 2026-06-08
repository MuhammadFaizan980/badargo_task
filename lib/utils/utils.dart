import 'package:badargo_task/data/constants/app_assets.dart';
import 'package:badargo_task/main.dart';
import 'package:badargo_task/router/app_navigator.dart';
import 'package:badargo_task/utils/widgets/permissions_message_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

Future<void> showPermissionMessageDialog() async {
  final BuildContext context = navigatorKey.currentState!.context;

  await showDialog(
    context: context,
    builder: (context) => PermissionsMessageDialog(
      title: 'Message!',
      message: 'Missing location and notifications permissions!',
      iconData: CupertinoIcons.settings,
      onOpenSettingsTapped: () async {
        getAppNavigator().pop();
        ph.openAppSettings();
      },
      onCancelTapped: getAppNavigator().pop,
    ),
  );
}

Future<Marker> getCarMarker({required double lat, required double lng, required double heading}) async {
  return Marker(
    markerId: const MarkerId('driver_car'),
    position: LatLng(lat, lng),
    icon: await BitmapDescriptor.asset(const ImageConfiguration(size: Size(45, 80)), AppAssets.carIcon),
    rotation: heading,
    anchor: const Offset(0.5, 0.5),
    flat: true,
  );
}
