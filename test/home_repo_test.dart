import 'package:badargo_task/data/local/mock_local_data.dart';
import 'package:badargo_task/data/repos/home/home_repo.dart';
import 'package:badargo_task/data/repos/home/home_repo_imp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Home Repo Tests', () {
    HomeRepo homeRepo = HomeRepoImp(MockLocalData());

    test('Get order status test', () async {
      bool status = await homeRepo.getOrderStatus();
      expect(status, false);
    });

    test('Update order status test', () async {
      bool status = await homeRepo.updateOrderStatus(status: true);
      expect(status, true);
    });

    test('Clear order status test', () async {
      bool status = await homeRepo.clearLocalData();
      expect(status, true);
    });
  });
}
