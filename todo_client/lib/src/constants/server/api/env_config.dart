import 'package:envied/envied.dart';

part 'env_config.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class AndroidConfig {
  @EnviedField(varName: 'LOGIN')
  static final String login = _AndroidConfig.login;
  @EnviedField(varName: 'REGISTER')
  static final String register = _AndroidConfig.register;
  @EnviedField(varName: 'REFRESH')
  static final String refresh = _AndroidConfig.refresh;
  @EnviedField(varName: 'BASE_URL')
  static final String baseURl = _AndroidConfig.baseURl;
  @EnviedField(varName: "ADD_TODO")
  static final String addTodo = _AndroidConfig.addTodo;
  @EnviedField(varName: "ALL_TODO")
  static final String allTodo = _AndroidConfig.allTodo;
  @EnviedField(varName: "UPDATE_TODO")
  static final String updateTodo = _AndroidConfig.updateTodo;
  @EnviedField(varName: "DELETE_TODO")
  static final String deleteTodo = _AndroidConfig.deleteTodo;
}

@Envied(path: '.env.dev', obfuscate: true)
abstract class DevelopmentConfig {
  @EnviedField(varName: 'LOGIN')
  static final String login = _DevelopmentConfig.login;
  @EnviedField(varName: 'REGISTER')
  static final String register = _DevelopmentConfig.register;
  @EnviedField(varName: 'REFRESH')
  static final String refresh = _DevelopmentConfig.refresh;
  @EnviedField(varName: 'BASE_URL')
  static final String baseURl = _DevelopmentConfig.baseURl;
  @EnviedField(varName: "ADD_TODO")
  static final String addTodo = _DevelopmentConfig.addTodo;
  @EnviedField(varName: "ALL_TODO")
  static final String allTodo = _DevelopmentConfig.allTodo;
  @EnviedField(varName: "UPDATE_TODO")
  static final String updateTodo = _DevelopmentConfig.updateTodo;
  @EnviedField(varName: "DELETE_TODO")
  static final String deleteTodo = _DevelopmentConfig.deleteTodo;
}

@Envied(path: '.env.prod', obfuscate: true)
abstract class ProductionConfig {
  @EnviedField(varName: 'LOGIN')
  static final String login = _ProductionConfig.login;
  @EnviedField(varName: 'REGISTER')
  static final String register = _ProductionConfig.register;
  @EnviedField(varName: 'REFRESH')
  static final String refresh = _ProductionConfig.refresh;
  @EnviedField(varName: 'BASE_URL')
  static final String baseURl = _ProductionConfig.baseURl;
  @EnviedField(varName: "ADD_TODO")
  static final String addTodo = _ProductionConfig.addTodo;
  @EnviedField(varName: "ALL_TODO")
  static final String allTodo = _ProductionConfig.allTodo;
  @EnviedField(varName: "UPDATE_TODO")
  static final String updateTodo = _ProductionConfig.updateTodo;
  @EnviedField(varName: "DELETE_TODO")
  static final String deleteTodo = _ProductionConfig.deleteTodo;
}
