// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() checkAuthenticated,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? checkAuthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? checkAuthenticated,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthEventLogin value) login,
    required TResult Function(AuthEventLogout value) logout,
    required TResult Function(AuthEventCheckAuthenticated value)
        checkAuthenticated,
    required TResult Function(AuthEventAuthenticated value) authenticated,
    required TResult Function(AuthEventUnAuthenticated value) unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthEventLogin value)? login,
    TResult? Function(AuthEventLogout value)? logout,
    TResult? Function(AuthEventCheckAuthenticated value)? checkAuthenticated,
    TResult? Function(AuthEventAuthenticated value)? authenticated,
    TResult? Function(AuthEventUnAuthenticated value)? unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthEventLogin value)? login,
    TResult Function(AuthEventLogout value)? logout,
    TResult Function(AuthEventCheckAuthenticated value)? checkAuthenticated,
    TResult Function(AuthEventAuthenticated value)? authenticated,
    TResult Function(AuthEventUnAuthenticated value)? unauthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AuthEventLoginCopyWith<$Res> {
  factory _$$AuthEventLoginCopyWith(
          _$AuthEventLogin value, $Res Function(_$AuthEventLogin) then) =
      __$$AuthEventLoginCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthEventLoginCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthEventLogin>
    implements _$$AuthEventLoginCopyWith<$Res> {
  __$$AuthEventLoginCopyWithImpl(
      _$AuthEventLogin _value, $Res Function(_$AuthEventLogin) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthEventLogin implements AuthEventLogin {
  const _$AuthEventLogin();

  @override
  String toString() {
    return 'AuthEvent.login()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthEventLogin);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() checkAuthenticated,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
  }) {
    return login();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? checkAuthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
  }) {
    return login?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? checkAuthenticated,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthEventLogin value) login,
    required TResult Function(AuthEventLogout value) logout,
    required TResult Function(AuthEventCheckAuthenticated value)
        checkAuthenticated,
    required TResult Function(AuthEventAuthenticated value) authenticated,
    required TResult Function(AuthEventUnAuthenticated value) unauthenticated,
  }) {
    return login(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthEventLogin value)? login,
    TResult? Function(AuthEventLogout value)? logout,
    TResult? Function(AuthEventCheckAuthenticated value)? checkAuthenticated,
    TResult? Function(AuthEventAuthenticated value)? authenticated,
    TResult? Function(AuthEventUnAuthenticated value)? unauthenticated,
  }) {
    return login?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthEventLogin value)? login,
    TResult Function(AuthEventLogout value)? logout,
    TResult Function(AuthEventCheckAuthenticated value)? checkAuthenticated,
    TResult Function(AuthEventAuthenticated value)? authenticated,
    TResult Function(AuthEventUnAuthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(this);
    }
    return orElse();
  }
}

abstract class AuthEventLogin implements AuthEvent {
  const factory AuthEventLogin() = _$AuthEventLogin;
}

/// @nodoc
abstract class _$$AuthEventLogoutCopyWith<$Res> {
  factory _$$AuthEventLogoutCopyWith(
          _$AuthEventLogout value, $Res Function(_$AuthEventLogout) then) =
      __$$AuthEventLogoutCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthEventLogoutCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthEventLogout>
    implements _$$AuthEventLogoutCopyWith<$Res> {
  __$$AuthEventLogoutCopyWithImpl(
      _$AuthEventLogout _value, $Res Function(_$AuthEventLogout) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthEventLogout implements AuthEventLogout {
  const _$AuthEventLogout();

  @override
  String toString() {
    return 'AuthEvent.logout()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthEventLogout);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() checkAuthenticated,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
  }) {
    return logout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? checkAuthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
  }) {
    return logout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? checkAuthenticated,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthEventLogin value) login,
    required TResult Function(AuthEventLogout value) logout,
    required TResult Function(AuthEventCheckAuthenticated value)
        checkAuthenticated,
    required TResult Function(AuthEventAuthenticated value) authenticated,
    required TResult Function(AuthEventUnAuthenticated value) unauthenticated,
  }) {
    return logout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthEventLogin value)? login,
    TResult? Function(AuthEventLogout value)? logout,
    TResult? Function(AuthEventCheckAuthenticated value)? checkAuthenticated,
    TResult? Function(AuthEventAuthenticated value)? authenticated,
    TResult? Function(AuthEventUnAuthenticated value)? unauthenticated,
  }) {
    return logout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthEventLogin value)? login,
    TResult Function(AuthEventLogout value)? logout,
    TResult Function(AuthEventCheckAuthenticated value)? checkAuthenticated,
    TResult Function(AuthEventAuthenticated value)? authenticated,
    TResult Function(AuthEventUnAuthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout(this);
    }
    return orElse();
  }
}

