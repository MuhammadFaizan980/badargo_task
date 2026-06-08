import 'package:badargo_task/data/models/app_data_provider_response_model.dart';

abstract class RemoteDataClient {
  Future<AppDataProviderResponseModel> getAllSavedEntries();

  Future<AppDataProviderResponseModel> addNewEntry({
    required double lat,
    required double lng,
    required double accuracy,
  });

  Future<AppDataProviderResponseModel> removeEntry({required int id});
}
