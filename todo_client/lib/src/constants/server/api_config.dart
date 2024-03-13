import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:todo_client/src/constants/server/api/env_config.dart';

abstract class APIConfig {
  static String get login => _getProperEnv(
        AndroidConfig.login,
        DevelopmentConfig.login,
        ProductionConfig.login,
      );
  static String get register => _getProperEnv(
        AndroidConfig.register,
        DevelopmentConfig.register,
        ProductionConfig.register,
      );
  static String get refresh => _getProperEnv(
        AndroidConfig.refresh,
        DevelopmentConfig.refresh,
        ProductionConfig.refresh,
      );
  static String get baseURl => _getProperEnv(
        AndroidConfig.baseURl,
        DevelopmentConfig.baseURl,
        ProductionConfig.baseURl,
      );
  static String get addTodo => _getProperEnv(
        AndroidConfig.addTodo,
        DevelopmentConfig.addTodo,
        ProductionConfig.addTodo,
      );
  static String get allTodo => _getProperEnv(
        AndroidConfig.allTodo,
        DevelopmentConfig.allTodo,
        ProductionConfig.allTodo,
      );
  static String get updateTodo => _getProperEnv(
        AndroidConfig.updateTodo,
        DevelopmentConfig.updateTodo,
        ProductionConfig.updateTodo,
      );
  static String get deleteTodo => _getProperEnv(
        AndroidConfig.deleteTodo,
        DevelopmentConfig.deleteTodo,
        ProductionConfig.deleteTodo,
      );
}

String _getProperEnv(String droid, String dev, String prod) {
  if (kDebugMode) {
    return (kIsWeb || !Platform.isAndroid) ? dev : droid;
  }
  return prod;
}
