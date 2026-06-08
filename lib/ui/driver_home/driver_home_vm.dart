import 'dart:async';

import 'package:badargo_task/data/app_base_model.dart';
import 'package:badargo_task/data/app_base_vm.dart';
import 'package:badargo_task/data/repos/home/home_repo.dart';
import 'package:badargo_task/data/repos/local_data/local_data_repo.dart';
import 'package:badargo_task/services/location_service.dart';
import 'package:badargo_task/utils/app_permission_handler.dart';
import 'package:badargo_task/utils/location_utils.dart';
import 'package:get_it/get_it.dart';

class DriverHomeVm extends AppBaseVm {
  final AppBaseModel appBaseModel = GetIt.I.get();
  final HomeRepo _homeRepo = GetIt.I.get();
  final LocalDataRepo _localDataRepo = GetIt.I.get();
  final AppPermissionHandler _appPermissionHandler = GetIt.I.get();
  final LocationUtils _locationUtils = GetIt.I.get();

  bool _hasActiveOrder = false;
  double? lat, lng, heading, accuracy;

  Future<void> onAcceptOrderTapped() async {
    if (await _appPermissionHandler.requestLocationPermissions(showDialog: true)) {
      if (!(await _locationUtils.isLocationServiceAvailable())) {
        await _locationUtils.enableLocationServiceIfNotAvailable();
      } else {
        Future.delayed(const Duration(milliseconds: 500));
        acceptOrder();
      }
    }
  }

  Future<bool> getOrderStatus() async => await _homeRepo.getOrderStatus();

  Future<void> acceptOrder() async {
    await _homeRepo.updateOrderStatus(status: true);
    startLocationService();
    _hasActiveOrder = true;
    notifyListeners();
  }

  Future<void> cancelOrder() async {
    await _homeRepo.updateOrderStatus(status: false);
    stopLocationService();
    _hasActiveOrder = false;
    notifyListeners();
  }

  Future<void> onLocationUpdated({
    required double accuracy,
    required double heading,
    required double lat,
    required double lng,
  }) async {
    this.lat = lat;
    this.lng = lng;
    this.accuracy = accuracy;
    this.heading = heading;
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
  }

  Future<void> onLocationServiceStopped() async {
    lat = null;
    lng = null;
    accuracy = null;
    heading = null;
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
  }

  /// getters/setters below this line...

  bool get hasActiveOrder => _hasActiveOrder;

  set hasActiveOrder(bool value) {
    _hasActiveOrder = value;
    notifyListeners();
  }
}
