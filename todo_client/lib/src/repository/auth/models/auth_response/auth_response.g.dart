// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthResponse _$$_AuthResponseFromJson(Map<String, dynamic> json) =>
    _$_AuthResponse(
      uid: json['uid'] as int,
      uuid: json['uuid'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      birthdate: json['birthdate'] as String?,
    );

Map<String, dynamic> _$$_AuthResponseToJson(_$_AuthResponse instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'uuid': instance.uuid,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'photo': instance.photo,
      'birthdate': instance.birthdate,
    };
