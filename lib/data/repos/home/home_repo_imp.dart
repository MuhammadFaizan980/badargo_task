import 'home_repo.dart';

class HomeRepoImp extends HomeRepo {
  HomeRepoImp(super.appLocalData);

  @override
  Future<bool> getOrderStatus() async => await appLocalData.getOrderStatus();

  @override
  Future<bool> updateOrderStatus({required bool status}) async =>
      await appLocalData.setOrderStatus(status: status);

  @override
  Future<bool> clearLocalData() async => await appLocalData.clearLocalData();
}
