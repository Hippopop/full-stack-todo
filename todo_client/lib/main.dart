import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/repository/storage/source/hive_config.dart';

import 'src/my_app.dart';

void main() async {
  await HiveConfig.initialize();
  runApp(const ProviderScope(child: MyApp()));
}
