import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/repository/repository.dart';
import 'package:todo_client/src/data/auth_provider/auth_repository_provider.dart';
import 'package:todo_client/src/repository/server/source/config_provider.dart';
import 'package:todo_client/src/repository/storage/auth_repository/token_storage.dart';

import '../models/login_model/login_state.dart';

final loginControllerProvider =
    AsyncNotifierProvider<LoginStateNotifier, LoginState>(
  LoginStateNotifier.new,
  dependencies: const [],
);

class LoginStateNotifier extends AsyncNotifier<LoginState> {
  late final RequestHandler _requestHandler;
  late final AuthRepository _repository;

  @override
  LoginState build() {
    _requestHandler = ref.watch(requestHandlerProvider);
    _repository = ref.watch(authRepositoryProvider(_requestHandler));
    return const LoginState();
  }

  void removeMessage() {
    final currentState = state.requireValue;
    state = AsyncValue.data(currentState.copyWith(responseMsg: null));
  }

  void setResponseMsg({required String msg, int level = 0}) {
    final currentState = state.requireValue;
    state = AsyncValue.data(
      currentState.copyWith(
        responseMsg: (level: level, msg: msg),
      ),
    );
  }

  void switchRememberMe() {
    final currentState = state.requireValue;
    state = AsyncValue.data(currentState.copyWith(
      remember: !currentState.remember,
    ));
  }

  void setLoginMail(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      email: newState,
    ));
  }

  void setLoginPassword(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      password: newState,
    ));
  }

  void attemptLogin() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final currentValue = state.requireValue;
      final res = await _repository.login(
        email: currentValue.email!,
        password: currentValue.password!,
      );
      if (res.isSuccess) {
        ref.read(tokenStorageProvider).saveUserToken(res.data!.token);
        return currentValue.copyWith(
          authorized: true,
          responseMsg: (level: 1, msg: res.msg),
        );
      } else {
        return currentValue.copyWith(
          responseMsg: (
            level: res.status ?? 0,
            msg: res.error!.first.description
          ),
        );
      }
    });
  }
}
