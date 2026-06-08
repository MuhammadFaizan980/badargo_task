import 'package:badargo_task/data/app_base_repo.dart';
import 'package:badargo_task/data/app_base_vm.dart';
import 'package:badargo_task/data/local/local_data_dispatcher.dart';
import 'package:badargo_task/data/repos/local_data/local_data_repo.dart';
import 'package:badargo_task/data/repos/remote_data/remote_data_repo.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get_it/get_it.dart';

import 'local/db/app_database.dart';
import 'models/app_data_provider_response_model.dart';

class AppBaseModel extends AppBaseVm with AppBaseRepo {
  final LocalDataRepo _localDataRepo = GetIt.I.get();
  final RemoteDataRepo _remoteDataRepo = GetIt.I.get();
  final LocalDataDispatcher _appLocalData = GetIt.I.get();

  Future<bool> hasActiveOrder() async => await _appLocalData.getOrderStatus();

  AppBaseModel() {
    _syncLocalData();
  }

  Future<void> _syncLocalData() async {
    if (await FlutterBackgroundService().isRunning()) {
      return;
    }

    AppDataProviderResponseModel responseModel = await _localDataRepo.getAllSavedEntries();

    if (responseModel.success && (responseModel.data as List<LocationLocalTableData>).isNotEmpty) {
      (responseModel.data as List<LocationLocalTableData>).forEach((e) async {
        await _remoteDataRepo.saveLocationEntry(
          lat: double.parse(e.lat!),
          lng: double.parse(e.lng!),
          accuracy: double.parse(e.accuracy!),
          timestamp: e.timestamp!,
        );
        _localDataRepo.removeEntry(id: e.id);
      });
    }
  }
}
