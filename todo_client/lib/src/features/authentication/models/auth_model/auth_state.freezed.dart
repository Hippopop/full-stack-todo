// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthState _$AuthStateFromJson(Map<String, dynamic> json) {
  return _AuthState.fromJson(json);
}

/// @nodoc
mixin _$AuthState {
  LoginState get loginState => throw _privateConstructorUsedError;
  RegistrationState get registrationState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call({LoginState loginState, RegistrationState registrationState});

  $LoginStateCopyWith<$Res> get loginState;
  $RegistrationStateCopyWith<$Res> get registrationState;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loginState = null,
    Object? registrationState = null,
  }) {
    return _then(_value.copyWith(
      loginState: null == loginState
          ? _value.loginState
          : loginState // ignore: cast_nullable_to_non_nullable
              as LoginState,
      registrationState: null == registrationState
          ? _value.registrationState
          : registrationState // ignore: cast_nullable_to_non_nullable
              as RegistrationState,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LoginStateCopyWith<$Res> get loginState {
    return $LoginStateCopyWith<$Res>(_value.loginState, (value) {
      return _then(_value.copyWith(loginState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RegistrationStateCopyWith<$Res> get registrationState {
    return $RegistrationStateCopyWith<$Res>(_value.registrationState, (value) {
      return _then(_value.copyWith(registrationState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
          _$AuthStateImpl value, $Res Function(_$AuthStateImpl) then) =
      __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LoginState loginState, RegistrationState registrationState});

  @override
  $LoginStateCopyWith<$Res> get loginState;
  @override
  $RegistrationStateCopyWith<$Res> get registrationState;
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
      _$AuthStateImpl _value, $Res Function(_$AuthStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loginState = null,
    Object? registrationState = null,
  }) {
    return _then(_$AuthStateImpl(
      loginState: null == loginState
          ? _value.loginState
          : loginState // ignore: cast_nullable_to_non_nullable
              as LoginState,
      registrationState: null == registrationState
          ? _value.registrationState
          : registrationState // ignore: cast_nullable_to_non_nullable
              as RegistrationState,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthStateImpl with DiagnosticableTreeMixin implements _AuthState {
  const _$AuthStateImpl(
      {required this.loginState, required this.registrationState});

  factory _$AuthStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthStateImplFromJson(json);

  @override
  final LoginState loginState;
  @override
  final RegistrationState registrationState;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState(loginState: $loginState, registrationState: $registrationState)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState'))
      ..add(DiagnosticsProperty('loginState', loginState))
      ..add(DiagnosticsProperty('registrationState', registrationState));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.loginState, loginState) ||
                other.loginState == loginState) &&
            (identical(other.registrationState, registrationState) ||
                other.registrationState == registrationState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, loginState, registrationState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthStateImplToJson(
      this,
    );
  }
}

abstract class _AuthState implements AuthState {
  const factory _AuthState(
      {required final LoginState loginState,
      required final RegistrationState registrationState}) = _$AuthStateImpl;

  factory _AuthState.fromJson(Map<String, dynamic> json) =
      _$AuthStateImpl.fromJson;

  @override
  LoginState get loginState;
  @override
  RegistrationState get registrationState;
  @override
  @JsonKey(ignore: true)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
