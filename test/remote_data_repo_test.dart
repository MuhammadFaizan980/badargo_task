import 'package:badargo_task/data/clients/remote/mock_firebase_firestore_client.dart';
import 'package:badargo_task/data/models/app_data_provider_response_model.dart';
import 'package:badargo_task/data/repos/remote_data/remote_data_repo.dart';
import 'package:badargo_task/data/repos/remote_data/remote_data_repo_imp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
