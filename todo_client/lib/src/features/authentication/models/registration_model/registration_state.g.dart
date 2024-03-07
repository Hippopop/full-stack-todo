// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegistrationStateImpl _$$RegistrationStateImplFromJson(
        Map<String, dynamic> json) =>
    _$RegistrationStateImpl(
      name: json['name'] as String? ?? "",
      email: json['email'] as String? ?? "",
      phone: json['phone'] as String? ?? "",
      password: json['password'] as String? ?? "",
      confirmPassword: json['confirmPassword'] as String? ?? "",
    );

Map<String, dynamic> _$$RegistrationStateImplToJson(
        _$RegistrationStateImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };
