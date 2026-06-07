import 'package:badargo_task/main.dart';
import 'package:flutter/material.dart';

void showMessage({BuildContext? context, required String message, int? durationInSeconds, bool error = false}) {
  BuildContext buildContext = context ?? navigatorKey.currentState!.context;

  ScaffoldMessenger.of(buildContext).clearSnackBars();
  ScaffoldMessenger.of(buildContext).showSnackBar(
    SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: error ? Colors.red : Colors.green,
      duration: Duration(seconds: durationInSeconds ?? (error ? 5 : 3)),
    ),
  );
}
