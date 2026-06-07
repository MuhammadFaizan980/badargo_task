import 'dart:async';

import 'package:badargo_task/data/app_base_repo.dart';
import 'package:badargo_task/data/app_base_vm.dart';
import 'package:badargo_task/services/location_service.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';

class AppBaseModel extends AppBaseVm with AppBaseRepo {
  double? lat, lng, heading, accuracy;
  Position? currentPosition;
  StreamSubscription? _locationStreamSubscription;

  AppBaseModel() {
    listenToServiceBroadCast();
  }

  void listenToServiceBroadCast() {
    _locationStreamSubscription = FlutterBackgroundService().on('onLocationUpdate').listen((data) {
      if (data != null) {
        lat = data['lat'];
        lng = data['lng'];
        heading = data['heading'] != null ? data['heading'] + .0 : null;
        accuracy = data['accuracy'] != null ? data['accuracy'] + .0 : null;
      }
      notifyListeners();
    });
  }

  Future<bool> getOrderStatus() async => await appLocalData.getOrderStatus();

  Future<void> acceptOrder() async {
    await appLocalData.setOrderStatus(status: true);
    startLocationService();
  }

  Future<void> cancelOrder() async {
    await appLocalData.setOrderStatus(status: false);
    stopLocationService();
  }

  @override
  void dispose() {
    _locationStreamSubscription?.cancel();
    super.dispose();
  }
}
