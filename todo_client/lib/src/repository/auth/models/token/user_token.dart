import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_token.freezed.dart';

part 'user_token.g.dart';

@freezed
class UserToken with _$UserToken {
  const factory UserToken({
    required int uid,
    required String uuid,
    required String email,
    String? name,
    String? phone,
    String? photo,
    String? birthdate,
  }) = _UserToken;

  factory UserToken.fromJson(Map<String, Object?> json) =>
      _$UserTokenFromJson(json);
}
