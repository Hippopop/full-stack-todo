import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required int uid,
    required String uuid,
    required String email,
    required String name,
    required String phone,
    String? photo,
    String? birthdate,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, Object?> json) =>
      _$AppUserFromJson(json);
}
