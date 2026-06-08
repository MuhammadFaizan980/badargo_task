import 'package:badargo_task/data/clients/local/local_data_client.dart';
import 'package:badargo_task/data/local/db/app_database.dart';
import 'package:drift/drift.dart';

class LocalDbDataClient extends RemoteDataClient {
  final AppDatabase _appDatabase = AppDatabase();

  @override
  Future<String?> addNewEntry({required double lat, required double lng, required accuracy}) async {
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
      return null;
      ;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<List<LocationLocalTableData>?> getAllSavedEntries() async {
    try {
      return await (_appDatabase.select(_appDatabase.locationLocalTable)).get();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> removeEntry({required int id}) async {
    try {
      await (_appDatabase.delete(_appDatabase.locationLocalTable)..where((table) => table.id.equals(id))).go();
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
