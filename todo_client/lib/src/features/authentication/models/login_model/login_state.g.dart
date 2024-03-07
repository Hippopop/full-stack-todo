// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginStateImpl _$$LoginStateImplFromJson(Map<String, dynamic> json) =>
    _$LoginStateImpl(
      email: json['email'] as String?,
      password: json['password'] as String?,
      remember: json['remember'] as bool? ?? false,
      authorized: json['authorized'] as bool? ?? false,
      responseMsg: _$recordConvertNullable(
        json['responseMsg'],
        ($jsonValue) => (
          level: $jsonValue['level'] as int,
          msg: $jsonValue['msg'] as String,
        ),
      ),
      passwordVisibility: json['passwordVisibility'] as bool? ?? false,
    );

Map<String, dynamic> _$$LoginStateImplToJson(_$LoginStateImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'remember': instance.remember,
      'authorized': instance.authorized,
      'responseMsg': instance.responseMsg == null
          ? null
          : {
              'level': instance.responseMsg!.level,
              'msg': instance.responseMsg!.msg,
            },
      'passwordVisibility': instance.passwordVisibility,
    };

$Rec? _$recordConvertNullable<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    value == null ? null : convert(value as Map<String, dynamic>);
