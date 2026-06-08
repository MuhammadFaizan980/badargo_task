import 'package:badargo_task/data/constants/app_constants.dart';
import 'package:badargo_task/data/local/local_data_dispatcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalData extends LocalDataDispatcher {
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  @override
  Future<bool> clearLocalData() async {
    try {
      await _prefs.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> getOrderStatus() async => await _prefs.getBool(AppConstants.orderInProgress) ?? false;

  @override
  Future<bool> setOrderStatus({required bool status}) async {
    try {
      await _prefs.setBool(AppConstants.orderInProgress, status);
      return true;
    } catch (e) {
      return false;
    }
  }
}
