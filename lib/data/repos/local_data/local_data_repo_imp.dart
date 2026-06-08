import 'package:badargo_task/data/local/db/app_database.dart';
import 'package:badargo_task/data/models/app_data_provider_response_model.dart';
import 'package:badargo_task/data/repos/local_data/local_data_repo.dart';
import 'package:drift/drift.dart';

class LocalDataRepoImp extends LocalDataRepo {
  LocalDataRepoImp(super.database);

  @override
  Future<AppDataProviderResponseModel> addNewEntry({
    required double lat,
    required double lng,
    required accuracy,
  }) async {
    try {
      await database
          .into(database.locationLocalTable)
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
      response: await (database.select(database.locationLocalTable)).get(),
    );
  }

  @override
  Future<AppDataProviderResponseModel> removeEntry({required int id}) async {
    try {
      await (database.delete(database.locationLocalTable)..where((table) => table.id.equals(id))).go();
      return localDataMapper.toGenericSuccessResponseModel(response: null);
    } catch (e) {
      return localDataMapper.toGenericFailureResponseModel(message: e.toString(), response: null);
    }
  }
}
