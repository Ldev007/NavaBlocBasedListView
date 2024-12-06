import 'package:flutter/material.dart';
import 'package:navalistview/app.dart';
import 'package:navalistview/core/persistence/isar_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarDb.init();
  runApp(const NavaBlocBasedListView());
}
