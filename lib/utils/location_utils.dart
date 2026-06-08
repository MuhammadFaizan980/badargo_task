import 'dart:async';
import 'dart:io';

import 'package:geolocator/geolocator.dart';

class LocationUtils {
  Future<bool> isLocationServiceAvailable() async => await Geolocator.isLocationServiceEnabled();

  Future<void> enableLocationServiceIfNotAvailable() async {
    await Geolocator.openLocationSettings();
  }

  StreamSubscription initLocationStream({required Function(Position?) onLocationUpdated}) {
    return Geolocator.getPositionStream(
      locationSettings: _getLocationSettings(),
    ).listen((Position? position) => onLocationUpdated(position));
  }

  Future<Position?> initGetLocation() async {
    return await Geolocator.getCurrentPosition(locationSettings: _getLocationSettings());
  }

  LocationSettings _getLocationSettings() => Platform.isAndroid
      ? AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 20,
          intervalDuration: const Duration(seconds: 5),
          forceLocationManager: true,
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText: "Location Service",
            notificationTitle: "Running...",
            enableWakeLock: true,
          ),
        )
      : AppleSettings(
          accuracy: LocationAccuracy.high,
          // iOS does not allow a strict time interval, we will need to add a middleware to handle timing on iOS
          distanceFilter: 20,
          pauseLocationUpdatesAutomatically: false,
          showBackgroundLocationIndicator: true,
          allowBackgroundLocationUpdates: true,
        );
}
