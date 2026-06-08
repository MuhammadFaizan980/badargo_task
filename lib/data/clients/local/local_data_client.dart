import 'package:badargo_task/data/local/db/app_database.dart';

abstract class RemoteDataClient {
  Future<List<LocationLocalTableData>?> getAllSavedEntries();

  Future<String?> addNewEntry({required double lat, required double lng, required double accuracy});

  Future<String?> removeEntry({required int id});
}
