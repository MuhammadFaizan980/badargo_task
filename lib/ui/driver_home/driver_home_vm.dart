import 'package:badargo_task/data/app_base_model.dart';
import 'package:badargo_task/data/app_base_vm.dart';
import 'package:badargo_task/service_initiator.dart';
import 'package:badargo_task/utils/app_permission_handler.dart';
import 'package:get_it/get_it.dart';

class DriverHomeVm extends AppBaseVm {
  final AppBaseModel appBaseModel = GetIt.I.get();
  final AppPermissionHandler _appPermissionHandler = GetIt.I.get();

  Future<void> onAcceptOrderTapped() async {
    if (await _appPermissionHandler.requestLocationPermissions(showDialog: true)) {
      await ServiceInitiator.initServices();
      Future.delayed(const Duration(milliseconds: 500));
      appBaseModel.acceptOrder();
      notifyListeners();
    }
  }
}
