// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthStateImpl _$$AuthStateImplFromJson(Map<String, dynamic> json) =>
    _$AuthStateImpl(
      loginState:
          LoginState.fromJson(json['loginState'] as Map<String, dynamic>),
      registrationState: RegistrationState.fromJson(
          json['registrationState'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthStateImplToJson(_$AuthStateImpl instance) =>
    <String, dynamic>{
      'loginState': instance.loginState,
      'registrationState': instance.registrationState,
    };
