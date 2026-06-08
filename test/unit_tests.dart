import 'package:badargo_task/data/clients/local/mock_local_db_data_client.dart';
import 'package:badargo_task/data/clients/remote/mock_firebase_firestore_client.dart';
import 'package:badargo_task/data/local/mock_local_data.dart';
import 'package:badargo_task/data/models/app_data_provider_response_model.dart';
import 'package:badargo_task/data/repos/home/home_repo.dart';
import 'package:badargo_task/data/repos/home/home_repo_imp.dart';
import 'package:badargo_task/data/repos/local_data/local_data_repo.dart';
import 'package:badargo_task/data/repos/local_data/local_data_repo_imp.dart';
import 'package:badargo_task/data/repos/remote_data/remote_data_repo.dart';
import 'package:badargo_task/data/repos/remote_data/remote_data_repo_imp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Home Repo Tests', () {
    HomeRepo homeRepo = HomeRepoImp(MockLocalData());

    test('Get order status test', () async {
      bool status = await homeRepo.getOrderStatus();
      expect(status, false);
    });

    test('Update order status test', () async {
      bool status = await homeRepo.updateOrderStatus(status: true);
      expect(status, true);
    });

    test('Clear order status test', () async {
      bool status = await homeRepo.clearLocalData();
      expect(status, true);
    });
  });

  group('Local Data Repo Tests', () {
    LocalDataRepo localDataRepo = LocalDataRepoImp(MockLocalDbDataClient());

    test('Get all saved entries', () async {
      AppDataProviderResponseModel responseModel = await localDataRepo.getAllSavedEntries();
      expect(responseModel.success, true);
    });

    test('Save new entry', () async {
      AppDataProviderResponseModel responseModel = await localDataRepo.addNewEntry(
        lat: 12.099,
        lng: -122.928,
        accuracy: 5.0,
      );
      expect(responseModel.success, true);
    });

    test('Remove entry', () async {
      AppDataProviderResponseModel responseModel = await localDataRepo.removeEntry(id: 12);
      expect(responseModel.success, true);
    });
  });

  group('Remote Data Repo Tests', () {
    RemoteDataRepo remoteDataRepo = RemoteDataRepoImp(MockFirebaseFirestoreClient());
    test('Save new entry', () async {
      AppDataProviderResponseModel responseModel = await remoteDataRepo.saveLocationEntry(
        lat: 12.099,
        lng: -122.928,
        accuracy: 5.0,
        timestamp: 123456,
      );
      expect(responseModel.success, true);
    });
  });
}
