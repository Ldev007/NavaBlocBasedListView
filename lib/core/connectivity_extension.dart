import 'package:connectivity_plus/connectivity_plus.dart';

extension ConnectivityExtension on List<ConnectivityResult> {
  bool get hasInternet => !(contains(ConnectivityResult.none) || contains(ConnectivityResult.bluetooth));
}
