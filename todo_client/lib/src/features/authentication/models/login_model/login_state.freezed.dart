// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginState {
  String? get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  bool get remember => throw _privateConstructorUsedError;
  bool get authorized => throw _privateConstructorUsedError;
  ({int level, String msg})? get responseMsg =>
      throw _privateConstructorUsedError;
  bool get passwordVisibility => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {String? email,
      String? password,
      bool remember,
      bool authorized,
      ({int level, String msg})? responseMsg,
      bool passwordVisibility});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? remember = null,
    Object? authorized = null,
    Object? responseMsg = freezed,
    Object? passwordVisibility = null,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      remember: null == remember
          ? _value.remember
          : remember // ignore: cast_nullable_to_non_nullable
              as bool,
      authorized: null == authorized
          ? _value.authorized
          : authorized // ignore: cast_nullable_to_non_nullable
              as bool,
      responseMsg: freezed == responseMsg
          ? _value.responseMsg
          : responseMsg // ignore: cast_nullable_to_non_nullable
              as ({int level, String msg})?,
      passwordVisibility: null == passwordVisibility
          ? _value.passwordVisibility
          : passwordVisibility // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginStateImplCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(
          _$LoginStateImpl value, $Res Function(_$LoginStateImpl) then) =
      __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? email,
      String? password,
      bool remember,
      bool authorized,
      ({int level, String msg})? responseMsg,
      bool passwordVisibility});
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl>
    implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(
      _$LoginStateImpl _value, $Res Function(_$LoginStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? remember = null,
    Object? authorized = null,
    Object? responseMsg = freezed,
    Object? passwordVisibility = null,
  }) {
    return _then(_$LoginStateImpl(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      remember: null == remember
          ? _value.remember
          : remember // ignore: cast_nullable_to_non_nullable
              as bool,
      authorized: null == authorized
          ? _value.authorized
          : authorized // ignore: cast_nullable_to_non_nullable
              as bool,
      responseMsg: freezed == responseMsg
          ? _value.responseMsg
          : responseMsg // ignore: cast_nullable_to_non_nullable
              as ({int level, String msg})?,
      passwordVisibility: null == passwordVisibility
          ? _value.passwordVisibility
          : passwordVisibility // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoginStateImpl with DiagnosticableTreeMixin implements _LoginState {
  const _$LoginStateImpl(
      {this.email,
      this.password,
      this.remember = false,
      this.authorized = false,
      this.responseMsg,
      this.passwordVisibility = false});

  @override
  final String? email;
  @override
  final String? password;
  @override
  @JsonKey()
  final bool remember;
  @override
  @JsonKey()
  final bool authorized;
  @override
  final ({int level, String msg})? responseMsg;
  @override
  @JsonKey()
  final bool passwordVisibility;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginState(email: $email, password: $password, remember: $remember, authorized: $authorized, responseMsg: $responseMsg, passwordVisibility: $passwordVisibility)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LoginState'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('remember', remember))
      ..add(DiagnosticsProperty('authorized', authorized))
      ..add(DiagnosticsProperty('responseMsg', responseMsg))
      ..add(DiagnosticsProperty('passwordVisibility', passwordVisibility));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStateImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.remember, remember) ||
                other.remember == remember) &&
            (identical(other.authorized, authorized) ||
                other.authorized == authorized) &&
            (identical(other.responseMsg, responseMsg) ||
                other.responseMsg == responseMsg) &&
            (identical(other.passwordVisibility, passwordVisibility) ||
                other.passwordVisibility == passwordVisibility));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password, remember,
      authorized, responseMsg, passwordVisibility);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);
}

abstract class _LoginState implements LoginState {
  const factory _LoginState(
      {final String? email,
      final String? password,
      final bool remember,
      final bool authorized,
      final ({int level, String msg})? responseMsg,
      final bool passwordVisibility}) = _$LoginStateImpl;

  @override
  String? get email;
  @override
  String? get password;
  @override
  bool get remember;
  @override
  bool get authorized;
  @override
  ({int level, String msg})? get responseMsg;
  @override
  bool get passwordVisibility;
  @override
  @JsonKey(ignore: true)
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
