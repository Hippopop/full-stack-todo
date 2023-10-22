// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserToken _$$_UserTokenFromJson(Map<String, dynamic> json) => _$_UserToken(
      uid: json['uid'] as int,
      uuid: json['uuid'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      birthdate: json['birthdate'] as String?,
    );

Map<String, dynamic> _$$_UserTokenToJson(_$_UserToken instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'uuid': instance.uuid,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'photo': instance.photo,
      'birthdate': instance.birthdate,
    };
