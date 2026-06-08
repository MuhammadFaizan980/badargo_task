import 'package:badargo_task/data/clients/local/mock_local_db_data_client.dart';
import 'package:badargo_task/data/models/app_data_provider_response_model.dart';
import 'package:badargo_task/data/repos/local_data/local_data_repo.dart';
import 'package:badargo_task/data/repos/local_data/local_data_repo_imp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
}
