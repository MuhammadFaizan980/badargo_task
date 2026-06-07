import 'package:badargo_task/services/location_service.dart';

class ServiceInitiator {
  static Future<void> initServices() async {
    await initializeLocationService();
  }
}
