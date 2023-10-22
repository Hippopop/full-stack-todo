// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      uid: json['uid'] as int,
      uuid: json['uuid'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      birthdate: json['birthdate'] as String?,
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'uuid': instance.uuid,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'photo': instance.photo,
      'birthdate': instance.birthdate,
    };
