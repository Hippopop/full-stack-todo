import 'package:envied/envied.dart';

part 'api_config.g.dart';

@Envied(path: './.env.dev', obfuscate: true)
abstract class APIConfig {
  @EnviedField(varName: 'LOGIN')
  static final String login = _APIConfig.login;
  @EnviedField(varName: 'REGISTER')
  static final String register = _APIConfig.register;
  @EnviedField(varName: 'REFRESH')
  static final String refresh = _APIConfig.refresh;
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
