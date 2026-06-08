import 'package:badargo_task/data/clients/local/local_data_client.dart';
import 'package:badargo_task/data/local/db/app_database.dart';
import 'package:badargo_task/data/mappers/local_data_mapper.dart';
import 'package:badargo_task/data/models/app_data_provider_response_model.dart';
import 'package:drift/drift.dart';

class LocalDbDataClient extends RemoteDataClient {
  final AppDatabase _appDatabase = AppDatabase();
  final LocalDataMapper localDataMapper = LocalDataMapper();

  @override
  Future<AppDataProviderResponseModel> addNewEntry({
    required double lat,
    required double lng,
    required accuracy,
  }) async {
    try {
      await _appDatabase
          .into(_appDatabase.locationLocalTable)
          .insert(
            LocationLocalTableCompanion(
              accuracy: Value(accuracy.toString()),
              lat: Value(lat.toString()),
              lng: Value(lng.toString()),
              timestamp: Value(DateTime.now().millisecondsSinceEpoch),
            ),
          );
      return localDataMapper.toGenericSuccessResponseModel(response: null);
    } catch (e) {
      return localDataMapper.toGenericFailureResponseModel(message: e.toString(), response: null);
    }
  }

  @override
  Future<AppDataProviderResponseModel> getAllSavedEntries() async {
    return localDataMapper.toGenericSuccessResponseModel(
      response: await (_appDatabase.select(_appDatabase.locationLocalTable)).get(),
    );
  }

  @override
  Future<AppDataProviderResponseModel> removeEntry({required int id}) async {
    try {
      await (_appDatabase.delete(_appDatabase.locationLocalTable)..where((table) => table.id.equals(id))).go();
      return localDataMapper.toGenericSuccessResponseModel(response: null);
    } catch (e) {
      return localDataMapper.toGenericFailureResponseModel(message: e.toString(), response: null);
    }
  }
}
