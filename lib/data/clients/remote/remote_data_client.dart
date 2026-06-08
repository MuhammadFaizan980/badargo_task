abstract class RemoteDataClient {
  Future<String?> saveLocationEntry({
    required double lat,
    required double lng,
    required double accuracy,
    required int timestamp,
  });
}
