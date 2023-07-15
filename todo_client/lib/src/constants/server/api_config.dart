part of 'server_env_config.dart';

class APIConfig {
  static String get baseUrl => _getEnvString(_baseUrlKey);

  static String get addTodo => _getEnvString(_addTodoKey);

  static String get updateTodo => _getEnvString(_updateTodoKey);

  static String get deleteTodo => _getEnvString(_deleteTodoKey);

  static String get allTodo => _getEnvString(_allTodoKey);
}
