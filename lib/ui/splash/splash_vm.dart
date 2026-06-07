import 'package:badargo_task/data/app_base_vm.dart';
import 'package:badargo_task/router/app_navigator.dart';
import 'package:badargo_task/router/app_routes.dart';
import 'package:badargo_task/service_initiator.dart';
import 'package:badargo_task/utils/app_permission_handler.dart';
import 'package:badargo_task/utils/dialog_utils.dart';
import 'package:get_it/get_it.dart';

class SplashVm extends AppBaseVm {
  final AppPermissionHandler _appPermissionHandler = GetIt.I.get();

  Future<void> initTimer() async {
    await Future.delayed(const Duration(seconds: 3));
    _getLocationPermission();
  }

  Future<void> _getLocationPermission() async {
    bool locationPermissionGranted = await _appPermissionHandler.requestLocationPermissions();
    if (!locationPermissionGranted) {
      await showInfoDialog(
        message:
            'Missing location permission. Open settings to allow necessary permissions for the app to work properly.',
      );
      _handleNavigation();
    } else {
      _initBackgroundServices();
    }
  }

  Future<void> _initBackgroundServices() async {
    // initialize all services here to be used later...
    await ServiceInitiator.initServices();
    _handleNavigation();
  }

  void _handleNavigation() {
    getAppNavigator().pushReplacementNamed(AppRoutes.driverHomeScreen);
  }
}
