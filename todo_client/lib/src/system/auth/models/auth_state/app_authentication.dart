import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_client/src/repository/repository.dart';

part 'app_authentication.freezed.dart';
part 'app_authentication.g.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    ({String accessToken, String refreshToken})? token,
    AppUser? currentUser,
  }) = _AuthenticationState;

  const AuthenticationState._();
  bool get isAuthenticated => token != null && currentUser != null;

  factory AuthenticationState.fromJson(Map<String, Object?> json) =>
      _$AuthenticationStateFromJson(json);
}
