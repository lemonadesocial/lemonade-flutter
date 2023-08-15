// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badge_locations_listing_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BadgeLocationsListingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(BadgeCity location) select,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetch,
    TResult? Function(BadgeCity location)? select,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(BadgeCity location)? select,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgeLocationsListingEventFetch value) fetch,
    required TResult Function(BadgeLocationsListingEventSelect value) select,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeLocationsListingEventFetch value)? fetch,
    TResult? Function(BadgeLocationsListingEventSelect value)? select,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeLocationsListingEventFetch value)? fetch,
    TResult Function(BadgeLocationsListingEventSelect value)? select,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeLocationsListingEventCopyWith<$Res> {
  factory $BadgeLocationsListingEventCopyWith(BadgeLocationsListingEvent value,
          $Res Function(BadgeLocationsListingEvent) then) =
      _$BadgeLocationsListingEventCopyWithImpl<$Res,
          BadgeLocationsListingEvent>;
}

/// @nodoc
class _$BadgeLocationsListingEventCopyWithImpl<$Res,
        $Val extends BadgeLocationsListingEvent>
    implements $BadgeLocationsListingEventCopyWith<$Res> {
  _$BadgeLocationsListingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BadgeLocationsListingEventFetchCopyWith<$Res> {
  factory _$$BadgeLocationsListingEventFetchCopyWith(
          _$BadgeLocationsListingEventFetch value,
          $Res Function(_$BadgeLocationsListingEventFetch) then) =
      __$$BadgeLocationsListingEventFetchCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BadgeLocationsListingEventFetchCopyWithImpl<$Res>
    extends _$BadgeLocationsListingEventCopyWithImpl<$Res,
        _$BadgeLocationsListingEventFetch>
    implements _$$BadgeLocationsListingEventFetchCopyWith<$Res> {
  __$$BadgeLocationsListingEventFetchCopyWithImpl(
      _$BadgeLocationsListingEventFetch _value,
      $Res Function(_$BadgeLocationsListingEventFetch) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BadgeLocationsListingEventFetch
    implements BadgeLocationsListingEventFetch {
  _$BadgeLocationsListingEventFetch();

  @override
  String toString() {
    return 'BadgeLocationsListingEvent.fetch()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeLocationsListingEventFetch);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(BadgeCity location) select,
  }) {
    return fetch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetch,
    TResult? Function(BadgeCity location)? select,
  }) {
    return fetch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(BadgeCity location)? select,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgeLocationsListingEventFetch value) fetch,
    required TResult Function(BadgeLocationsListingEventSelect value) select,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeLocationsListingEventFetch value)? fetch,
    TResult? Function(BadgeLocationsListingEventSelect value)? select,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeLocationsListingEventFetch value)? fetch,
    TResult Function(BadgeLocationsListingEventSelect value)? select,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class BadgeLocationsListingEventFetch
    implements BadgeLocationsListingEvent {
  factory BadgeLocationsListingEventFetch() = _$BadgeLocationsListingEventFetch;
}

/// @nodoc
abstract class _$$BadgeLocationsListingEventSelectCopyWith<$Res> {
  factory _$$BadgeLocationsListingEventSelectCopyWith(
          _$BadgeLocationsListingEventSelect value,
          $Res Function(_$BadgeLocationsListingEventSelect) then) =
      __$$BadgeLocationsListingEventSelectCopyWithImpl<$Res>;
  @useResult
  $Res call({BadgeCity location});
}

/// @nodoc
class __$$BadgeLocationsListingEventSelectCopyWithImpl<$Res>
    extends _$BadgeLocationsListingEventCopyWithImpl<$Res,
        _$BadgeLocationsListingEventSelect>
    implements _$$BadgeLocationsListingEventSelectCopyWith<$Res> {
  __$$BadgeLocationsListingEventSelectCopyWithImpl(
      _$BadgeLocationsListingEventSelect _value,
      $Res Function(_$BadgeLocationsListingEventSelect) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
  }) {
    return _then(_$BadgeLocationsListingEventSelect(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as BadgeCity,
    ));
  }
}

/// @nodoc

class _$BadgeLocationsListingEventSelect
    implements BadgeLocationsListingEventSelect {
  _$BadgeLocationsListingEventSelect({required this.location});

  @override
  final BadgeCity location;

  @override
  String toString() {
    return 'BadgeLocationsListingEvent.select(location: $location)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeLocationsListingEventSelect &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgeLocationsListingEventSelectCopyWith<
          _$BadgeLocationsListingEventSelect>
      get copyWith => __$$BadgeLocationsListingEventSelectCopyWithImpl<
          _$BadgeLocationsListingEventSelect>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
    required TResult Function(BadgeCity location) select,
  }) {
    return select(location);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetch,
    TResult? Function(BadgeCity location)? select,
  }) {
    return select?.call(location);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    TResult Function(BadgeCity location)? select,
    required TResult orElse(),
  }) {
    if (select != null) {
      return select(location);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgeLocationsListingEventFetch value) fetch,
    required TResult Function(BadgeLocationsListingEventSelect value) select,
  }) {
    return select(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeLocationsListingEventFetch value)? fetch,
    TResult? Function(BadgeLocationsListingEventSelect value)? select,
  }) {
    return select?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeLocationsListingEventFetch value)? fetch,
    TResult Function(BadgeLocationsListingEventSelect value)? select,
    required TResult orElse(),
  }) {
    if (select != null) {
      return select(this);
    }
    return orElse();
  }
}

