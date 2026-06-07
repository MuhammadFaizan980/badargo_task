import 'package:badargo_task/data/app_base_model.dart';
import 'package:badargo_task/data/app_base_vm.dart';
import 'package:get_it/get_it.dart';

class DriverHomeVm extends AppBaseVm {
  final AppBaseModel appBaseModel = GetIt.I.get();
  bool _orderInProgress = false;
}
