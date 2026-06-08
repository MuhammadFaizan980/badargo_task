import 'package:badargo_task/data/local/db/app_database.dart';
import 'package:badargo_task/data/models/app_data_provider_response_model.dart';
import 'package:badargo_task/data/repos/local_data/local_data_repo.dart';

class LocalDataRepoImp extends LocalDataRepo {
  LocalDataRepoImp(super.client);

  @override
  Future<AppDataProviderResponseModel> addNewEntry({
    required double lat,
    required double lng,
    required accuracy,
  }) async {
    String? err = await client.addNewEntry(lat: lat, lng: lng, accuracy: accuracy);

    return err == null
        ? localDataMapper.toGenericSuccessResponseModel(response: null)
        : localDataMapper.toGenericFailureResponseModel(message: err, response: null);
  }

  @override
  Future<AppDataProviderResponseModel> getAllSavedEntries() async {
    List<LocationLocalTableData>? response = await client.getAllSavedEntries();
    return response != null
        ? localDataMapper.toGenericSuccessResponseModel(response: response)
        : localDataMapper.toGenericFailureResponseModel(message: '', response: null);
  }

  @override
  Future<AppDataProviderResponseModel> removeEntry({required int id}) async {
    String? err = await client.removeEntry(id: id);
    return err == null
        ? localDataMapper.toGenericSuccessResponseModel(response: null)
        : localDataMapper.toGenericFailureResponseModel(message: err, response: null);
  }
}
