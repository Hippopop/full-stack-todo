import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/repository/repository.dart';
import 'package:todo_client/src/data/auth_provider/auth_repository_provider.dart';

import '../models/registration_model/registration_state.dart';

final registrationControllerProvider =
    AsyncNotifierProvider<RegistrationStateNotifier, RegistrationState>(
  RegistrationStateNotifier.new,
);

class RegistrationStateNotifier extends AsyncNotifier<RegistrationState> {
  late final RequestHandler _requestHandler = ref.read(requestHandlerProvider);
  late final AuthRepository _repository = ref.read(
    authRepositoryProvider(
      _requestHandler,
    ),
  );

  @override
  RegistrationState build() => const RegistrationState();

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

  void switchPasswordVisibility() {
    final currentState = state.requireValue;
    state = AsyncValue.data(currentState.copyWith(
      passwordVisibility: !currentState.passwordVisibility,
    ));
  }

  void setName(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      name: newState,
    ));
  }

  void setMail(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      email: newState,
    ));
  }

  void setImagePath(List<int> newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      imagePath: newState,
    ));
  }

  void setPhoneCode(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      phoneCode: newState,
    ));
  }

  void setPhoneNumber(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      phoneNumber: newState,
    ));
  }

  void setPassword(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      password: newState,
    ));
  }

  void setConfirmedPassword(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      confirmPassword: newState,
    ));
  }

  void attemptRegistration() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final currentValue = state.requireValue;
      final phoneNumber =
          "${currentValue.phoneCode}${currentValue.phoneNumber}";
      final res = await _repository.register(
        phone: phoneNumber,
        name: currentValue.name!,
        email: currentValue.email!,
        password: currentValue.password!,
        imageBytes: currentValue.imagePath,
      );
      if (res.isSuccess) {
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
