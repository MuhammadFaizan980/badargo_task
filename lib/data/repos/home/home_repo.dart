import 'package:badargo_task/data/app_base_repo.dart';
import 'package:badargo_task/data/local/local_data_dispatcher.dart';

abstract class HomeRepo extends AppBaseRepo {
  final LocalDataDispatcher appLocalData;

  HomeRepo(this.appLocalData);

  Future<bool> getOrderStatus();
  Future<bool> updateOrderStatus({required bool status});
  Future<bool> clearLocalData();
}