abstract class BadgeLocationsListingEventSelect
    implements BadgeLocationsListingEvent {
  factory BadgeLocationsListingEventSelect(
      {required final BadgeCity location}) = _$BadgeLocationsListingEventSelect;

  BadgeCity get location;
  @JsonKey(ignore: true)
  _$$BadgeLocationsListingEventSelectCopyWith<
          _$BadgeLocationsListingEventSelect>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BadgeLocationsListingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<BadgeCity> locations, BadgeList selectedLocation)
        fetched,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<BadgeCity> locations, BadgeList selectedLocation)?
        fetched,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<BadgeCity> locations, BadgeList selectedLocation)?
        fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgeLocationsListingStateInitial value) initial,
    required TResult Function(BadgeLocationsListingStateFetched value) fetched,
    required TResult Function(BadgeLocationsListingStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeLocationsListingStateInitial value)? initial,
    TResult? Function(BadgeLocationsListingStateFetched value)? fetched,
    TResult? Function(BadgeLocationsListingStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeLocationsListingStateInitial value)? initial,
    TResult Function(BadgeLocationsListingStateFetched value)? fetched,
    TResult Function(BadgeLocationsListingStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeLocationsListingStateCopyWith<$Res> {
  factory $BadgeLocationsListingStateCopyWith(BadgeLocationsListingState value,
          $Res Function(BadgeLocationsListingState) then) =
      _$BadgeLocationsListingStateCopyWithImpl<$Res,
          BadgeLocationsListingState>;
}

/// @nodoc
class _$BadgeLocationsListingStateCopyWithImpl<$Res,
        $Val extends BadgeLocationsListingState>
    implements $BadgeLocationsListingStateCopyWith<$Res> {
  _$BadgeLocationsListingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BadgeLocationsListingStateInitialCopyWith<$Res> {
  factory _$$BadgeLocationsListingStateInitialCopyWith(
          _$BadgeLocationsListingStateInitial value,
          $Res Function(_$BadgeLocationsListingStateInitial) then) =
      __$$BadgeLocationsListingStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BadgeLocationsListingStateInitialCopyWithImpl<$Res>
    extends _$BadgeLocationsListingStateCopyWithImpl<$Res,
        _$BadgeLocationsListingStateInitial>
    implements _$$BadgeLocationsListingStateInitialCopyWith<$Res> {
  __$$BadgeLocationsListingStateInitialCopyWithImpl(
      _$BadgeLocationsListingStateInitial _value,
      $Res Function(_$BadgeLocationsListingStateInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BadgeLocationsListingStateInitial
    implements BadgeLocationsListingStateInitial {
  _$BadgeLocationsListingStateInitial();

  @override
  String toString() {
    return 'BadgeLocationsListingState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeLocationsListingStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<BadgeCity> locations, BadgeList selectedLocation)
        fetched,
    required TResult Function() failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<BadgeCity> locations, BadgeList selectedLocation)?
        fetched,
    TResult? Function()? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<BadgeCity> locations, BadgeList selectedLocation)?
        fetched,
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
    required TResult Function(BadgeLocationsListingStateInitial value) initial,
    required TResult Function(BadgeLocationsListingStateFetched value) fetched,
    required TResult Function(BadgeLocationsListingStateFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeLocationsListingStateInitial value)? initial,
    TResult? Function(BadgeLocationsListingStateFetched value)? fetched,
    TResult? Function(BadgeLocationsListingStateFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeLocationsListingStateInitial value)? initial,
    TResult Function(BadgeLocationsListingStateFetched value)? fetched,
    TResult Function(BadgeLocationsListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BadgeLocationsListingStateInitial
    implements BadgeLocationsListingState {
  factory BadgeLocationsListingStateInitial() =
      _$BadgeLocationsListingStateInitial;
}

/// @nodoc
abstract class _$$BadgeLocationsListingStateFetchedCopyWith<$Res> {
  factory _$$BadgeLocationsListingStateFetchedCopyWith(
          _$BadgeLocationsListingStateFetched value,
          $Res Function(_$BadgeLocationsListingStateFetched) then) =
      __$$BadgeLocationsListingStateFetchedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<BadgeCity> locations, BadgeList selectedLocation});
}

/// @nodoc
class __$$BadgeLocationsListingStateFetchedCopyWithImpl<$Res>
    extends _$BadgeLocationsListingStateCopyWithImpl<$Res,
        _$BadgeLocationsListingStateFetched>
    implements _$$BadgeLocationsListingStateFetchedCopyWith<$Res> {
  __$$BadgeLocationsListingStateFetchedCopyWithImpl(
      _$BadgeLocationsListingStateFetched _value,
      $Res Function(_$BadgeLocationsListingStateFetched) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locations = null,
    Object? selectedLocation = null,
  }) {
    return _then(_$BadgeLocationsListingStateFetched(
      locations: null == locations
          ? _value._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<BadgeCity>,
      selectedLocation: null == selectedLocation
          ? _value.selectedLocation
          : selectedLocation // ignore: cast_nullable_to_non_nullable
              as BadgeList,
    ));
  }
}

/// @nodoc

class _$BadgeLocationsListingStateFetched
    implements BadgeLocationsListingStateFetched {
  _$BadgeLocationsListingStateFetched(
      {required final List<BadgeCity> locations,
      required this.selectedLocation})
      : _locations = locations;

  final List<BadgeCity> _locations;
  @override
  List<BadgeCity> get locations {
    if (_locations is EqualUnmodifiableListView) return _locations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locations);
  }

  @override
  final BadgeList selectedLocation;

  @override
  String toString() {
    return 'BadgeLocationsListingState.fetched(locations: $locations, selectedLocation: $selectedLocation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeLocationsListingStateFetched &&
            const DeepCollectionEquality()
                .equals(other._locations, _locations) &&
            (identical(other.selectedLocation, selectedLocation) ||
                other.selectedLocation == selectedLocation));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_locations), selectedLocation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgeLocationsListingStateFetchedCopyWith<
          _$BadgeLocationsListingStateFetched>
      get copyWith => __$$BadgeLocationsListingStateFetchedCopyWithImpl<
          _$BadgeLocationsListingStateFetched>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<BadgeCity> locations, BadgeList selectedLocation)
        fetched,
    required TResult Function() failure,
  }) {
    return fetched(locations, selectedLocation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<BadgeCity> locations, BadgeList selectedLocation)?
        fetched,
    TResult? Function()? failure,
  }) {
    return fetched?.call(locations, selectedLocation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<BadgeCity> locations, BadgeList selectedLocation)?
        fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(locations, selectedLocation);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BadgeLocationsListingStateInitial value) initial,
    required TResult Function(BadgeLocationsListingStateFetched value) fetched,
    required TResult Function(BadgeLocationsListingStateFailure value) failure,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeLocationsListingStateInitial value)? initial,
    TResult? Function(BadgeLocationsListingStateFetched value)? fetched,
    TResult? Function(BadgeLocationsListingStateFailure value)? failure,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeLocationsListingStateInitial value)? initial,
    TResult Function(BadgeLocationsListingStateFetched value)? fetched,
    TResult Function(BadgeLocationsListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class BadgeLocationsListingStateFetched
    implements BadgeLocationsListingState {
  factory BadgeLocationsListingStateFetched(
          {required final List<BadgeCity> locations,
          required final BadgeList selectedLocation}) =
      _$BadgeLocationsListingStateFetched;

  List<BadgeCity> get locations;
  BadgeList get selectedLocation;
  @JsonKey(ignore: true)
  _$$BadgeLocationsListingStateFetchedCopyWith<
          _$BadgeLocationsListingStateFetched>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BadgeLocationsListingStateFailureCopyWith<$Res> {
  factory _$$BadgeLocationsListingStateFailureCopyWith(
          _$BadgeLocationsListingStateFailure value,
          $Res Function(_$BadgeLocationsListingStateFailure) then) =
      __$$BadgeLocationsListingStateFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BadgeLocationsListingStateFailureCopyWithImpl<$Res>
    extends _$BadgeLocationsListingStateCopyWithImpl<$Res,
        _$BadgeLocationsListingStateFailure>
    implements _$$BadgeLocationsListingStateFailureCopyWith<$Res> {
  __$$BadgeLocationsListingStateFailureCopyWithImpl(
      _$BadgeLocationsListingStateFailure _value,
      $Res Function(_$BadgeLocationsListingStateFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BadgeLocationsListingStateFailure
    implements BadgeLocationsListingStateFailure {
  _$BadgeLocationsListingStateFailure();

  @override
  String toString() {
    return 'BadgeLocationsListingState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeLocationsListingStateFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<BadgeCity> locations, BadgeList selectedLocation)
        fetched,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<BadgeCity> locations, BadgeList selectedLocation)?
        fetched,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<BadgeCity> locations, BadgeList selectedLocation)?
        fetched,
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
    required TResult Function(BadgeLocationsListingStateInitial value) initial,
    required TResult Function(BadgeLocationsListingStateFetched value) fetched,
    required TResult Function(BadgeLocationsListingStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BadgeLocationsListingStateInitial value)? initial,
    TResult? Function(BadgeLocationsListingStateFetched value)? fetched,
    TResult? Function(BadgeLocationsListingStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BadgeLocationsListingStateInitial value)? initial,
    TResult Function(BadgeLocationsListingStateFetched value)? fetched,
    TResult Function(BadgeLocationsListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class BadgeLocationsListingStateFailure
    implements BadgeLocationsListingState {
  factory BadgeLocationsListingStateFailure() =
      _$BadgeLocationsListingStateFailure;
}
