// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badges_listing_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BadgesListingEvent {
  GetBadgesInput? get input => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetBadgesInput? input) fetch,
    required TResult Function(GetBadgesInput? input) refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetBadgesInput? input)? fetch,
    TResult? Function(GetBadgesInput? input)? refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetBadgesInput? input)? fetch,
    TResult Function(GetBadgesInput? input)? refresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgesListingEventFetch value) fetch,
    required TResult Function(BadgesListingEventRefresh value) refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgesListingEventFetch value)? fetch,
    TResult? Function(BadgesListingEventRefresh value)? refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgesListingEventFetch value)? fetch,
    TResult Function(BadgesListingEventRefresh value)? refresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BadgesListingEventCopyWith<BadgesListingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgesListingEventCopyWith<$Res> {
  factory $BadgesListingEventCopyWith(
          BadgesListingEvent value, $Res Function(BadgesListingEvent) then) =
      _$BadgesListingEventCopyWithImpl<$Res, BadgesListingEvent>;
  @useResult
  $Res call({GetBadgesInput? input});

  $GetBadgesInputCopyWith<$Res>? get input;
}

/// @nodoc
class _$BadgesListingEventCopyWithImpl<$Res, $Val extends BadgesListingEvent>
    implements $BadgesListingEventCopyWith<$Res> {
  _$BadgesListingEventCopyWithImpl(this._value, this._then);

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
abstract class _$$BadgesListingEventFetchCopyWith<$Res>
    implements $BadgesListingEventCopyWith<$Res> {
  factory _$$BadgesListingEventFetchCopyWith(_$BadgesListingEventFetch value,
          $Res Function(_$BadgesListingEventFetch) then) =
      __$$BadgesListingEventFetchCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GetBadgesInput? input});

  @override
  $GetBadgesInputCopyWith<$Res>? get input;
}

/// @nodoc
class __$$BadgesListingEventFetchCopyWithImpl<$Res>
    extends _$BadgesListingEventCopyWithImpl<$Res, _$BadgesListingEventFetch>
    implements _$$BadgesListingEventFetchCopyWith<$Res> {
  __$$BadgesListingEventFetchCopyWithImpl(_$BadgesListingEventFetch _value,
      $Res Function(_$BadgesListingEventFetch) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? input = freezed,
  }) {
    return _then(_$BadgesListingEventFetch(
      input: freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as GetBadgesInput?,
    ));
  }
}

/// @nodoc

class _$BadgesListingEventFetch implements BadgesListingEventFetch {
  _$BadgesListingEventFetch({this.input});

  @override
  final GetBadgesInput? input;

  @override
  String toString() {
    return 'BadgesListingEvent.fetch(input: $input)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgesListingEventFetch &&
            (identical(other.input, input) || other.input == input));
  }

  @override
  int get hashCode => Object.hash(runtimeType, input);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgesListingEventFetchCopyWith<_$BadgesListingEventFetch> get copyWith =>
      __$$BadgesListingEventFetchCopyWithImpl<_$BadgesListingEventFetch>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetBadgesInput? input) fetch,
    required TResult Function(GetBadgesInput? input) refresh,
  }) {
    return fetch(input);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetBadgesInput? input)? fetch,
    TResult? Function(GetBadgesInput? input)? refresh,
  }) {
    return fetch?.call(input);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetBadgesInput? input)? fetch,
    TResult Function(GetBadgesInput? input)? refresh,
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
    required TResult Function(BadgesListingEventFetch value) fetch,
    required TResult Function(BadgesListingEventRefresh value) refresh,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgesListingEventFetch value)? fetch,
    TResult? Function(BadgesListingEventRefresh value)? refresh,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgesListingEventFetch value)? fetch,
    TResult Function(BadgesListingEventRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class BadgesListingEventFetch implements BadgesListingEvent {
  factory BadgesListingEventFetch({final GetBadgesInput? input}) =
      _$BadgesListingEventFetch;

  @override
  GetBadgesInput? get input;
  @override
  @JsonKey(ignore: true)
  _$$BadgesListingEventFetchCopyWith<_$BadgesListingEventFetch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BadgesListingEventRefreshCopyWith<$Res>
    implements $BadgesListingEventCopyWith<$Res> {
  factory _$$BadgesListingEventRefreshCopyWith(
          _$BadgesListingEventRefresh value,
          $Res Function(_$BadgesListingEventRefresh) then) =
      __$$BadgesListingEventRefreshCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GetBadgesInput? input});

  @override
  $GetBadgesInputCopyWith<$Res>? get input;
}