abstract class AuthEventLogout implements AuthEvent {
  const factory AuthEventLogout() = _$AuthEventLogout;
}

/// @nodoc
abstract class _$$AuthEventCheckAuthenticatedCopyWith<$Res> {
  factory _$$AuthEventCheckAuthenticatedCopyWith(
          _$AuthEventCheckAuthenticated value,
          $Res Function(_$AuthEventCheckAuthenticated) then) =
      __$$AuthEventCheckAuthenticatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthEventCheckAuthenticatedCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthEventCheckAuthenticated>
    implements _$$AuthEventCheckAuthenticatedCopyWith<$Res> {
  __$$AuthEventCheckAuthenticatedCopyWithImpl(
      _$AuthEventCheckAuthenticated _value,
      $Res Function(_$AuthEventCheckAuthenticated) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthEventCheckAuthenticated implements AuthEventCheckAuthenticated {
  const _$AuthEventCheckAuthenticated();

  @override
  String toString() {
    return 'AuthEvent.checkAuthenticated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthEventCheckAuthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() checkAuthenticated,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
  }) {
    return checkAuthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? checkAuthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
  }) {
    return checkAuthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? checkAuthenticated,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    required TResult orElse(),
  }) {
    if (checkAuthenticated != null) {
      return checkAuthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthEventLogin value) login,
    required TResult Function(AuthEventLogout value) logout,
    required TResult Function(AuthEventCheckAuthenticated value)
        checkAuthenticated,
    required TResult Function(AuthEventAuthenticated value) authenticated,
    required TResult Function(AuthEventUnAuthenticated value) unauthenticated,
  }) {
    return checkAuthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthEventLogin value)? login,
    TResult? Function(AuthEventLogout value)? logout,
    TResult? Function(AuthEventCheckAuthenticated value)? checkAuthenticated,
    TResult? Function(AuthEventAuthenticated value)? authenticated,
    TResult? Function(AuthEventUnAuthenticated value)? unauthenticated,
  }) {
    return checkAuthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthEventLogin value)? login,
    TResult Function(AuthEventLogout value)? logout,
    TResult Function(AuthEventCheckAuthenticated value)? checkAuthenticated,
    TResult Function(AuthEventAuthenticated value)? authenticated,
    TResult Function(AuthEventUnAuthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (checkAuthenticated != null) {
      return checkAuthenticated(this);
    }
    return orElse();
  }
}

abstract class AuthEventCheckAuthenticated implements AuthEvent {
  const factory AuthEventCheckAuthenticated() = _$AuthEventCheckAuthenticated;
}

