import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/data/auth_provider/auth_provider.dart';
import 'package:todo_client/src/features/authentication/models/auth_model/auth_state.dart';
import 'package:todo_client/src/features/authentication/models/login_model/login_state.dart';
import 'package:todo_client/src/features/authentication/models/registration_model/registration_state.dart';
import 'package:todo_client/src/repository/repository.dart';

final authControllerProvider =
    NotifierProvider<AuthenticationNotifier, AuthState>(
        AuthenticationNotifier.new);

class AuthenticationNotifier extends Notifier<AuthState> {
  RequestHandler get _handler => ref.watch(requestHandlerProvider);
  AuthRepository get _provider => ref.watch(authRepositoryProvider(_handler));

  @override
  AuthState build() {
    return const AuthState(
      loginState: LoginState(),
      registrationState: RegistrationState(),
    );
  }

  switchRememberMe() {
    state = state.copyWith(
      loginState: state.loginState.copyWith(
        remember: !state.loginState.remember,
      ),
    );
  }

  setLoginMail(String newState) {
    state = state.copyWith(
      loginState: state.loginState.copyWith(
        email: newState,
      ),
    );
  }

  setLoginPassword(String newState) {
    state = state.copyWith(
      loginState: state.loginState.copyWith(
        password: newState,
      ),
    );
  }

  Future<(bool status, String msg)> attemptLogin() async {
    try {
      final res = await _provider.login(
        email: state.loginState.email,
        password: state.loginState.password,
      );
      if (res.isSuccess) {
        log("Login Response : ${res.data?.toJson()}");
      } else {
        log("Login Response : ${res.toMap()}");
      }
      return (res.isSuccess, res.msg);
    } catch (e, s) {
      log("#LoginError", error: e, stackTrace: s);
      if (e is RequestException) return (false, e.msg ?? "");
      return (false, "Unknown Error!");
    }
  }
}