/// @nodoc
class __$$BadgesListingEventRefreshCopyWithImpl<$Res>
    extends _$BadgesListingEventCopyWithImpl<$Res, _$BadgesListingEventRefresh>
    implements _$$BadgesListingEventRefreshCopyWith<$Res> {
  __$$BadgesListingEventRefreshCopyWithImpl(_$BadgesListingEventRefresh _value,
      $Res Function(_$BadgesListingEventRefresh) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? input = freezed,
  }) {
    return _then(_$BadgesListingEventRefresh(
      input: freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as GetBadgesInput?,
    ));
  }
}

/// @nodoc

class _$BadgesListingEventRefresh implements BadgesListingEventRefresh {
  _$BadgesListingEventRefresh({this.input});

  @override
  final GetBadgesInput? input;

  @override
  String toString() {
    return 'BadgesListingEvent.refresh(input: $input)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgesListingEventRefresh &&
            (identical(other.input, input) || other.input == input));
  }

  @override
  int get hashCode => Object.hash(runtimeType, input);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgesListingEventRefreshCopyWith<_$BadgesListingEventRefresh>
      get copyWith => __$$BadgesListingEventRefreshCopyWithImpl<
          _$BadgesListingEventRefresh>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetBadgesInput? input) fetch,
    required TResult Function(GetBadgesInput? input) refresh,
  }) {
    return refresh(input);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetBadgesInput? input)? fetch,
    TResult? Function(GetBadgesInput? input)? refresh,
  }) {
    return refresh?.call(input);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetBadgesInput? input)? fetch,
    TResult Function(GetBadgesInput? input)? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(input);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgesListingEventFetch value) fetch,
    required TResult Function(BadgesListingEventRefresh value) refresh,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgesListingEventFetch value)? fetch,
    TResult? Function(BadgesListingEventRefresh value)? refresh,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgesListingEventFetch value)? fetch,
    TResult Function(BadgesListingEventRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class BadgesListingEventRefresh implements BadgesListingEvent {
  factory BadgesListingEventRefresh({final GetBadgesInput? input}) =
      _$BadgesListingEventRefresh;

  @override
  GetBadgesInput? get input;
  @override
  @JsonKey(ignore: true)
  _$$BadgesListingEventRefreshCopyWith<_$BadgesListingEventRefresh>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BadgesListingState {
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
    required TResult Function(BadgesListingStateInitial value) initial,
    required TResult Function(BadgesListingStateFetched value) fetched,
    required TResult Function(BadgesListingStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgesListingStateInitial value)? initial,
    TResult? Function(BadgesListingStateFetched value)? fetched,
    TResult? Function(BadgesListingStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgesListingStateInitial value)? initial,
    TResult Function(BadgesListingStateFetched value)? fetched,
    TResult Function(BadgesListingStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgesListingStateCopyWith<$Res> {
  factory $BadgesListingStateCopyWith(
          BadgesListingState value, $Res Function(BadgesListingState) then) =
      _$BadgesListingStateCopyWithImpl<$Res, BadgesListingState>;
}

/// @nodoc
class _$BadgesListingStateCopyWithImpl<$Res, $Val extends BadgesListingState>
    implements $BadgesListingStateCopyWith<$Res> {
  _$BadgesListingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BadgesListingStateInitialCopyWith<$Res> {
  factory _$$BadgesListingStateInitialCopyWith(
          _$BadgesListingStateInitial value,
          $Res Function(_$BadgesListingStateInitial) then) =
      __$$BadgesListingStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BadgesListingStateInitialCopyWithImpl<$Res>
    extends _$BadgesListingStateCopyWithImpl<$Res, _$BadgesListingStateInitial>
    implements _$$BadgesListingStateInitialCopyWith<$Res> {
  __$$BadgesListingStateInitialCopyWithImpl(_$BadgesListingStateInitial _value,
      $Res Function(_$BadgesListingStateInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BadgesListingStateInitial implements BadgesListingStateInitial {
  _$BadgesListingStateInitial();

  @override
  String toString() {
    return 'BadgesListingState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgesListingStateInitial);
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
    required TResult Function(BadgesListingStateInitial value) initial,
    required TResult Function(BadgesListingStateFetched value) fetched,
    required TResult Function(BadgesListingStateFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgesListingStateInitial value)? initial,
    TResult? Function(BadgesListingStateFetched value)? fetched,
    TResult? Function(BadgesListingStateFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgesListingStateInitial value)? initial,
    TResult Function(BadgesListingStateFetched value)? fetched,
    TResult Function(BadgesListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BadgesListingStateInitial implements BadgesListingState {
  factory BadgesListingStateInitial() = _$BadgesListingStateInitial;
}

/// @nodoc
abstract class _$$BadgesListingStateFetchedCopyWith<$Res> {
  factory _$$BadgesListingStateFetchedCopyWith(
          _$BadgesListingStateFetched value,
          $Res Function(_$BadgesListingStateFetched) then) =
      __$$BadgesListingStateFetchedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Badge> badges});
}

/// @nodoc
class __$$BadgesListingStateFetchedCopyWithImpl<$Res>
    extends _$BadgesListingStateCopyWithImpl<$Res, _$BadgesListingStateFetched>
    implements _$$BadgesListingStateFetchedCopyWith<$Res> {
  __$$BadgesListingStateFetchedCopyWithImpl(_$BadgesListingStateFetched _value,
      $Res Function(_$BadgesListingStateFetched) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? badges = null,
  }) {
    return _then(_$BadgesListingStateFetched(
      badges: null == badges
          ? _value._badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<Badge>,
    ));
  }
}

/// @nodoc

class _$BadgesListingStateFetched implements BadgesListingStateFetched {
  _$BadgesListingStateFetched({required final List<Badge> badges})
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
    return 'BadgesListingState.fetched(badges: $badges)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgesListingStateFetched &&
            const DeepCollectionEquality().equals(other._badges, _badges));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_badges));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgesListingStateFetchedCopyWith<_$BadgesListingStateFetched>
      get copyWith => __$$BadgesListingStateFetchedCopyWithImpl<
          _$BadgesListingStateFetched>(this, _$identity);

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
    required TResult Function(BadgesListingStateInitial value) initial,
    required TResult Function(BadgesListingStateFetched value) fetched,
    required TResult Function(BadgesListingStateFailure value) failure,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgesListingStateInitial value)? initial,
    TResult? Function(BadgesListingStateFetched value)? fetched,
    TResult? Function(BadgesListingStateFailure value)? failure,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgesListingStateInitial value)? initial,
    TResult Function(BadgesListingStateFetched value)? fetched,
    TResult Function(BadgesListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class BadgesListingStateFetched implements BadgesListingState {
  factory BadgesListingStateFetched({required final List<Badge> badges}) =
      _$BadgesListingStateFetched;

  List<Badge> get badges;
  @JsonKey(ignore: true)
  _$$BadgesListingStateFetchedCopyWith<_$BadgesListingStateFetched>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BadgesListingStateFailureCopyWith<$Res> {
  factory _$$BadgesListingStateFailureCopyWith(
          _$BadgesListingStateFailure value,
          $Res Function(_$BadgesListingStateFailure) then) =
      __$$BadgesListingStateFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BadgesListingStateFailureCopyWithImpl<$Res>
    extends _$BadgesListingStateCopyWithImpl<$Res, _$BadgesListingStateFailure>
    implements _$$BadgesListingStateFailureCopyWith<$Res> {
  __$$BadgesListingStateFailureCopyWithImpl(_$BadgesListingStateFailure _value,
      $Res Function(_$BadgesListingStateFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BadgesListingStateFailure implements BadgesListingStateFailure {
  _$BadgesListingStateFailure();

  @override
  String toString() {
    return 'BadgesListingState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgesListingStateFailure);
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
    required TResult Function(BadgesListingStateInitial value) initial,
    required TResult Function(BadgesListingStateFetched value) fetched,
    required TResult Function(BadgesListingStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgesListingStateInitial value)? initial,
    TResult? Function(BadgesListingStateFetched value)? fetched,
    TResult? Function(BadgesListingStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgesListingStateInitial value)? initial,
    TResult Function(BadgesListingStateFetched value)? fetched,
    TResult Function(BadgesListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class BadgesListingStateFailure implements BadgesListingState {
  factory BadgesListingStateFailure() = _$BadgesListingStateFailure;
}
