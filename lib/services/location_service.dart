// import 'dart:async';
// import 'dart:io';
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:location/location.dart';
//
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// const notificationChannelId = 'my_foreground';
// const notificationId = 888;
// final Location _location = Location();
//
// void startLocationService() {
//   final service = FlutterBackgroundService();
//   service.startService();
// }
//
// void stopLocationService() {
//   final service = FlutterBackgroundService();
//   service.invoke("stop");
// }
//
// // make sure to get location permissions before initiating location service...
// Future<void> initializeLocationService() async {
//   final service = FlutterBackgroundService();
//
//   Platform.isAndroid
//       ? await flutterLocalNotificationsPlugin
//             .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//             ?.requestNotificationsPermission()
//       : await flutterLocalNotificationsPlugin
//             .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
//             ?.requestPermissions();
//
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     notificationChannelId,
//     'MY FOREGROUND SERVICE',
//     description: 'This channel is used for important notifications.',
//     importance: Importance.low,
//   );
//
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   await service.configure(
//     iosConfiguration: IosConfiguration(autoStart: false, onForeground: onStart, onBackground: onIosBackground),
//     androidConfiguration: AndroidConfiguration(
//       autoStart: false,
//       onStart: onStart,
//       isForegroundMode: true,
//       autoStartOnBoot: false,
//       notificationChannelId: notificationChannelId,
//       initialNotificationTitle: 'Location Service',
//       initialNotificationContent: 'Initializing location service...',
//       foregroundServiceNotificationId: notificationId,
//       foregroundServiceTypes: [AndroidForegroundType.location],
//     ),
//   );
// }
//
// @pragma('vm:entry-point')
// Future<bool> onIosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//   //TODO: integrate iOS background code logic here...
//   return true;
// }
//
// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   if (service is AndroidServiceInstance) {
//     service.setAsForegroundService();
//   }
//
//   service.on('stop').listen((event) {
//     service.stopSelf();
//   });
//
//   final location = Location();
//
//   try {
//     // wait for proper initialization window
//     await Future.delayed(const Duration(seconds: 1));
//
//     // safer permission + background setup
//     if (!await location.serviceEnabled()) {
//       await location.requestService();
//       await Future.delayed(const Duration(seconds: 1));
//     }
//
//     // IMPORTANT: enable background mode AFTER permissions
//     if (!(await location.isBackgroundModeEnabled())) {
//       await location.enableBackgroundMode(enable: true);
//       await Future.delayed(const Duration(seconds: 1));
//     }
//
//     // NOW safe to get location
//     final result = await location.getLocation();
//     print('DXDIAG LAT:: ${result.latitude}');
//   } catch (e) {
//     print('LOCATION ERROR: $e');
//   }
//
//   Timer.periodic(const Duration(seconds: 5), (timer) async {
//     if (service is AndroidServiceInstance) {
//       if (await service.isForegroundService()) {
//         service.setForegroundNotificationInfo(title: "Location Service Running", content: "Tracking active...");
//       }
//     }
//   });
// }

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:badargo_task/data/constants/app_constants.dart';
import 'package:badargo_task/utils/location_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const notificationChannelId = AppConstants.notificationChannelId;
const notificationId = AppConstants.notificationId;
final LocationUtils _locationUtils = LocationUtils();

StreamSubscription? _locationSSubscription;

void startLocationService() {
  final service = FlutterBackgroundService();
  service.startService();
}

void stopLocationService() {
  final service = FlutterBackgroundService();
  service.invoke("stop");
}

Future<void> initializeLocationService() async {
  final service = FlutterBackgroundService();

  if (Platform.isAndroid) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  } else {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions();
  }

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId,
    'MY FOREGROUND SERVICE',
    description: 'Location tracking service',
    importance: Importance.low,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    iosConfiguration: IosConfiguration(autoStart: false, onForeground: onStart, onBackground: onIosBackground),
    androidConfiguration: AndroidConfiguration(
      autoStart: false,
      onStart: onStart,
      isForegroundMode: true,
      autoStartOnBoot: false,
      notificationChannelId: notificationChannelId,
      initialNotificationTitle: 'Location Service',
      initialNotificationContent: 'Running...',
      foregroundServiceNotificationId: notificationId,
      foregroundServiceTypes: [AndroidForegroundType.location],
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
  }

  service.on('stop').listen((event) {
    service.stopSelf();
    _locationSSubscription?.cancel();
  });

  _locationSSubscription = _locationUtils.initLocationStream(
    onLocationUpdated: (position) {
      print('DXDIAG::SERVICE::${position?.latitude}, ${position?.longitude}');

      service.invoke('onLocationUpdate', {
        'lat': position?.latitude,
        'lng': position?.longitude,
        'accuracy': position?.accuracy,
        'heading': position?.heading,
      });
    },
  );

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance && await service.isForegroundService()) {
      service.setForegroundNotificationInfo(
        title: "Background Location Active",
        content: "Tracking location in background...",
      );
    }
  });
}
