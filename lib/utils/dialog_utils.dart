import 'package:badargo_task/main.dart';
import 'package:badargo_task/router/app_navigator.dart';
import 'package:flutter/material.dart';

Future<void> showInfoDialog({required String message}) async {
  await showDialog(
    context: navigatorKey.currentState!.context,
    builder: (context) => AlertDialog(
      title: Text('Message'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            getAppNavigator().pop();
          },
          child: Text('Close'),
        ),
      ],
    ),
  );
}
