abstract class LocalDataDispatcher {
  Future<bool> clearLocalData();

  Future<bool> getOrderStatus();

  Future<bool> setOrderStatus({required bool status});
}
