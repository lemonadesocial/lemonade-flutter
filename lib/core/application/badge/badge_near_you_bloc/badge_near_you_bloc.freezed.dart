// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badge_near_you_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BadgesNearYouEvent {
  GetBadgesInput? get input => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetBadgesInput? input) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetBadgesInput? input)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetBadgesInput? input)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgesNearYouEventFetch value) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgesNearYouEventFetch value)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgesNearYouEventFetch value)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BadgesNearYouEventCopyWith<BadgesNearYouEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgesNearYouEventCopyWith<$Res> {
  factory $BadgesNearYouEventCopyWith(
          BadgesNearYouEvent value, $Res Function(BadgesNearYouEvent) then) =
      _$BadgesNearYouEventCopyWithImpl<$Res, BadgesNearYouEvent>;
  @useResult
  $Res call({GetBadgesInput? input});

  $GetBadgesInputCopyWith<$Res>? get input;
}

/// @nodoc
class _$BadgesNearYouEventCopyWithImpl<$Res, $Val extends BadgesNearYouEvent>
    implements $BadgesNearYouEventCopyWith<$Res> {
  _$BadgesNearYouEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? input = freezed,
  }) {
    return _then(_value.copyWith(
      input: freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as GetBadgesInput?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GetBadgesInputCopyWith<$Res>? get input {
    if (_value.input == null) {
      return null;
    }

    return $GetBadgesInputCopyWith<$Res>(_value.input!, (value) {
      return _then(_value.copyWith(input: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BadgesNearYouEventFetchCopyWith<$Res>
    implements $BadgesNearYouEventCopyWith<$Res> {
  factory _$$BadgesNearYouEventFetchCopyWith(_$BadgesNearYouEventFetch value,
          $Res Function(_$BadgesNearYouEventFetch) then) =
      __$$BadgesNearYouEventFetchCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GetBadgesInput? input});

  @override
  $GetBadgesInputCopyWith<$Res>? get input;
}

/// @nodoc
class __$$BadgesNearYouEventFetchCopyWithImpl<$Res>
    extends _$BadgesNearYouEventCopyWithImpl<$Res, _$BadgesNearYouEventFetch>
    implements _$$BadgesNearYouEventFetchCopyWith<$Res> {
  __$$BadgesNearYouEventFetchCopyWithImpl(_$BadgesNearYouEventFetch _value,
      $Res Function(_$BadgesNearYouEventFetch) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? input = freezed,
  }) {
    return _then(_$BadgesNearYouEventFetch(
      input: freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as GetBadgesInput?,
    ));
  }
}

/// @nodoc

class _$BadgesNearYouEventFetch implements BadgesNearYouEventFetch {
  _$BadgesNearYouEventFetch({this.input});

  @override
  final GetBadgesInput? input;

  @override
  String toString() {
    return 'BadgesNearYouEvent.fetch(input: $input)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgesNearYouEventFetch &&
            (identical(other.input, input) || other.input == input));
  }

  @override
  int get hashCode => Object.hash(runtimeType, input);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgesNearYouEventFetchCopyWith<_$BadgesNearYouEventFetch> get copyWith =>
      __$$BadgesNearYouEventFetchCopyWithImpl<_$BadgesNearYouEventFetch>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetBadgesInput? input) fetch,
  }) {
    return fetch(input);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetBadgesInput? input)? fetch,
  }) {
    return fetch?.call(input);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetBadgesInput? input)? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(input);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgesNearYouEventFetch value) fetch,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgesNearYouEventFetch value)? fetch,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgesNearYouEventFetch value)? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class BadgesNearYouEventFetch implements BadgesNearYouEvent {
  factory BadgesNearYouEventFetch({final GetBadgesInput? input}) =
      _$BadgesNearYouEventFetch;

  @override
  GetBadgesInput? get input;
  @override
  @JsonKey(ignore: true)
  _$$BadgesNearYouEventFetchCopyWith<_$BadgesNearYouEventFetch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BadgesNearYouState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<Badge> badges) fetched,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Badge> badges)? fetched,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Badge> badges)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgesNearYouStateInitial value) initial,
    required TResult Function(BadgesNearYouStateFetched value) fetched,
    required TResult Function(BadgesNearYouStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgesNearYouStateInitial value)? initial,
    TResult? Function(BadgesNearYouStateFetched value)? fetched,
    TResult? Function(BadgesNearYouStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgesNearYouStateInitial value)? initial,
    TResult Function(BadgesNearYouStateFetched value)? fetched,
    TResult Function(BadgesNearYouStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgesNearYouStateCopyWith<$Res> {
  factory $BadgesNearYouStateCopyWith(
          BadgesNearYouState value, $Res Function(BadgesNearYouState) then) =
      _$BadgesNearYouStateCopyWithImpl<$Res, BadgesNearYouState>;
}

/// @nodoc
class _$BadgesNearYouStateCopyWithImpl<$Res, $Val extends BadgesNearYouState>
    implements $BadgesNearYouStateCopyWith<$Res> {
  _$BadgesNearYouStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BadgesNearYouStateInitialCopyWith<$Res> {
  factory _$$BadgesNearYouStateInitialCopyWith(
          _$BadgesNearYouStateInitial value,
          $Res Function(_$BadgesNearYouStateInitial) then) =
      __$$BadgesNearYouStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BadgesNearYouStateInitialCopyWithImpl<$Res>
    extends _$BadgesNearYouStateCopyWithImpl<$Res, _$BadgesNearYouStateInitial>
    implements _$$BadgesNearYouStateInitialCopyWith<$Res> {
  __$$BadgesNearYouStateInitialCopyWithImpl(_$BadgesNearYouStateInitial _value,
      $Res Function(_$BadgesNearYouStateInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BadgesNearYouStateInitial implements BadgesNearYouStateInitial {
  _$BadgesNearYouStateInitial();

  @override
  String toString() {
    return 'BadgesNearYouState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgesNearYouStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<Badge> badges) fetched,
    required TResult Function() failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Badge> badges)? fetched,
    TResult? Function()? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Badge> badges)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgesNearYouStateInitial value) initial,
    required TResult Function(BadgesNearYouStateFetched value) fetched,
    required TResult Function(BadgesNearYouStateFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgesNearYouStateInitial value)? initial,
    TResult? Function(BadgesNearYouStateFetched value)? fetched,
    TResult? Function(BadgesNearYouStateFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgesNearYouStateInitial value)? initial,
    TResult Function(BadgesNearYouStateFetched value)? fetched,
    TResult Function(BadgesNearYouStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BadgesNearYouStateInitial implements BadgesNearYouState {
  factory BadgesNearYouStateInitial() = _$BadgesNearYouStateInitial;
}

/// @nodoc
abstract class _$$BadgesNearYouStateFetchedCopyWith<$Res> {
  factory _$$BadgesNearYouStateFetchedCopyWith(
          _$BadgesNearYouStateFetched value,
          $Res Function(_$BadgesNearYouStateFetched) then) =
      __$$BadgesNearYouStateFetchedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Badge> badges});
}

/// @nodoc
class __$$BadgesNearYouStateFetchedCopyWithImpl<$Res>
    extends _$BadgesNearYouStateCopyWithImpl<$Res, _$BadgesNearYouStateFetched>
    implements _$$BadgesNearYouStateFetchedCopyWith<$Res> {
  __$$BadgesNearYouStateFetchedCopyWithImpl(_$BadgesNearYouStateFetched _value,
      $Res Function(_$BadgesNearYouStateFetched) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? badges = null,
  }) {
    return _then(_$BadgesNearYouStateFetched(
      badges: null == badges
          ? _value._badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<Badge>,
    ));
  }
}

/// @nodoc

class _$BadgesNearYouStateFetched implements BadgesNearYouStateFetched {
  _$BadgesNearYouStateFetched({required final List<Badge> badges})
      : _badges = badges;

  final List<Badge> _badges;
  @override
  List<Badge> get badges {
    if (_badges is EqualUnmodifiableListView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badges);
  }

  @override
  String toString() {
    return 'BadgesNearYouState.fetched(badges: $badges)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgesNearYouStateFetched &&
            const DeepCollectionEquality().equals(other._badges, _badges));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_badges));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgesNearYouStateFetchedCopyWith<_$BadgesNearYouStateFetched>
      get copyWith => __$$BadgesNearYouStateFetchedCopyWithImpl<
          _$BadgesNearYouStateFetched>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<Badge> badges) fetched,
    required TResult Function() failure,
  }) {
    return fetched(badges);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Badge> badges)? fetched,
    TResult? Function()? failure,
  }) {
    return fetched?.call(badges);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Badge> badges)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(badges);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgesNearYouStateInitial value) initial,
    required TResult Function(BadgesNearYouStateFetched value) fetched,
    required TResult Function(BadgesNearYouStateFailure value) failure,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgesNearYouStateInitial value)? initial,
    TResult? Function(BadgesNearYouStateFetched value)? fetched,
    TResult? Function(BadgesNearYouStateFailure value)? failure,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgesNearYouStateInitial value)? initial,
    TResult Function(BadgesNearYouStateFetched value)? fetched,
    TResult Function(BadgesNearYouStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class BadgesNearYouStateFetched implements BadgesNearYouState {
  factory BadgesNearYouStateFetched({required final List<Badge> badges}) =
      _$BadgesNearYouStateFetched;

  List<Badge> get badges;
  @JsonKey(ignore: true)
  _$$BadgesNearYouStateFetchedCopyWith<_$BadgesNearYouStateFetched>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BadgesNearYouStateFailureCopyWith<$Res> {
  factory _$$BadgesNearYouStateFailureCopyWith(
          _$BadgesNearYouStateFailure value,
          $Res Function(_$BadgesNearYouStateFailure) then) =
      __$$BadgesNearYouStateFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BadgesNearYouStateFailureCopyWithImpl<$Res>
    extends _$BadgesNearYouStateCopyWithImpl<$Res, _$BadgesNearYouStateFailure>
    implements _$$BadgesNearYouStateFailureCopyWith<$Res> {
  __$$BadgesNearYouStateFailureCopyWithImpl(_$BadgesNearYouStateFailure _value,
      $Res Function(_$BadgesNearYouStateFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BadgesNearYouStateFailure implements BadgesNearYouStateFailure {
  _$BadgesNearYouStateFailure();

  @override
  String toString() {
    return 'BadgesNearYouState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgesNearYouStateFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<Badge> badges) fetched,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Badge> badges)? fetched,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Badge> badges)? fetched,
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
    required TResult Function(BadgesNearYouStateInitial value) initial,
    required TResult Function(BadgesNearYouStateFetched value) fetched,
    required TResult Function(BadgesNearYouStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgesNearYouStateInitial value)? initial,
    TResult? Function(BadgesNearYouStateFetched value)? fetched,
    TResult? Function(BadgesNearYouStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgesNearYouStateInitial value)? initial,
    TResult Function(BadgesNearYouStateFetched value)? fetched,
    TResult Function(BadgesNearYouStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class BadgesNearYouStateFailure implements BadgesNearYouState {
  factory BadgesNearYouStateFailure() = _$BadgesNearYouStateFailure;
}
