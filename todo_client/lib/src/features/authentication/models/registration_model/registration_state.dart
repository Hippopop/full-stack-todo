import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_state.freezed.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    String? name,
    String? email,
    String? password,
    ({String imageName, List<int> imageData})? imagePath,
    String? phoneNumber,
    String? confirmPassword,
    @Default(false) bool authorized,
    @Default("+880") String phoneCode,
    ({int level, String msg})? responseMsg,
    @Default(false) bool passwordVisibility,
  }) = _RegistrationState;
}
