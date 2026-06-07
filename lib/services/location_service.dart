import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:badargo_task/data/constants/app_constants.dart';
import 'package:badargo_task/utils/location_utils.dart';
import 'package:badargo_task/utils/network_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const notificationChannelId = AppConstants.notificationChannelId;
const notificationId = AppConstants.notificationId;
final LocationUtils _locationUtils = LocationUtils();
final NetworkUtils _networkUtils = NetworkUtils();

StreamSubscription? _locationSubscription;
StreamSubscription? _connectivitySubscription;

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
    service.invoke(AppConstants.onLocationServiceStopped);
    _locationSubscription?.cancel();
    _connectivitySubscription?.cancel();
    service.stopSelf();
  });

  _locationSubscription = _locationUtils.initLocationStream(
    onLocationUpdated: (position) async {
      print('DXDIAG::SERVICE::${position?.latitude}, ${position?.longitude}');

      service.invoke(AppConstants.onLocationUpdate, {
        'lat': position?.latitude,
        'lng': position?.longitude,
        'accuracy': position?.accuracy,
        'heading': position?.heading,
      });

      if (await _networkUtils.hasInternetConnection()) {
        //TODO: save to remote server...
      } else {
        //TODO: save to local db...
      }
    },
  );

  _connectivitySubscription = _networkUtils.initConnectivityStream(
    onConnectivityChanged: (connectivityResult) {
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        print('DXDIAG::NETWORK_ENABLED');
        //TODO: sync local stored location data with server...
      } else {
        print('DXDIAG::NETWORK_DISABLE');
      }
    },
  );

  if (Platform.isAndroid) {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (service is AndroidServiceInstance && await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
          title: "Background Location Active",
          content: "Tracking location in background...",
        );
      }
    });
  }
}
