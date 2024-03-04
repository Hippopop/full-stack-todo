import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fresh_dio/fresh_dio.dart';

part 'user_token.freezed.dart';

part 'user_token.g.dart';

@freezed
class UserToken with _$UserToken {
  const factory UserToken({
    required String token,
    required String refreshToken,
  }) = _UserToken;

  const UserToken._();
  OAuth2Token get toOAuth2Token =>
      OAuth2Token(accessToken: token, refreshToken: refreshToken);

  factory UserToken.fromJson(Map<String, Object?> json) =>
      _$UserTokenFromJson(json);
}
