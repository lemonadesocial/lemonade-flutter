// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserProfileEvent {
  String? get userId => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? userId, String? username) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? userId, String? username)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? userId, String? username)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserProfileEventFetch value) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserProfileEventFetch value)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserProfileEventFetch value)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserProfileEventCopyWith<UserProfileEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileEventCopyWith<$Res> {
  factory $UserProfileEventCopyWith(
          UserProfileEvent value, $Res Function(UserProfileEvent) then) =
      _$UserProfileEventCopyWithImpl<$Res, UserProfileEvent>;
  @useResult
  $Res call({String? userId, String? username});
}

/// @nodoc
class _$UserProfileEventCopyWithImpl<$Res, $Val extends UserProfileEvent>
    implements $UserProfileEventCopyWith<$Res> {
  _$UserProfileEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? username = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfileEventFetchCopyWith<$Res>
    implements $UserProfileEventCopyWith<$Res> {
  factory _$$UserProfileEventFetchCopyWith(_$UserProfileEventFetch value,
          $Res Function(_$UserProfileEventFetch) then) =
      __$$UserProfileEventFetchCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? userId, String? username});
}

/// @nodoc
class __$$UserProfileEventFetchCopyWithImpl<$Res>
    extends _$UserProfileEventCopyWithImpl<$Res, _$UserProfileEventFetch>
    implements _$$UserProfileEventFetchCopyWith<$Res> {
  __$$UserProfileEventFetchCopyWithImpl(_$UserProfileEventFetch _value,
      $Res Function(_$UserProfileEventFetch) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? username = freezed,
  }) {
    return _then(_$UserProfileEventFetch(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UserProfileEventFetch implements UserProfileEventFetch {
  _$UserProfileEventFetch({this.userId, this.username});

  @override
  final String? userId;
  @override
  final String? username;

  @override
  String toString() {
    return 'UserProfileEvent.fetch(userId: $userId, username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileEventFetch &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileEventFetchCopyWith<_$UserProfileEventFetch> get copyWith =>
      __$$UserProfileEventFetchCopyWithImpl<_$UserProfileEventFetch>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? userId, String? username) fetch,
  }) {
    return fetch(userId, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? userId, String? username)? fetch,
  }) {
    return fetch?.call(userId, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? userId, String? username)? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(userId, username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserProfileEventFetch value) fetch,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserProfileEventFetch value)? fetch,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserProfileEventFetch value)? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class UserProfileEventFetch implements UserProfileEvent {
  factory UserProfileEventFetch(
      {final String? userId, final String? username}) = _$UserProfileEventFetch;

  @override
  String? get userId;
  @override
  String? get username;
  @override
  @JsonKey(ignore: true)
  _$$UserProfileEventFetchCopyWith<_$UserProfileEventFetch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(User userProfile) fetched,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(User userProfile)? fetched,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(User userProfile)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserProfileStateLoading value) loading,
    required TResult Function(UserProfileStateFetched value) fetched,
    required TResult Function(UserProfileStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserProfileStateLoading value)? loading,
    TResult? Function(UserProfileStateFetched value)? fetched,
    TResult? Function(UserProfileStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserProfileStateLoading value)? loading,
    TResult Function(UserProfileStateFetched value)? fetched,
    TResult Function(UserProfileStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileStateCopyWith<$Res> {
  factory $UserProfileStateCopyWith(
          UserProfileState value, $Res Function(UserProfileState) then) =
      _$UserProfileStateCopyWithImpl<$Res, UserProfileState>;
}

/// @nodoc
class _$UserProfileStateCopyWithImpl<$Res, $Val extends UserProfileState>
    implements $UserProfileStateCopyWith<$Res> {
  _$UserProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UserProfileStateLoadingCopyWith<$Res> {
  factory _$$UserProfileStateLoadingCopyWith(_$UserProfileStateLoading value,
          $Res Function(_$UserProfileStateLoading) then) =
      __$$UserProfileStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserProfileStateLoadingCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res, _$UserProfileStateLoading>
    implements _$$UserProfileStateLoadingCopyWith<$Res> {
  __$$UserProfileStateLoadingCopyWithImpl(_$UserProfileStateLoading _value,
      $Res Function(_$UserProfileStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UserProfileStateLoading implements UserProfileStateLoading {
  _$UserProfileStateLoading();

  @override
  String toString() {
    return 'UserProfileState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(User userProfile) fetched,
    required TResult Function() failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(User userProfile)? fetched,
    TResult? Function()? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(User userProfile)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserProfileStateLoading value) loading,
    required TResult Function(UserProfileStateFetched value) fetched,
    required TResult Function(UserProfileStateFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserProfileStateLoading value)? loading,
    TResult? Function(UserProfileStateFetched value)? fetched,
    TResult? Function(UserProfileStateFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserProfileStateLoading value)? loading,
    TResult Function(UserProfileStateFetched value)? fetched,
    TResult Function(UserProfileStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class UserProfileStateLoading implements UserProfileState {
  factory UserProfileStateLoading() = _$UserProfileStateLoading;
}

/// @nodoc
abstract class _$$UserProfileStateFetchedCopyWith<$Res> {
  factory _$$UserProfileStateFetchedCopyWith(_$UserProfileStateFetched value,
          $Res Function(_$UserProfileStateFetched) then) =
      __$$UserProfileStateFetchedCopyWithImpl<$Res>;
  @useResult
  $Res call({User userProfile});
}

/// @nodoc
class __$$UserProfileStateFetchedCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res, _$UserProfileStateFetched>
    implements _$$UserProfileStateFetchedCopyWith<$Res> {
  __$$UserProfileStateFetchedCopyWithImpl(_$UserProfileStateFetched _value,
      $Res Function(_$UserProfileStateFetched) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userProfile = null,
  }) {
    return _then(_$UserProfileStateFetched(
      userProfile: null == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc

class _$UserProfileStateFetched implements UserProfileStateFetched {
  _$UserProfileStateFetched({required this.userProfile});

  @override
  final User userProfile;

  @override
  String toString() {
    return 'UserProfileState.fetched(userProfile: $userProfile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileStateFetched &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userProfile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileStateFetchedCopyWith<_$UserProfileStateFetched> get copyWith =>
      __$$UserProfileStateFetchedCopyWithImpl<_$UserProfileStateFetched>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(User userProfile) fetched,
    required TResult Function() failure,
  }) {
    return fetched(userProfile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(User userProfile)? fetched,
    TResult? Function()? failure,
  }) {
    return fetched?.call(userProfile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(User userProfile)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(userProfile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserProfileStateLoading value) loading,
    required TResult Function(UserProfileStateFetched value) fetched,
    required TResult Function(UserProfileStateFailure value) failure,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserProfileStateLoading value)? loading,
    TResult? Function(UserProfileStateFetched value)? fetched,
    TResult? Function(UserProfileStateFailure value)? failure,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserProfileStateLoading value)? loading,
    TResult Function(UserProfileStateFetched value)? fetched,
    TResult Function(UserProfileStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class UserProfileStateFetched implements UserProfileState {
  factory UserProfileStateFetched({required final User userProfile}) =
      _$UserProfileStateFetched;

  User get userProfile;
  @JsonKey(ignore: true)
  _$$UserProfileStateFetchedCopyWith<_$UserProfileStateFetched> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserProfileStateFailureCopyWith<$Res> {
  factory _$$UserProfileStateFailureCopyWith(_$UserProfileStateFailure value,
          $Res Function(_$UserProfileStateFailure) then) =
      __$$UserProfileStateFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserProfileStateFailureCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res, _$UserProfileStateFailure>
    implements _$$UserProfileStateFailureCopyWith<$Res> {
  __$$UserProfileStateFailureCopyWithImpl(_$UserProfileStateFailure _value,
      $Res Function(_$UserProfileStateFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UserProfileStateFailure implements UserProfileStateFailure {
  _$UserProfileStateFailure();

  @override
  String toString() {
    return 'UserProfileState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileStateFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(User userProfile) fetched,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(User userProfile)? fetched,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(User userProfile)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserProfileStateLoading value) loading,
    required TResult Function(UserProfileStateFetched value) fetched,
    required TResult Function(UserProfileStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserProfileStateLoading value)? loading,
    TResult? Function(UserProfileStateFetched value)? fetched,
    TResult? Function(UserProfileStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserProfileStateLoading value)? loading,
    TResult Function(UserProfileStateFetched value)? fetched,
    TResult Function(UserProfileStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class UserProfileStateFailure implements UserProfileState {
  factory UserProfileStateFailure() = _$UserProfileStateFailure;
}
