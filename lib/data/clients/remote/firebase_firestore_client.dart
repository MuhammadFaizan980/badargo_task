import 'package:badargo_task/data/clients/remote/remote_data_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreClient extends RemoteDataClient {
  @override
  Future<String?> saveLocationEntry({
    required double lat,
    required double lng,
    required double accuracy,
    required int timestamp,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('drivers_location_logs').add({
        'latitude': lat,
        'longitude': lng,
        'accuracy': accuracy,
        'timestamp': timestamp,
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
