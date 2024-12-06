import 'package:flutter/material.dart';
import 'package:navalistview/app.dart';
import 'package:navalistview/core/network_connectivity_checker.dart';
import 'package:navalistview/core/persistence/isar_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarDb.init();
  NetworkConnectivityChecker.startListeningToNetworkChanges();
  runApp(const NavaBlocBasedListView());
}
