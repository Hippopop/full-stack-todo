// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserToken _$UserTokenFromJson(Map<String, dynamic> json) {
  return _UserToken.fromJson(json);
}

/// @nodoc
mixin _$UserToken {
  int get uid => throw _privateConstructorUsedError;
  String get uuid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  String? get birthdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserTokenCopyWith<UserToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserTokenCopyWith<$Res> {
  factory $UserTokenCopyWith(UserToken value, $Res Function(UserToken) then) =
      _$UserTokenCopyWithImpl<$Res, UserToken>;
  @useResult
  $Res call(
      {int uid,
      String uuid,
      String email,
      String? name,
      String? phone,
      String? photo,
      String? birthdate});
}

/// @nodoc
class _$UserTokenCopyWithImpl<$Res, $Val extends UserToken>
    implements $UserTokenCopyWith<$Res> {
  _$UserTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? uuid = null,
    Object? email = null,
    Object? name = freezed,
    Object? phone = freezed,
    Object? photo = freezed,
    Object? birthdate = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as int,
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserTokenImplCopyWith<$Res>
    implements $UserTokenCopyWith<$Res> {
  factory _$$UserTokenImplCopyWith(
          _$UserTokenImpl value, $Res Function(_$UserTokenImpl) then) =
      __$$UserTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int uid,
      String uuid,
      String email,
      String? name,
      String? phone,
      String? photo,
      String? birthdate});
}

/// @nodoc
class __$$UserTokenImplCopyWithImpl<$Res>
    extends _$UserTokenCopyWithImpl<$Res, _$UserTokenImpl>
    implements _$$UserTokenImplCopyWith<$Res> {
  __$$UserTokenImplCopyWithImpl(
      _$UserTokenImpl _value, $Res Function(_$UserTokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? uuid = null,
    Object? email = null,
    Object? name = freezed,
    Object? phone = freezed,
    Object? photo = freezed,
    Object? birthdate = freezed,
  }) {
    return _then(_$UserTokenImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as int,
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserTokenImpl with DiagnosticableTreeMixin implements _UserToken {
  const _$UserTokenImpl(
      {required this.uid,
      required this.uuid,
      required this.email,
      this.name,
      this.phone,
      this.photo,
      this.birthdate});

  factory _$UserTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserTokenImplFromJson(json);

  @override
  final int uid;
  @override
  final String uuid;
  @override
  final String email;
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final String? photo;
  @override
  final String? birthdate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserToken(uid: $uid, uuid: $uuid, email: $email, name: $name, phone: $phone, photo: $photo, birthdate: $birthdate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserToken'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('photo', photo))
      ..add(DiagnosticsProperty('birthdate', birthdate));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserTokenImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, uuid, email, name, phone, photo, birthdate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserTokenImplCopyWith<_$UserTokenImpl> get copyWith =>
      __$$UserTokenImplCopyWithImpl<_$UserTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserTokenImplToJson(
      this,
    );
  }
}

abstract class _UserToken implements UserToken {
  const factory _UserToken(
      {required final int uid,
      required final String uuid,
      required final String email,
      final String? name,
      final String? phone,
      final String? photo,
      final String? birthdate}) = _$UserTokenImpl;

  factory _UserToken.fromJson(Map<String, dynamic> json) =
      _$UserTokenImpl.fromJson;

  @override
  int get uid;
  @override
  String get uuid;
  @override
  String get email;
  @override
  String? get name;
  @override
  String? get phone;
  @override
  String? get photo;
  @override
  String? get birthdate;
  @override
  @JsonKey(ignore: true)
  _$$UserTokenImplCopyWith<_$UserTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
