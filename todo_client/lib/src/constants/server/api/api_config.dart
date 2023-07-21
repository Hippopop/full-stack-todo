import 'package:envied/envied.dart';

part 'api_config.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class APIConfig {
  @EnviedField(varName: 'BASE_URL')
  static final String baseURl = _APIConfig.baseURl;
  @EnviedField(varName: "ADD_TODO")
  static final String addTodo = _APIConfig.addTodo;
  @EnviedField(varName: "ALL_TODO")
  static final String allTodo = _APIConfig.allTodo;
  @EnviedField(varName: "UPDATE_TODO")
  static final String updateTodo = _APIConfig.updateTodo;
  @EnviedField(varName: "DELETE_TODO")
  static final String deleteTodo = _APIConfig.deleteTodo;
}
