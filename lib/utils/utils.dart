import 'package:badargo_task/main.dart';
import 'package:badargo_task/router/app_navigator.dart';
import 'package:badargo_task/utils/widgets/permissions_message_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

Future<void> showPermissionMessageDialog() async {
  final BuildContext context = navigatorKey.currentState!.context;

  await showDialog(
    context: context,
    builder: (context) => PermissionsMessageDialog(
      title: 'Message!',
      message: 'Missing location permission!',
      iconData: CupertinoIcons.settings,
      onOpenSettingsTapped: () async {
        getAppNavigator().pop();
        ph.openAppSettings();
      },
      onCancelTapped: getAppNavigator().pop,
    ),
  );
}
