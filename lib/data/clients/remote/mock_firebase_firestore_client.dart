import 'package:badargo_task/data/clients/remote/remote_data_client.dart';

class MockFirebaseFirestoreClient extends RemoteDataClient {
  @override
  Future<String?> saveLocationEntry({
    required double lat,
    required double lng,
    required double accuracy,
    required int timestamp,
  }) async => null;
}
