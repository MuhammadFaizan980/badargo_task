import 'home_repo.dart';

class HomeRepoImpHomeRepo extends HomeRepo {
  @override
  Future<bool> getOrderStatus() async => await appLocalData.getOrderStatus();

  @override
  Future<void> updateOrderStatus({required bool status}) async =>
      await appLocalData.setOrderStatus(status: status);
}
