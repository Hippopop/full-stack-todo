import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_state.freezed.dart';

part 'registration_state.g.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    @Default("") String name,
    @Default("") String email,
    @Default("") String phone,
    @Default("") String password,
    @Default("") String confirmPassword,
  }) = _RegistrationState;

  factory RegistrationState.fromJson(Map<String, Object?> json) =>
      _$RegistrationStateFromJson(json);
}
