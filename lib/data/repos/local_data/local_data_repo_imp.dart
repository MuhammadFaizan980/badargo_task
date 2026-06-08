import 'package:badargo_task/data/models/app_data_provider_response_model.dart';
import 'package:badargo_task/data/repos/local_data/local_data_repo.dart';

class LocalDataRepoImp extends LocalDataRepo {
  LocalDataRepoImp(super.client);

  @override
  Future<AppDataProviderResponseModel> addNewEntry({
    required double lat,
    required double lng,
    required accuracy,
  }) async => await client.addNewEntry(lat: lat, lng: lng, accuracy: accuracy);

  @override
  Future<AppDataProviderResponseModel> getAllSavedEntries() async => await client.getAllSavedEntries();

  @override
  Future<AppDataProviderResponseModel> removeEntry({required int id}) async => await client.removeEntry(id: id);
}
