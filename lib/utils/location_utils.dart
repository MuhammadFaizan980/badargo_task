import 'dart:async';
import 'dart:io';

import 'package:badargo_task/data/app_constants.dart';
import 'package:geolocator/geolocator.dart';

class LocationUtils {
  StreamSubscription initLocationStream({required Function(Position?) onLocationUpdated}) {
    final LocationSettings locationSettings;

    if (Platform.isAndroid) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,

        // 1. Trigger if user moves 20 meters
        distanceFilter: 20,

        // 2. Trigger if 5 seconds pass (Whichever happens first)
        intervalDuration: const Duration(seconds: 5),

        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText: "Tracking active",
          notificationTitle: "Location tracking is running...",
          notificationChannelName: AppConstants.notificationChannelId,
          enableWakeLock: true,
        ),
      );
    } else {
      // iOS Settings
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 20, // 20 Meters
        // iOS does not allow a strict time interval fallback for streaming,
        // but setting pauseLocationUpdatesAutomatically to false keeps it active.
        pauseLocationUpdatesAutomatically: false,
        showBackgroundLocationIndicator: true,
      );
    }

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
        );
}
