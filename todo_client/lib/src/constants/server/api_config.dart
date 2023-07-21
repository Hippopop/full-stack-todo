//! This was an attempt of getting `Dart` environment variables from file!
//! But for some weird reason, they don't seem to work inside a function!
//! After struggling a lot I still couldn't found the actual isse.
//! So started using `Envied` package.

/* part of 'server_env_config.dart';

class APIConfig {
  static String get baseUrl => _getEnvString(_baseUrlKey);

  static String get addTodo => _getEnvString(_addTodoKey);

  static String get updateTodo => _getEnvString(_updateTodoKey);

  static String get deleteTodo => _getEnvString(_deleteTodoKey);

  static String get allTodo => _getEnvString(_allTodoKey);
}
 */