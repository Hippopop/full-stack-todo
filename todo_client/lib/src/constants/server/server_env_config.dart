/* part './api_config.dart';

/* BaseURL Key */
const _baseUrlKey = 'BASE_URL';

/* Endpoint Keys */
const _allTodoKey = 'ALL_TODO';
const _addTodoKey = 'ADD_TODO';
const _updateTodoKey = 'UPDATE_TODO';
const _deleteTodoKey = 'DELETE_TODO';

/// Checks if the value exists and returns
/// the `String` environment data.
String _getEnvString(String key) {
  final hasData = bool.hasEnvironment(key);
  if (hasData) return String.fromEnvironment(key);
  throw Exception(
    'CONFIG_DATA DOES NOT EXIST! (#KEY => $key)',
  );
}
 */