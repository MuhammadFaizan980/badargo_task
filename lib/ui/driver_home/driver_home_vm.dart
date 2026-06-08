import 'dart:async';

import 'package:badargo_task/data/app_base_model.dart';
import 'package:badargo_task/data/app_base_vm.dart';
import 'package:badargo_task/data/repos/home/home_repo.dart';
import 'package:badargo_task/services/service_initiator.dart';
import 'package:badargo_task/utils/app_permission_handler.dart';
import 'package:badargo_task/utils/location_utils.dart';

import '../../services/location_service.dart';

class DriverHomeVm extends AppBaseVm {
  final AppBaseModel appBaseModel;
  final HomeRepo homeRepo;
  final AppPermissionHandler appPermissionHandler;
  final LocationUtils locationUtils;
  final bool isMock;

  bool _hasActiveOrder = false;
  double? lat, lng, heading, accuracy;

  DriverHomeVm({
    required this.appBaseModel,
    required this.homeRepo,
    required this.appPermissionHandler,
    required this.locationUtils,
    required this.isMock,
  });

  Future<void> onAcceptOrderTapped() async {
    if (await appPermissionHandler.requestLocationPermissions(showDialog: true)) {
      if (!(await locationUtils.isLocationServiceAvailable())) {
        await locationUtils.enableLocationServiceIfNotAvailable();
      } else {
        isMock ? null : await ServiceInitiator.initServices();
        Future.delayed(const Duration(milliseconds: 500));
        acceptOrder();
      }
    }
  }

  Future<bool> getOrderStatus() async => await homeRepo.getOrderStatus();

  Future<void> acceptOrder() async {
    await homeRepo.updateOrderStatus(status: true);
    _hasActiveOrder = true;
    isMock ? null : startLocationService();
    notifyListeners();
  }

  Future<void> cancelOrder() async {
    await homeRepo.updateOrderStatus(status: false);
    _hasActiveOrder = false;
    isMock ? null : stopLocationService();
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
