import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    String? email,
    String? password,
    @Default(false) bool remember,
    @Default(false) bool authorized,
    ({int level, String msg})? responseMsg,
    @Default(false) bool passwordVisibility,
  }) = _LoginState;
}
