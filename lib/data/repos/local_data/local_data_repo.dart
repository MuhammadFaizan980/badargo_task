import 'package:badargo_task/data/app_base_repo.dart';
import 'package:badargo_task/data/clients/local/local_data_client.dart';
import 'package:badargo_task/data/mappers/local_data_mapper.dart';
import 'package:badargo_task/data/models/app_data_provider_response_model.dart';

abstract class LocalDataRepo extends AppBaseRepo {
  final RemoteDataClient client;
  final LocalDataMapper localDataMapper = LocalDataMapper();

  LocalDataRepo(this.client);

  Future<AppDataProviderResponseModel> getAllSavedEntries();
  Future<AppDataProviderResponseModel> addNewEntry({
    required double lat,
    required double lng,
    required double accuracy,
  });
  Future<AppDataProviderResponseModel> removeEntry({required int id});
}
