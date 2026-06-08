import 'package:badargo_task/data/app_base_model.dart';
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
import 'package:badargo_task/ui/driver_home/driver_home_vm.dart';
import 'package:badargo_task/utils/app_permission_handler.dart';
import 'package:badargo_task/utils/location_utils.dart';
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
  group('Home VM Test', () {
    DriverHomeVm driverHomeVm = DriverHomeVm(
      appBaseModel: AppBaseModel(
        appLocalData: MockLocalData(),
        localDataRepo: LocalDataRepoImp(MockLocalDbDataClient()),
        remoteDataRepo: RemoteDataRepoImp(MockFirebaseFirestoreClient()),
        service: null,
      ),
      appPermissionHandler: AppPermissionHandler(),
      homeRepo: HomeRepoImp(MockLocalData()),
      locationUtils: LocationUtils(),
      isMock: true,
    );

    test('On location updates received', () async {
      driverHomeVm.onLocationUpdated(lat: 12.345, lng: -122.345, accuracy: 5.0, heading: 120.0);
      expect(driverHomeVm.lat, 12.345);
      expect(driverHomeVm.lng, -122.345);
      expect(driverHomeVm.accuracy, 5.0);
      expect(driverHomeVm.heading, 120.0);
    });

    test('Get order status', () async {
      bool status = await driverHomeVm.getOrderStatus();
      expect(status, false);
    });

    test('Accepting order', () async {
      await driverHomeVm.acceptOrder();
      expect(driverHomeVm.hasActiveOrder, true);
    });

    test('Cancelling order', () async {
      await driverHomeVm.cancelOrder();
      expect(driverHomeVm.hasActiveOrder, false);
    });

    test('On location updates received', () async {
      driverHomeVm.onLocationUpdated(lat: 12.345, lng: -122.345, accuracy: 5.0, heading: 120.0);
      expect(driverHomeVm.lat, 12.345);
      expect(driverHomeVm.lng, -122.345);
      expect(driverHomeVm.accuracy, 5.0);
      expect(driverHomeVm.heading, 120.0);
    });

    test('On location service stopped', () async {
      driverHomeVm.onLocationServiceStopped();
      expect(driverHomeVm.lat, null);
      expect(driverHomeVm.lng, null);
      expect(driverHomeVm.accuracy, null);
      expect(driverHomeVm.heading, null);
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
