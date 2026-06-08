import 'package:badargo_task/data/app_base_repo.dart';
import 'package:badargo_task/data/clients/remote_data_client.dart';
import 'package:badargo_task/data/mappers/remote_data_mapper.dart';
import 'package:badargo_task/data/models/app_data_provider_response_model.dart';

abstract class RemoteDataRepo extends AppBaseRepo {
  final RemoteDataClient remoteDataClient;
  final RemoteDataMapper remoteDataMapper = RemoteDataMapper();

  RemoteDataRepo(this.remoteDataClient);

  Future<AppDataProviderResponseModel> saveLocationEntry({
    required double lat,
    required double lng,
    required double accuracy,
    required int timestamp,
  });
}
