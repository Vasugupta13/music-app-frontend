



import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityStatusProviders = StateNotifierProvider<ConnectivityStatusNotifier,bool>((ref) {
  return ConnectivityStatusNotifier();
});
class ConnectivityStatusNotifier extends StateNotifier<bool> {
  ConnectivityStatusNotifier() : super(true) {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile)) {
        state = true;
      } else if (result.contains(ConnectivityResult.wifi)) {
        state = true;
      } else if (result.contains(ConnectivityResult.ethernet)) {
        state = true;
      }
      else{
        state = false;
      }
    });
  }
}