/// @nodoc
abstract class _$$AuthEventAuthenticatedCopyWith<$Res> {
  factory _$$AuthEventAuthenticatedCopyWith(_$AuthEventAuthenticated value,
          $Res Function(_$AuthEventAuthenticated) then) =
      __$$AuthEventAuthenticatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthEventAuthenticatedCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthEventAuthenticated>
    implements _$$AuthEventAuthenticatedCopyWith<$Res> {
  __$$AuthEventAuthenticatedCopyWithImpl(_$AuthEventAuthenticated _value,
      $Res Function(_$AuthEventAuthenticated) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthEventAuthenticated implements AuthEventAuthenticated {
  const _$AuthEventAuthenticated();

  @override
  String toString() {
    return 'AuthEvent.authenticated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthEventAuthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() checkAuthenticated,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
  }) {
    return authenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? checkAuthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
  }) {
    return authenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? checkAuthenticated,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthEventLogin value) login,
    required TResult Function(AuthEventLogout value) logout,
    required TResult Function(AuthEventCheckAuthenticated value)
        checkAuthenticated,
    required TResult Function(AuthEventAuthenticated value) authenticated,
    required TResult Function(AuthEventUnAuthenticated value) unauthenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthEventLogin value)? login,
    TResult? Function(AuthEventLogout value)? logout,
    TResult? Function(AuthEventCheckAuthenticated value)? checkAuthenticated,
    TResult? Function(AuthEventAuthenticated value)? authenticated,
    TResult? Function(AuthEventUnAuthenticated value)? unauthenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthEventLogin value)? login,
    TResult Function(AuthEventLogout value)? logout,
    TResult Function(AuthEventCheckAuthenticated value)? checkAuthenticated,
    TResult Function(AuthEventAuthenticated value)? authenticated,
    TResult Function(AuthEventUnAuthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthEventAuthenticated implements AuthEvent {
  const factory AuthEventAuthenticated() = _$AuthEventAuthenticated;
}

/// @nodoc
abstract class _$$AuthEventUnAuthenticatedCopyWith<$Res> {
  factory _$$AuthEventUnAuthenticatedCopyWith(_$AuthEventUnAuthenticated value,
          $Res Function(_$AuthEventUnAuthenticated) then) =
      __$$AuthEventUnAuthenticatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthEventUnAuthenticatedCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthEventUnAuthenticated>
    implements _$$AuthEventUnAuthenticatedCopyWith<$Res> {
  __$$AuthEventUnAuthenticatedCopyWithImpl(_$AuthEventUnAuthenticated _value,
      $Res Function(_$AuthEventUnAuthenticated) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthEventUnAuthenticated implements AuthEventUnAuthenticated {
  const _$AuthEventUnAuthenticated();

  @override
  String toString() {
    return 'AuthEvent.unauthenticated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthEventUnAuthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() login,
    required TResult Function() logout,
    required TResult Function() checkAuthenticated,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? login,
    TResult? Function()? logout,
    TResult? Function()? checkAuthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? login,
    TResult Function()? logout,
    TResult Function()? checkAuthenticated,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthEventLogin value) login,
    required TResult Function(AuthEventLogout value) logout,
    required TResult Function(AuthEventCheckAuthenticated value)
        checkAuthenticated,
    required TResult Function(AuthEventAuthenticated value) authenticated,
    required TResult Function(AuthEventUnAuthenticated value) unauthenticated,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthEventLogin value)? login,
    TResult? Function(AuthEventLogout value)? logout,
    TResult? Function(AuthEventCheckAuthenticated value)? checkAuthenticated,
    TResult? Function(AuthEventAuthenticated value)? authenticated,
    TResult? Function(AuthEventUnAuthenticated value)? unauthenticated,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthEventLogin value)? login,
    TResult Function(AuthEventLogout value)? logout,
    TResult Function(AuthEventCheckAuthenticated value)? checkAuthenticated,
    TResult Function(AuthEventAuthenticated value)? authenticated,
    TResult Function(AuthEventUnAuthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class AuthEventUnAuthenticated implements AuthEvent {
  const factory AuthEventUnAuthenticated() = _$AuthEventUnAuthenticated;
}

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(bool isChecking) unauthenticated,
    required TResult Function(AuthSession authSession) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function(bool isChecking)? unauthenticated,
    TResult? Function(AuthSession authSession)? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(bool isChecking)? unauthenticated,
    TResult Function(AuthSession authSession)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateUnknown value) unknown,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateAuthenticated value) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateUnknown value)? unknown,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateUnknown value)? unknown,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AuthStateUnknownCopyWith<$Res> {
  factory _$$AuthStateUnknownCopyWith(
          _$AuthStateUnknown value, $Res Function(_$AuthStateUnknown) then) =
      __$$AuthStateUnknownCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthStateUnknownCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateUnknown>
    implements _$$AuthStateUnknownCopyWith<$Res> {
  __$$AuthStateUnknownCopyWithImpl(
      _$AuthStateUnknown _value, $Res Function(_$AuthStateUnknown) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthStateUnknown implements AuthStateUnknown {
  const _$AuthStateUnknown();

  @override
  String toString() {
    return 'AuthState.unknown()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthStateUnknown);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(bool isChecking) unauthenticated,
    required TResult Function(AuthSession authSession) authenticated,
  }) {
    return unknown();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function(bool isChecking)? unauthenticated,
    TResult? Function(AuthSession authSession)? authenticated,
  }) {
    return unknown?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(bool isChecking)? unauthenticated,
    TResult Function(AuthSession authSession)? authenticated,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateUnknown value) unknown,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateAuthenticated value) authenticated,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateUnknown value)? unknown,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateUnknown value)? unknown,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class AuthStateUnknown implements AuthState {
  const factory AuthStateUnknown() = _$AuthStateUnknown;
}

/// @nodoc
abstract class _$$AuthStateUnauthenticatedCopyWith<$Res> {
  factory _$$AuthStateUnauthenticatedCopyWith(_$AuthStateUnauthenticated value,
          $Res Function(_$AuthStateUnauthenticated) then) =
      __$$AuthStateUnauthenticatedCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isChecking});
}

