import 'home_repo.dart';

class HomeRepoImpHomeRepo extends HomeRepo {
  @override
  Future<void> acceptOrder() async => await appLocalData.setOrderStatus(status: true);

  @override
  Future<void> cancelOrder() async => await appLocalData.setOrderStatus(status: false);
}
