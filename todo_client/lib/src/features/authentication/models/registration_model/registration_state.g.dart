// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegistrationStateImpl _$$RegistrationStateImplFromJson(
        Map<String, dynamic> json) =>
    _$RegistrationStateImpl(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      imagePath: json['imagePath'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
      authorized: json['authorized'] as bool? ?? false,
      phoneCode: json['phoneCode'] as String? ?? "+880",
      responseMsg: _$recordConvertNullable(
        json['responseMsg'],
        ($jsonValue) => (
          level: $jsonValue['level'] as int,
          msg: $jsonValue['msg'] as String,
        ),
      ),
      passwordVisibility: json['passwordVisibility'] as bool? ?? false,
    );

Map<String, dynamic> _$$RegistrationStateImplToJson(
        _$RegistrationStateImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'imagePath': instance.imagePath,
      'phoneNumber': instance.phoneNumber,
      'confirmPassword': instance.confirmPassword,
      'authorized': instance.authorized,
      'phoneCode': instance.phoneCode,
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
