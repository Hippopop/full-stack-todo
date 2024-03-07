import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_client/src/features/authentication/models/login_model/login_state.dart';
import 'package:todo_client/src/features/authentication/models/registration_model/registration_state.dart';

part 'auth_state.freezed.dart';

part 'auth_state.g.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required LoginState loginState,
    required RegistrationState registrationState,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, Object?> json) =>
      _$AuthStateFromJson(json);
}
