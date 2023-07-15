part './api_config.dart';

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
  return <String, String>{
    "ADD_TODO": "/todos/add",
    "ALL_TODO": "/todos/all",
    "UPDATE_TODO": "/todos/update",
    "DELETE_TODO": "/todos/delete",
    "BASE_URL": "https://full-stack-todo-vxb8.onrender.com"
  }[key]!;
  /* throw Exception(
    'CONFIG_DATA DOES NOT EXIST! (#KEY => $key, #CHECK => $hasData)',
  ); */
}
