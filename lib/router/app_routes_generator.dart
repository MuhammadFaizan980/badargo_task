import 'package:badargo_task/ui/driver_home/driver_home_screen.dart';
import 'package:badargo_task/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import 'app_error_route.dart';
import 'app_routes.dart';

Route generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashScreen:
      return MaterialPageRoute(settings: settings, builder: (context) => const SplashScreen());
    case AppRoutes.driverHomeScreen:
      return MaterialPageRoute(settings: settings, builder: (context) => DriverHomeScreen());
    default:
      {
        return MaterialPageRoute(settings: settings, builder: (context) => const AppErrorRoute());
      }
  }
}
