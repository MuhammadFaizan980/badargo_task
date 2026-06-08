import 'package:badargo_task/data/clients/local/local_data_client.dart';
import 'package:badargo_task/data/local/db/app_database.dart';
import 'package:badargo_task/data/mappers/local_data_mapper.dart';

class MockLocalDbDataClient extends RemoteDataClient {
  final LocalDataMapper localDataMapper = LocalDataMapper();

  @override
  Future<String?> addNewEntry({required double lat, required double lng, required accuracy}) async => null;

  @override
  Future<List<LocationLocalTableData>?> getAllSavedEntries() async => [];

  @override
  Future<String?> removeEntry({required int id}) async => null;
}
