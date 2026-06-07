import 'package:badargo_task/data/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalData {
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  Future<void> clearLocalData() async => await _prefs.clear();

  Future<bool> getOrderStatus() async => await _prefs.getBool(AppConstants.orderInProgress) ?? false;

  Future<void> setOrderStatus({required bool status}) async =>
      await _prefs.setBool(AppConstants.orderInProgress, status);
}