/// @nodoc
class __$$AuthStateUnauthenticatedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateUnauthenticated>
    implements _$$AuthStateUnauthenticatedCopyWith<$Res> {
  __$$AuthStateUnauthenticatedCopyWithImpl(_$AuthStateUnauthenticated _value,
      $Res Function(_$AuthStateUnauthenticated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isChecking = null,
  }) {
    return _then(_$AuthStateUnauthenticated(
      isChecking: null == isChecking
          ? _value.isChecking
          : isChecking // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AuthStateUnauthenticated implements AuthStateUnauthenticated {
  const _$AuthStateUnauthenticated({required this.isChecking});

  @override
  final bool isChecking;

  @override
  String toString() {
    return 'AuthState.unauthenticated(isChecking: $isChecking)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateUnauthenticated &&
            (identical(other.isChecking, isChecking) ||
                other.isChecking == isChecking));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isChecking);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateUnauthenticatedCopyWith<_$AuthStateUnauthenticated>
      get copyWith =>
          __$$AuthStateUnauthenticatedCopyWithImpl<_$AuthStateUnauthenticated>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(bool isChecking) unauthenticated,
    required TResult Function(AuthSession authSession) authenticated,
  }) {
    return unauthenticated(isChecking);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function(bool isChecking)? unauthenticated,
    TResult? Function(AuthSession authSession)? authenticated,
  }) {
    return unauthenticated?.call(isChecking);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(bool isChecking)? unauthenticated,
    TResult Function(AuthSession authSession)? authenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(isChecking);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateUnknown value) unknown,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateAuthenticated value) authenticated,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateUnknown value)? unknown,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateUnknown value)? unknown,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class AuthStateUnauthenticated implements AuthState {
  const factory AuthStateUnauthenticated({required final bool isChecking}) =
      _$AuthStateUnauthenticated;

  bool get isChecking;
  @JsonKey(ignore: true)
  _$$AuthStateUnauthenticatedCopyWith<_$AuthStateUnauthenticated>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthStateAuthenticatedCopyWith<$Res> {
  factory _$$AuthStateAuthenticatedCopyWith(_$AuthStateAuthenticated value,
          $Res Function(_$AuthStateAuthenticated) then) =
      __$$AuthStateAuthenticatedCopyWithImpl<$Res>;
  @useResult
  $Res call({AuthSession authSession});
}

/// @nodoc
class __$$AuthStateAuthenticatedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateAuthenticated>
    implements _$$AuthStateAuthenticatedCopyWith<$Res> {
  __$$AuthStateAuthenticatedCopyWithImpl(_$AuthStateAuthenticated _value,
      $Res Function(_$AuthStateAuthenticated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authSession = null,
  }) {
    return _then(_$AuthStateAuthenticated(
      authSession: null == authSession
          ? _value.authSession
          : authSession // ignore: cast_nullable_to_non_nullable
              as AuthSession,
    ));
  }
}

/// @nodoc

class _$AuthStateAuthenticated implements AuthStateAuthenticated {
  const _$AuthStateAuthenticated({required this.authSession});

  @override
  final AuthSession authSession;

  @override
  String toString() {
    return 'AuthState.authenticated(authSession: $authSession)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateAuthenticated &&
            (identical(other.authSession, authSession) ||
                other.authSession == authSession));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authSession);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateAuthenticatedCopyWith<_$AuthStateAuthenticated> get copyWith =>
      __$$AuthStateAuthenticatedCopyWithImpl<_$AuthStateAuthenticated>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(bool isChecking) unauthenticated,
    required TResult Function(AuthSession authSession) authenticated,
  }) {
    return authenticated(authSession);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function(bool isChecking)? unauthenticated,
    TResult? Function(AuthSession authSession)? authenticated,
  }) {
    return authenticated?.call(authSession);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(bool isChecking)? unauthenticated,
    TResult Function(AuthSession authSession)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(authSession);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateUnknown value) unknown,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateAuthenticated value) authenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateUnknown value)? unknown,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateUnknown value)? unknown,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthStateAuthenticated implements AuthState {
  const factory AuthStateAuthenticated(
      {required final AuthSession authSession}) = _$AuthStateAuthenticated;

  AuthSession get authSession;
  @JsonKey(ignore: true)
  _$$AuthStateAuthenticatedCopyWith<_$AuthStateAuthenticated> get copyWith =>
      throw _privateConstructorUsedError;
}
