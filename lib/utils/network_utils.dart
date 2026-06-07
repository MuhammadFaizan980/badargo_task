import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  Future<bool> hasInternetConnection() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    return connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi);
  }

  StreamSubscription initConnectivityStream({
    required Function(List<ConnectivityResult> result) onConnectivityChanged,
  }) {
    return Connectivity().onConnectivityChanged.listen((result) {
      onConnectivityChanged(result);
    });
  }
}
