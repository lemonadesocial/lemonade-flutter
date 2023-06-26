// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'events_listing_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EventsListingState {
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
    required TResult Function(EventsListingStateLoading value) loading,
    required TResult Function(EventsListingStateFetched value) fetched,
    required TResult Function(EventsListingStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventsListingStateLoading value)? loading,
    TResult? Function(EventsListingStateFetched value)? fetched,
    TResult? Function(EventsListingStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventsListingStateLoading value)? loading,
    TResult Function(EventsListingStateFetched value)? fetched,
    TResult Function(EventsListingStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventsListingStateCopyWith<$Res> {
  factory $EventsListingStateCopyWith(
          EventsListingState value, $Res Function(EventsListingState) then) =
      _$EventsListingStateCopyWithImpl<$Res, EventsListingState>;
}

/// @nodoc
class _$EventsListingStateCopyWithImpl<$Res, $Val extends EventsListingState>
    implements $EventsListingStateCopyWith<$Res> {
  _$EventsListingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$EventsListingStateLoadingCopyWith<$Res> {
  factory _$$EventsListingStateLoadingCopyWith(
          _$EventsListingStateLoading value,
          $Res Function(_$EventsListingStateLoading) then) =
      __$$EventsListingStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EventsListingStateLoadingCopyWithImpl<$Res>
    extends _$EventsListingStateCopyWithImpl<$Res, _$EventsListingStateLoading>
    implements _$$EventsListingStateLoadingCopyWith<$Res> {
  __$$EventsListingStateLoadingCopyWithImpl(_$EventsListingStateLoading _value,
      $Res Function(_$EventsListingStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EventsListingStateLoading extends EventsListingStateLoading {
  _$EventsListingStateLoading() : super._();

  @override
  String toString() {
    return 'EventsListingState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventsListingStateLoading);
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
    required TResult Function(EventsListingStateLoading value) loading,
    required TResult Function(EventsListingStateFetched value) fetched,
    required TResult Function(EventsListingStateFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventsListingStateLoading value)? loading,
    TResult? Function(EventsListingStateFetched value)? fetched,
    TResult? Function(EventsListingStateFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventsListingStateLoading value)? loading,
    TResult Function(EventsListingStateFetched value)? fetched,
    TResult Function(EventsListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class EventsListingStateLoading extends EventsListingState {
  factory EventsListingStateLoading() = _$EventsListingStateLoading;
  EventsListingStateLoading._() : super._();
}

/// @nodoc
abstract class _$$EventsListingStateFetchedCopyWith<$Res> {
  factory _$$EventsListingStateFetchedCopyWith(
          _$EventsListingStateFetched value,
          $Res Function(_$EventsListingStateFetched) then) =
      __$$EventsListingStateFetchedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Event> events, List<Event> filteredEvents});
}

/// @nodoc
class __$$EventsListingStateFetchedCopyWithImpl<$Res>
    extends _$EventsListingStateCopyWithImpl<$Res, _$EventsListingStateFetched>
    implements _$$EventsListingStateFetchedCopyWith<$Res> {
  __$$EventsListingStateFetchedCopyWithImpl(_$EventsListingStateFetched _value,
      $Res Function(_$EventsListingStateFetched) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? events = null,
    Object? filteredEvents = null,
  }) {
    return _then(_$EventsListingStateFetched(
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

class _$EventsListingStateFetched extends EventsListingStateFetched {
  _$EventsListingStateFetched(
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
    return 'EventsListingState.fetched(events: $events, filteredEvents: $filteredEvents)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventsListingStateFetched &&
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
  _$$EventsListingStateFetchedCopyWith<_$EventsListingStateFetched>
      get copyWith => __$$EventsListingStateFetchedCopyWithImpl<
          _$EventsListingStateFetched>(this, _$identity);

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
    required TResult Function(EventsListingStateLoading value) loading,
    required TResult Function(EventsListingStateFetched value) fetched,
    required TResult Function(EventsListingStateFailure value) failure,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventsListingStateLoading value)? loading,
    TResult? Function(EventsListingStateFetched value)? fetched,
    TResult? Function(EventsListingStateFailure value)? failure,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventsListingStateLoading value)? loading,
    TResult Function(EventsListingStateFetched value)? fetched,
    TResult Function(EventsListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class EventsListingStateFetched extends EventsListingState {
  factory EventsListingStateFetched(
      {required final List<Event> events,
      required final List<Event> filteredEvents}) = _$EventsListingStateFetched;
  EventsListingStateFetched._() : super._();

  List<Event> get events;
  List<Event> get filteredEvents;
  @JsonKey(ignore: true)
  _$$EventsListingStateFetchedCopyWith<_$EventsListingStateFetched>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EventsListingStateFailureCopyWith<$Res> {
  factory _$$EventsListingStateFailureCopyWith(
          _$EventsListingStateFailure value,
          $Res Function(_$EventsListingStateFailure) then) =
      __$$EventsListingStateFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EventsListingStateFailureCopyWithImpl<$Res>
    extends _$EventsListingStateCopyWithImpl<$Res, _$EventsListingStateFailure>
    implements _$$EventsListingStateFailureCopyWith<$Res> {
  __$$EventsListingStateFailureCopyWithImpl(_$EventsListingStateFailure _value,
      $Res Function(_$EventsListingStateFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EventsListingStateFailure extends EventsListingStateFailure {
  _$EventsListingStateFailure() : super._();

  @override
  String toString() {
    return 'EventsListingState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventsListingStateFailure);
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
    required TResult Function(EventsListingStateLoading value) loading,
    required TResult Function(EventsListingStateFetched value) fetched,
    required TResult Function(EventsListingStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventsListingStateLoading value)? loading,
    TResult? Function(EventsListingStateFetched value)? fetched,
    TResult? Function(EventsListingStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventsListingStateLoading value)? loading,
    TResult Function(EventsListingStateFetched value)? fetched,
    TResult Function(EventsListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class EventsListingStateFailure extends EventsListingState {
  factory EventsListingStateFailure() = _$EventsListingStateFailure;
  EventsListingStateFailure._() : super._();
}

/// @nodoc
mixin _$EventsListingEvent {
  EventTimeFilter? get eventTimeFilter => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(EventListingType? eventListingType,
            EventTimeFilter? eventTimeFilter, String? userId)
        fetch,
    required TResult Function(EventTimeFilter? eventTimeFilter) filter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(EventListingType? eventListingType,
            EventTimeFilter? eventTimeFilter, String? userId)?
        fetch,
    TResult? Function(EventTimeFilter? eventTimeFilter)? filter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(EventListingType? eventListingType,
            EventTimeFilter? eventTimeFilter, String? userId)?
        fetch,
    TResult Function(EventTimeFilter? eventTimeFilter)? filter,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventsListingEventFetch value) fetch,
    required TResult Function(EventsListingEventFilter value) filter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventsListingEventFetch value)? fetch,
    TResult? Function(EventsListingEventFilter value)? filter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventsListingEventFetch value)? fetch,
    TResult Function(EventsListingEventFilter value)? filter,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EventsListingEventCopyWith<EventsListingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventsListingEventCopyWith<$Res> {
  factory $EventsListingEventCopyWith(
          EventsListingEvent value, $Res Function(EventsListingEvent) then) =
      _$EventsListingEventCopyWithImpl<$Res, EventsListingEvent>;
  @useResult
  $Res call({EventTimeFilter? eventTimeFilter});
}

/// @nodoc
class _$EventsListingEventCopyWithImpl<$Res, $Val extends EventsListingEvent>
    implements $EventsListingEventCopyWith<$Res> {
  _$EventsListingEventCopyWithImpl(this._value, this._then);

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
abstract class _$$EventsListingEventFetchCopyWith<$Res>
    implements $EventsListingEventCopyWith<$Res> {
  factory _$$EventsListingEventFetchCopyWith(_$EventsListingEventFetch value,
          $Res Function(_$EventsListingEventFetch) then) =
      __$$EventsListingEventFetchCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {EventListingType? eventListingType,
      EventTimeFilter? eventTimeFilter,
      String? userId});
}

/// @nodoc
class __$$EventsListingEventFetchCopyWithImpl<$Res>
    extends _$EventsListingEventCopyWithImpl<$Res, _$EventsListingEventFetch>
    implements _$$EventsListingEventFetchCopyWith<$Res> {
  __$$EventsListingEventFetchCopyWithImpl(_$EventsListingEventFetch _value,
      $Res Function(_$EventsListingEventFetch) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventListingType = freezed,
    Object? eventTimeFilter = freezed,
    Object? userId = freezed,
  }) {
    return _then(_$EventsListingEventFetch(
      eventListingType: freezed == eventListingType
          ? _value.eventListingType
          : eventListingType // ignore: cast_nullable_to_non_nullable
              as EventListingType?,
      eventTimeFilter: freezed == eventTimeFilter
          ? _value.eventTimeFilter
          : eventTimeFilter // ignore: cast_nullable_to_non_nullable
              as EventTimeFilter?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$EventsListingEventFetch implements EventsListingEventFetch {
  _$EventsListingEventFetch(
      {this.eventListingType, this.eventTimeFilter, this.userId});

  @override
  final EventListingType? eventListingType;
  @override
  final EventTimeFilter? eventTimeFilter;
  @override
  final String? userId;

  @override
  String toString() {
    return 'EventsListingEvent.fetch(eventListingType: $eventListingType, eventTimeFilter: $eventTimeFilter, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventsListingEventFetch &&
            (identical(other.eventListingType, eventListingType) ||
                other.eventListingType == eventListingType) &&
            (identical(other.eventTimeFilter, eventTimeFilter) ||
                other.eventTimeFilter == eventTimeFilter) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, eventListingType, eventTimeFilter, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventsListingEventFetchCopyWith<_$EventsListingEventFetch> get copyWith =>
      __$$EventsListingEventFetchCopyWithImpl<_$EventsListingEventFetch>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(EventListingType? eventListingType,
            EventTimeFilter? eventTimeFilter, String? userId)
        fetch,
    required TResult Function(EventTimeFilter? eventTimeFilter) filter,
  }) {
    return fetch(eventListingType, eventTimeFilter, userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(EventListingType? eventListingType,
            EventTimeFilter? eventTimeFilter, String? userId)?
        fetch,
    TResult? Function(EventTimeFilter? eventTimeFilter)? filter,
  }) {
    return fetch?.call(eventListingType, eventTimeFilter, userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(EventListingType? eventListingType,
            EventTimeFilter? eventTimeFilter, String? userId)?
        fetch,
    TResult Function(EventTimeFilter? eventTimeFilter)? filter,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(eventListingType, eventTimeFilter, userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventsListingEventFetch value) fetch,
    required TResult Function(EventsListingEventFilter value) filter,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventsListingEventFetch value)? fetch,
    TResult? Function(EventsListingEventFilter value)? filter,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventsListingEventFetch value)? fetch,
    TResult Function(EventsListingEventFilter value)? filter,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class EventsListingEventFetch implements EventsListingEvent {
  factory EventsListingEventFetch(
      {final EventListingType? eventListingType,
      final EventTimeFilter? eventTimeFilter,
      final String? userId}) = _$EventsListingEventFetch;

  EventListingType? get eventListingType;
  @override
  EventTimeFilter? get eventTimeFilter;
  String? get userId;
  @override
  @JsonKey(ignore: true)
  _$$EventsListingEventFetchCopyWith<_$EventsListingEventFetch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EventsListingEventFilterCopyWith<$Res>
    implements $EventsListingEventCopyWith<$Res> {
  factory _$$EventsListingEventFilterCopyWith(_$EventsListingEventFilter value,
          $Res Function(_$EventsListingEventFilter) then) =
      __$$EventsListingEventFilterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({EventTimeFilter? eventTimeFilter});
}

/// @nodoc
class __$$EventsListingEventFilterCopyWithImpl<$Res>
    extends _$EventsListingEventCopyWithImpl<$Res, _$EventsListingEventFilter>
    implements _$$EventsListingEventFilterCopyWith<$Res> {
  __$$EventsListingEventFilterCopyWithImpl(_$EventsListingEventFilter _value,
      $Res Function(_$EventsListingEventFilter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventTimeFilter = freezed,
  }) {
    return _then(_$EventsListingEventFilter(
      eventTimeFilter: freezed == eventTimeFilter
          ? _value.eventTimeFilter
          : eventTimeFilter // ignore: cast_nullable_to_non_nullable
              as EventTimeFilter?,
    ));
  }
}

/// @nodoc

class _$EventsListingEventFilter implements EventsListingEventFilter {
  _$EventsListingEventFilter({this.eventTimeFilter});

  @override
  final EventTimeFilter? eventTimeFilter;

  @override
  String toString() {
    return 'EventsListingEvent.filter(eventTimeFilter: $eventTimeFilter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventsListingEventFilter &&
            (identical(other.eventTimeFilter, eventTimeFilter) ||
                other.eventTimeFilter == eventTimeFilter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, eventTimeFilter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventsListingEventFilterCopyWith<_$EventsListingEventFilter>
      get copyWith =>
          __$$EventsListingEventFilterCopyWithImpl<_$EventsListingEventFilter>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(EventListingType? eventListingType,
            EventTimeFilter? eventTimeFilter, String? userId)
        fetch,
    required TResult Function(EventTimeFilter? eventTimeFilter) filter,
  }) {
    return filter(eventTimeFilter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(EventListingType? eventListingType,
            EventTimeFilter? eventTimeFilter, String? userId)?
        fetch,
    TResult? Function(EventTimeFilter? eventTimeFilter)? filter,
  }) {
    return filter?.call(eventTimeFilter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(EventListingType? eventListingType,
            EventTimeFilter? eventTimeFilter, String? userId)?
        fetch,
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
    required TResult Function(EventsListingEventFetch value) fetch,
    required TResult Function(EventsListingEventFilter value) filter,
  }) {
    return filter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventsListingEventFetch value)? fetch,
    TResult? Function(EventsListingEventFilter value)? filter,
  }) {
    return filter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventsListingEventFetch value)? fetch,
    TResult Function(EventsListingEventFilter value)? filter,
    required TResult orElse(),
  }) {
    if (filter != null) {
      return filter(this);
    }
    return orElse();
  }
}

abstract class EventsListingEventFilter implements EventsListingEvent {
  factory EventsListingEventFilter({final EventTimeFilter? eventTimeFilter}) =
      _$EventsListingEventFilter;

  @override
  EventTimeFilter? get eventTimeFilter;
  @override
  @JsonKey(ignore: true)
  _$$EventsListingEventFilterCopyWith<_$EventsListingEventFilter>
      get copyWith => throw _privateConstructorUsedError;
}
