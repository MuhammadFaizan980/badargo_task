import 'package:badargo_task/main.dart';
import 'package:flutter/material.dart';

NavigatorState getAppNavigator({BuildContext? context}) {
  // uses global context if no context passed
  BuildContext bContext = context ?? navigatorKey.currentState!.context;
  return Navigator.of(bContext);
}
