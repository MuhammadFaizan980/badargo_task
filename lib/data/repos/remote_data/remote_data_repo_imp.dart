import 'package:badargo_task/data/models/app_data_provider_response_model.dart';
import 'package:badargo_task/data/repos/remote_data/remote_data_repo.dart';

class RemoteDataRepoImp extends RemoteDataRepo {
  RemoteDataRepoImp(super.remoteDataClient);

  @override
  Future<AppDataProviderResponseModel> saveLocationEntry({
    required double lat,
    required double lng,
    required double accuracy,
    required int timestamp,
  }) async {
    String? err = await remoteDataClient.saveLocationEntry(
      lat: lat,
      lng: lng,
      accuracy: accuracy,
      timestamp: timestamp,
    );

    return err == null
        ? remoteDataMapper.toGenericSuccessResponseModel(response: null)
        : remoteDataMapper.toGenericFailureResponseModel(message: err, response: null);
  }
}
