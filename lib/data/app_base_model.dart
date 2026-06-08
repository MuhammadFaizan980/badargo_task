import 'package:badargo_task/data/app_base_repo.dart';
import 'package:badargo_task/data/app_base_vm.dart';
import 'package:badargo_task/data/local/local_data_dispatcher.dart';
import 'package:badargo_task/data/repos/local_data/local_data_repo.dart';
import 'package:badargo_task/data/repos/remote_data/remote_data_repo.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'local/db/app_database.dart';
import 'models/app_data_provider_response_model.dart';

class AppBaseModel extends AppBaseVm with AppBaseRepo {
  final LocalDataRepo localDataRepo;
  final RemoteDataRepo remoteDataRepo;
  final LocalDataDispatcher appLocalData;
  FlutterBackgroundService? service;

  AppBaseModel({
    required this.localDataRepo,
    required this.remoteDataRepo,
    required this.appLocalData,
    required this.service,
  }) {
    _syncLocalData();
  }

  Future<bool> hasActiveOrder() async => await appLocalData.getOrderStatus();

  Future<void> _syncLocalData() async {
    if (service == null || (await service?.isRunning()) == true) {
      return;
    }

    AppDataProviderResponseModel responseModel = await localDataRepo.getAllSavedEntries();

    if (responseModel.success && (responseModel.data as List<LocationLocalTableData>).isNotEmpty) {
      (responseModel.data as List<LocationLocalTableData>).forEach((e) async {
        await remoteDataRepo.saveLocationEntry(
          lat: double.parse(e.lat!),
          lng: double.parse(e.lng!),
          accuracy: double.parse(e.accuracy!),
          timestamp: e.timestamp!,
        );
        localDataRepo.removeEntry(id: e.id);
      });
    }
  }
}
