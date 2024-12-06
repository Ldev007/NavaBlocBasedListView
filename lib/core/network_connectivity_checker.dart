import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:navalistview/core/connectivity_extension.dart';

class NetworkConnectivityChecker {
  static bool? _hasInternet;
  static bool? get hasInternet => _hasInternet;

  static startListeningToNetworkChanges() => Connectivity().onConnectivityChanged.listen((status) => _hasInternet = status.hasInternet);
}
