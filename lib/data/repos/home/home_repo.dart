import 'package:badargo_task/data/app_base_repo.dart';

abstract class HomeRepo extends AppBaseRepo {
  Future<void> acceptOrder();
  Future<void> cancelOrder();
}
