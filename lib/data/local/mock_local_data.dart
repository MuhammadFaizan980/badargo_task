import 'package:badargo_task/data/local/local_data_dispatcher.dart';

class MockLocalData extends LocalDataDispatcher {
  @override
  Future<bool> clearLocalData() async => true;

  @override
  Future<bool> getOrderStatus() async => false;

  @override
  Future<bool> setOrderStatus({required bool status}) async => status;
}
