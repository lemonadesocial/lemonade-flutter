// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_events_listing_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BaseEventsListingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Event> events, List<Event> filteredEvents)
        fetched,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Event> events, List<Event> filteredEvents)? fetched,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Event> events, List<Event> filteredEvents)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BaseEventsListingStateLoading value) loading,
    required TResult Function(BaseEventsListingStateFetched value) fetched,
    required TResult Function(BaseEventsListingStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BaseEventsListingStateLoading value)? loading,
    TResult? Function(BaseEventsListingStateFetched value)? fetched,
    TResult? Function(BaseEventsListingStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseEventsListingStateLoading value)? loading,
    TResult Function(BaseEventsListingStateFetched value)? fetched,
    TResult Function(BaseEventsListingStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseEventsListingStateCopyWith<$Res> {
  factory $BaseEventsListingStateCopyWith(BaseEventsListingState value,
          $Res Function(BaseEventsListingState) then) =
      _$BaseEventsListingStateCopyWithImpl<$Res, BaseEventsListingState>;
}

/// @nodoc
class _$BaseEventsListingStateCopyWithImpl<$Res,
        $Val extends BaseEventsListingState>
    implements $BaseEventsListingStateCopyWith<$Res> {
  _$BaseEventsListingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BaseEventsListingStateLoadingCopyWith<$Res> {
  factory _$$BaseEventsListingStateLoadingCopyWith(
          _$BaseEventsListingStateLoading value,
          $Res Function(_$BaseEventsListingStateLoading) then) =
      __$$BaseEventsListingStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BaseEventsListingStateLoadingCopyWithImpl<$Res>
    extends _$BaseEventsListingStateCopyWithImpl<$Res,
        _$BaseEventsListingStateLoading>
    implements _$$BaseEventsListingStateLoadingCopyWith<$Res> {
  __$$BaseEventsListingStateLoadingCopyWithImpl(
      _$BaseEventsListingStateLoading _value,
      $Res Function(_$BaseEventsListingStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BaseEventsListingStateLoading extends BaseEventsListingStateLoading {
  _$BaseEventsListingStateLoading() : super._();

  @override
  String toString() {
    return 'BaseEventsListingState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseEventsListingStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Event> events, List<Event> filteredEvents)
        fetched,
    required TResult Function() failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Event> events, List<Event> filteredEvents)? fetched,
    TResult? Function()? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Event> events, List<Event> filteredEvents)? fetched,
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
    required TResult Function(BaseEventsListingStateLoading value) loading,
    required TResult Function(BaseEventsListingStateFetched value) fetched,
    required TResult Function(BaseEventsListingStateFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BaseEventsListingStateLoading value)? loading,
    TResult? Function(BaseEventsListingStateFetched value)? fetched,
    TResult? Function(BaseEventsListingStateFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseEventsListingStateLoading value)? loading,
    TResult Function(BaseEventsListingStateFetched value)? fetched,
    TResult Function(BaseEventsListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BaseEventsListingStateLoading extends BaseEventsListingState {
  factory BaseEventsListingStateLoading() = _$BaseEventsListingStateLoading;
  BaseEventsListingStateLoading._() : super._();
}

/// @nodoc
abstract class _$$BaseEventsListingStateFetchedCopyWith<$Res> {
  factory _$$BaseEventsListingStateFetchedCopyWith(
          _$BaseEventsListingStateFetched value,
          $Res Function(_$BaseEventsListingStateFetched) then) =
      __$$BaseEventsListingStateFetchedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Event> events, List<Event> filteredEvents});
}

/// @nodoc
class __$$BaseEventsListingStateFetchedCopyWithImpl<$Res>
    extends _$BaseEventsListingStateCopyWithImpl<$Res,
        _$BaseEventsListingStateFetched>
    implements _$$BaseEventsListingStateFetchedCopyWith<$Res> {
  __$$BaseEventsListingStateFetchedCopyWithImpl(
      _$BaseEventsListingStateFetched _value,
      $Res Function(_$BaseEventsListingStateFetched) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? events = null,
    Object? filteredEvents = null,
  }) {
    return _then(_$BaseEventsListingStateFetched(
      events: null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<Event>,
      filteredEvents: null == filteredEvents
          ? _value._filteredEvents
          : filteredEvents // ignore: cast_nullable_to_non_nullable
              as List<Event>,
    ));
  }
}

/// @nodoc

class _$BaseEventsListingStateFetched extends BaseEventsListingStateFetched {
  _$BaseEventsListingStateFetched(
      {required final List<Event> events,
      required final List<Event> filteredEvents})
      : _events = events,
        _filteredEvents = filteredEvents,
        super._();

  final List<Event> _events;
  @override
  List<Event> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  final List<Event> _filteredEvents;
  @override
  List<Event> get filteredEvents {
    if (_filteredEvents is EqualUnmodifiableListView) return _filteredEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredEvents);
  }

  @override
  String toString() {
    return 'BaseEventsListingState.fetched(events: $events, filteredEvents: $filteredEvents)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseEventsListingStateFetched &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            const DeepCollectionEquality()
                .equals(other._filteredEvents, _filteredEvents));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_events),
      const DeepCollectionEquality().hash(_filteredEvents));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseEventsListingStateFetchedCopyWith<_$BaseEventsListingStateFetched>
      get copyWith => __$$BaseEventsListingStateFetchedCopyWithImpl<
          _$BaseEventsListingStateFetched>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Event> events, List<Event> filteredEvents)
        fetched,
    required TResult Function() failure,
  }) {
    return fetched(events, filteredEvents);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Event> events, List<Event> filteredEvents)? fetched,
    TResult? Function()? failure,
  }) {
    return fetched?.call(events, filteredEvents);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Event> events, List<Event> filteredEvents)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(events, filteredEvents);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BaseEventsListingStateLoading value) loading,
    required TResult Function(BaseEventsListingStateFetched value) fetched,
    required TResult Function(BaseEventsListingStateFailure value) failure,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BaseEventsListingStateLoading value)? loading,
    TResult? Function(BaseEventsListingStateFetched value)? fetched,
    TResult? Function(BaseEventsListingStateFailure value)? failure,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseEventsListingStateLoading value)? loading,
    TResult Function(BaseEventsListingStateFetched value)? fetched,
    TResult Function(BaseEventsListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class BaseEventsListingStateFetched extends BaseEventsListingState {
  factory BaseEventsListingStateFetched(
          {required final List<Event> events,
          required final List<Event> filteredEvents}) =
      _$BaseEventsListingStateFetched;
  BaseEventsListingStateFetched._() : super._();

  List<Event> get events;
  List<Event> get filteredEvents;
  @JsonKey(ignore: true)
  _$$BaseEventsListingStateFetchedCopyWith<_$BaseEventsListingStateFetched>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BaseEventsListingStateFailureCopyWith<$Res> {
  factory _$$BaseEventsListingStateFailureCopyWith(
          _$BaseEventsListingStateFailure value,
          $Res Function(_$BaseEventsListingStateFailure) then) =
      __$$BaseEventsListingStateFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BaseEventsListingStateFailureCopyWithImpl<$Res>
    extends _$BaseEventsListingStateCopyWithImpl<$Res,
        _$BaseEventsListingStateFailure>
    implements _$$BaseEventsListingStateFailureCopyWith<$Res> {
  __$$BaseEventsListingStateFailureCopyWithImpl(
      _$BaseEventsListingStateFailure _value,
      $Res Function(_$BaseEventsListingStateFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BaseEventsListingStateFailure extends BaseEventsListingStateFailure {
  _$BaseEventsListingStateFailure() : super._();

  @override
  String toString() {
    return 'BaseEventsListingState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseEventsListingStateFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Event> events, List<Event> filteredEvents)
        fetched,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Event> events, List<Event> filteredEvents)? fetched,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Event> events, List<Event> filteredEvents)? fetched,
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
    required TResult Function(BaseEventsListingStateLoading value) loading,
    required TResult Function(BaseEventsListingStateFetched value) fetched,
    required TResult Function(BaseEventsListingStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BaseEventsListingStateLoading value)? loading,
    TResult? Function(BaseEventsListingStateFetched value)? fetched,
    TResult? Function(BaseEventsListingStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseEventsListingStateLoading value)? loading,
    TResult Function(BaseEventsListingStateFetched value)? fetched,
    TResult Function(BaseEventsListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class BaseEventsListingStateFailure extends BaseEventsListingState {
  factory BaseEventsListingStateFailure() = _$BaseEventsListingStateFailure;
  BaseEventsListingStateFailure._() : super._();
}

/// @nodoc
mixin _$BaseEventsListingEvent {
  EventTimeFilter? get eventTimeFilter => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(EventTimeFilter? eventTimeFilter) fetch,
    required TResult Function(EventTimeFilter? eventTimeFilter) filter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(EventTimeFilter? eventTimeFilter)? fetch,
    TResult? Function(EventTimeFilter? eventTimeFilter)? filter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(EventTimeFilter? eventTimeFilter)? fetch,
    TResult Function(EventTimeFilter? eventTimeFilter)? filter,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BaseEventsListingEventFetch value) fetch,
    required TResult Function(BaseEventsListingEventFilter value) filter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BaseEventsListingEventFetch value)? fetch,
    TResult? Function(BaseEventsListingEventFilter value)? filter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseEventsListingEventFetch value)? fetch,
    TResult Function(BaseEventsListingEventFilter value)? filter,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BaseEventsListingEventCopyWith<BaseEventsListingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseEventsListingEventCopyWith<$Res> {
  factory $BaseEventsListingEventCopyWith(BaseEventsListingEvent value,
          $Res Function(BaseEventsListingEvent) then) =
      _$BaseEventsListingEventCopyWithImpl<$Res, BaseEventsListingEvent>;
  @useResult
  $Res call({EventTimeFilter? eventTimeFilter});
}

/// @nodoc
class _$BaseEventsListingEventCopyWithImpl<$Res,
        $Val extends BaseEventsListingEvent>
    implements $BaseEventsListingEventCopyWith<$Res> {
  _$BaseEventsListingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventTimeFilter = freezed,
  }) {
    return _then(_value.copyWith(
      eventTimeFilter: freezed == eventTimeFilter
          ? _value.eventTimeFilter
          : eventTimeFilter // ignore: cast_nullable_to_non_nullable
              as EventTimeFilter?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BaseEventsListingEventFetchCopyWith<$Res>
    implements $BaseEventsListingEventCopyWith<$Res> {
  factory _$$BaseEventsListingEventFetchCopyWith(
          _$BaseEventsListingEventFetch value,
          $Res Function(_$BaseEventsListingEventFetch) then) =
      __$$BaseEventsListingEventFetchCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({EventTimeFilter? eventTimeFilter});
}

/// @nodoc
class __$$BaseEventsListingEventFetchCopyWithImpl<$Res>
    extends _$BaseEventsListingEventCopyWithImpl<$Res,
        _$BaseEventsListingEventFetch>
    implements _$$BaseEventsListingEventFetchCopyWith<$Res> {
  __$$BaseEventsListingEventFetchCopyWithImpl(
      _$BaseEventsListingEventFetch _value,
      $Res Function(_$BaseEventsListingEventFetch) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventTimeFilter = freezed,
  }) {
    return _then(_$BaseEventsListingEventFetch(
      eventTimeFilter: freezed == eventTimeFilter
          ? _value.eventTimeFilter
          : eventTimeFilter // ignore: cast_nullable_to_non_nullable
              as EventTimeFilter?,
    ));
  }
}

/// @nodoc

class _$BaseEventsListingEventFetch implements BaseEventsListingEventFetch {
  _$BaseEventsListingEventFetch({this.eventTimeFilter});

  @override
  final EventTimeFilter? eventTimeFilter;

  @override
  String toString() {
    return 'BaseEventsListingEvent.fetch(eventTimeFilter: $eventTimeFilter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseEventsListingEventFetch &&
            (identical(other.eventTimeFilter, eventTimeFilter) ||
                other.eventTimeFilter == eventTimeFilter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, eventTimeFilter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseEventsListingEventFetchCopyWith<_$BaseEventsListingEventFetch>
      get copyWith => __$$BaseEventsListingEventFetchCopyWithImpl<
          _$BaseEventsListingEventFetch>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(EventTimeFilter? eventTimeFilter) fetch,
    required TResult Function(EventTimeFilter? eventTimeFilter) filter,
  }) {
    return fetch(eventTimeFilter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(EventTimeFilter? eventTimeFilter)? fetch,
    TResult? Function(EventTimeFilter? eventTimeFilter)? filter,
  }) {
    return fetch?.call(eventTimeFilter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(EventTimeFilter? eventTimeFilter)? fetch,
    TResult Function(EventTimeFilter? eventTimeFilter)? filter,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(eventTimeFilter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BaseEventsListingEventFetch value) fetch,
    required TResult Function(BaseEventsListingEventFilter value) filter,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BaseEventsListingEventFetch value)? fetch,
    TResult? Function(BaseEventsListingEventFilter value)? filter,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseEventsListingEventFetch value)? fetch,
    TResult Function(BaseEventsListingEventFilter value)? filter,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class BaseEventsListingEventFetch implements BaseEventsListingEvent {
  factory BaseEventsListingEventFetch(
      {final EventTimeFilter? eventTimeFilter}) = _$BaseEventsListingEventFetch;

  @override
  EventTimeFilter? get eventTimeFilter;
  @override
  @JsonKey(ignore: true)
  _$$BaseEventsListingEventFetchCopyWith<_$BaseEventsListingEventFetch>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BaseEventsListingEventFilterCopyWith<$Res>
    implements $BaseEventsListingEventCopyWith<$Res> {
  factory _$$BaseEventsListingEventFilterCopyWith(
          _$BaseEventsListingEventFilter value,
          $Res Function(_$BaseEventsListingEventFilter) then) =
      __$$BaseEventsListingEventFilterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({EventTimeFilter? eventTimeFilter});
}

/// @nodoc
class __$$BaseEventsListingEventFilterCopyWithImpl<$Res>
    extends _$BaseEventsListingEventCopyWithImpl<$Res,
        _$BaseEventsListingEventFilter>
    implements _$$BaseEventsListingEventFilterCopyWith<$Res> {
  __$$BaseEventsListingEventFilterCopyWithImpl(
      _$BaseEventsListingEventFilter _value,
      $Res Function(_$BaseEventsListingEventFilter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventTimeFilter = freezed,
  }) {
    return _then(_$BaseEventsListingEventFilter(
      eventTimeFilter: freezed == eventTimeFilter
          ? _value.eventTimeFilter
          : eventTimeFilter // ignore: cast_nullable_to_non_nullable
              as EventTimeFilter?,
    ));
  }
}

/// @nodoc

class _$BaseEventsListingEventFilter implements BaseEventsListingEventFilter {
  _$BaseEventsListingEventFilter({this.eventTimeFilter});

  @override
  final EventTimeFilter? eventTimeFilter;

  @override
  String toString() {
    return 'BaseEventsListingEvent.filter(eventTimeFilter: $eventTimeFilter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseEventsListingEventFilter &&
            (identical(other.eventTimeFilter, eventTimeFilter) ||
                other.eventTimeFilter == eventTimeFilter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, eventTimeFilter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseEventsListingEventFilterCopyWith<_$BaseEventsListingEventFilter>
      get copyWith => __$$BaseEventsListingEventFilterCopyWithImpl<
          _$BaseEventsListingEventFilter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(EventTimeFilter? eventTimeFilter) fetch,
    required TResult Function(EventTimeFilter? eventTimeFilter) filter,
  }) {
    return filter(eventTimeFilter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(EventTimeFilter? eventTimeFilter)? fetch,
    TResult? Function(EventTimeFilter? eventTimeFilter)? filter,
  }) {
    return filter?.call(eventTimeFilter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(EventTimeFilter? eventTimeFilter)? fetch,
    TResult Function(EventTimeFilter? eventTimeFilter)? filter,
    required TResult orElse(),
  }) {
    if (filter != null) {
      return filter(eventTimeFilter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BaseEventsListingEventFetch value) fetch,
    required TResult Function(BaseEventsListingEventFilter value) filter,
  }) {
    return filter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BaseEventsListingEventFetch value)? fetch,
    TResult? Function(BaseEventsListingEventFilter value)? filter,
  }) {
    return filter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseEventsListingEventFetch value)? fetch,
    TResult Function(BaseEventsListingEventFilter value)? filter,
    required TResult orElse(),
  }) {
    if (filter != null) {
      return filter(this);
    }
    return orElse();
  }
}

abstract class BaseEventsListingEventFilter implements BaseEventsListingEvent {
  factory BaseEventsListingEventFilter(
          {final EventTimeFilter? eventTimeFilter}) =
      _$BaseEventsListingEventFilter;

  @override
  EventTimeFilter? get eventTimeFilter;
  @override
  @JsonKey(ignore: true)
  _$$BaseEventsListingEventFilterCopyWith<_$BaseEventsListingEventFilter>
      get copyWith => throw _privateConstructorUsedError;
}
