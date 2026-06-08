import 'package:badargo_task/data/clients/local/local_data_client.dart';
import 'package:badargo_task/data/mappers/local_data_mapper.dart';
import 'package:badargo_task/data/models/app_data_provider_response_model.dart';

class MockLocalDbDataClient extends RemoteDataClient {
  final LocalDataMapper localDataMapper = LocalDataMapper();

  @override
  Future<AppDataProviderResponseModel> addNewEntry({
    required double lat,
    required double lng,
    required accuracy,
  }) async => localDataMapper.toGenericSuccessResponseModel(response: null);

  @override
  Future<AppDataProviderResponseModel> getAllSavedEntries() async =>
      localDataMapper.toGenericSuccessResponseModel(response: null);

  @override
  Future<AppDataProviderResponseModel> removeEntry({required int id}) async =>
      localDataMapper.toGenericSuccessResponseModel(response: null);
}
