// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_listing_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NotificationsListingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Notification> notifications) fetched,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Notification> notifications)? fetched,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Notification> notifications)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationsListingStateLoading value) loading,
    required TResult Function(NotificationsListingStateFetched value) fetched,
    required TResult Function(NotificationsListingStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsListingStateLoading value)? loading,
    TResult? Function(NotificationsListingStateFetched value)? fetched,
    TResult? Function(NotificationsListingStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsListingStateLoading value)? loading,
    TResult Function(NotificationsListingStateFetched value)? fetched,
    TResult Function(NotificationsListingStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsListingStateCopyWith<$Res> {
  factory $NotificationsListingStateCopyWith(NotificationsListingState value,
          $Res Function(NotificationsListingState) then) =
      _$NotificationsListingStateCopyWithImpl<$Res, NotificationsListingState>;
}

/// @nodoc
class _$NotificationsListingStateCopyWithImpl<$Res,
        $Val extends NotificationsListingState>
    implements $NotificationsListingStateCopyWith<$Res> {
  _$NotificationsListingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$NotificationsListingStateLoadingCopyWith<$Res> {
  factory _$$NotificationsListingStateLoadingCopyWith(
          _$NotificationsListingStateLoading value,
          $Res Function(_$NotificationsListingStateLoading) then) =
      __$$NotificationsListingStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotificationsListingStateLoadingCopyWithImpl<$Res>
    extends _$NotificationsListingStateCopyWithImpl<$Res,
        _$NotificationsListingStateLoading>
    implements _$$NotificationsListingStateLoadingCopyWith<$Res> {
  __$$NotificationsListingStateLoadingCopyWithImpl(
      _$NotificationsListingStateLoading _value,
      $Res Function(_$NotificationsListingStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NotificationsListingStateLoading
    implements NotificationsListingStateLoading {
  _$NotificationsListingStateLoading();

  @override
  String toString() {
    return 'NotificationsListingState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsListingStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Notification> notifications) fetched,
    required TResult Function() failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Notification> notifications)? fetched,
    TResult? Function()? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Notification> notifications)? fetched,
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
    required TResult Function(NotificationsListingStateLoading value) loading,
    required TResult Function(NotificationsListingStateFetched value) fetched,
    required TResult Function(NotificationsListingStateFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsListingStateLoading value)? loading,
    TResult? Function(NotificationsListingStateFetched value)? fetched,
    TResult? Function(NotificationsListingStateFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsListingStateLoading value)? loading,
    TResult Function(NotificationsListingStateFetched value)? fetched,
    TResult Function(NotificationsListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class NotificationsListingStateLoading
    implements NotificationsListingState {
  factory NotificationsListingStateLoading() =
      _$NotificationsListingStateLoading;
}

/// @nodoc
abstract class _$$NotificationsListingStateFetchedCopyWith<$Res> {
  factory _$$NotificationsListingStateFetchedCopyWith(
          _$NotificationsListingStateFetched value,
          $Res Function(_$NotificationsListingStateFetched) then) =
      __$$NotificationsListingStateFetchedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Notification> notifications});
}

/// @nodoc
class __$$NotificationsListingStateFetchedCopyWithImpl<$Res>
    extends _$NotificationsListingStateCopyWithImpl<$Res,
        _$NotificationsListingStateFetched>
    implements _$$NotificationsListingStateFetchedCopyWith<$Res> {
  __$$NotificationsListingStateFetchedCopyWithImpl(
      _$NotificationsListingStateFetched _value,
      $Res Function(_$NotificationsListingStateFetched) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
  }) {
    return _then(_$NotificationsListingStateFetched(
      notifications: null == notifications
          ? _value._notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<Notification>,
    ));
  }
}

/// @nodoc

class _$NotificationsListingStateFetched
    implements NotificationsListingStateFetched {
  _$NotificationsListingStateFetched(
      {required final List<Notification> notifications})
      : _notifications = notifications;

  final List<Notification> _notifications;
  @override
  List<Notification> get notifications {
    if (_notifications is EqualUnmodifiableListView) return _notifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifications);
  }

  @override
  String toString() {
    return 'NotificationsListingState.fetched(notifications: $notifications)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsListingStateFetched &&
            const DeepCollectionEquality()
                .equals(other._notifications, _notifications));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_notifications));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsListingStateFetchedCopyWith<
          _$NotificationsListingStateFetched>
      get copyWith => __$$NotificationsListingStateFetchedCopyWithImpl<
          _$NotificationsListingStateFetched>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Notification> notifications) fetched,
    required TResult Function() failure,
  }) {
    return fetched(notifications);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Notification> notifications)? fetched,
    TResult? Function()? failure,
  }) {
    return fetched?.call(notifications);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Notification> notifications)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(notifications);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationsListingStateLoading value) loading,
    required TResult Function(NotificationsListingStateFetched value) fetched,
    required TResult Function(NotificationsListingStateFailure value) failure,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsListingStateLoading value)? loading,
    TResult? Function(NotificationsListingStateFetched value)? fetched,
    TResult? Function(NotificationsListingStateFailure value)? failure,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsListingStateLoading value)? loading,
    TResult Function(NotificationsListingStateFetched value)? fetched,
    TResult Function(NotificationsListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class NotificationsListingStateFetched
    implements NotificationsListingState {
  factory NotificationsListingStateFetched(
          {required final List<Notification> notifications}) =
      _$NotificationsListingStateFetched;

  List<Notification> get notifications;
  @JsonKey(ignore: true)
  _$$NotificationsListingStateFetchedCopyWith<
          _$NotificationsListingStateFetched>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotificationsListingStateFailureCopyWith<$Res> {
  factory _$$NotificationsListingStateFailureCopyWith(
          _$NotificationsListingStateFailure value,
          $Res Function(_$NotificationsListingStateFailure) then) =
      __$$NotificationsListingStateFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotificationsListingStateFailureCopyWithImpl<$Res>
    extends _$NotificationsListingStateCopyWithImpl<$Res,
        _$NotificationsListingStateFailure>
    implements _$$NotificationsListingStateFailureCopyWith<$Res> {
  __$$NotificationsListingStateFailureCopyWithImpl(
      _$NotificationsListingStateFailure _value,
      $Res Function(_$NotificationsListingStateFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NotificationsListingStateFailure
    implements NotificationsListingStateFailure {
  _$NotificationsListingStateFailure();

  @override
  String toString() {
    return 'NotificationsListingState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsListingStateFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Notification> notifications) fetched,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Notification> notifications)? fetched,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Notification> notifications)? fetched,
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
    required TResult Function(NotificationsListingStateLoading value) loading,
    required TResult Function(NotificationsListingStateFetched value) fetched,
    required TResult Function(NotificationsListingStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsListingStateLoading value)? loading,
    TResult? Function(NotificationsListingStateFetched value)? fetched,
    TResult? Function(NotificationsListingStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsListingStateLoading value)? loading,
    TResult Function(NotificationsListingStateFetched value)? fetched,
    TResult Function(NotificationsListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class NotificationsListingStateFailure
    implements NotificationsListingState {
  factory NotificationsListingStateFailure() =
      _$NotificationsListingStateFailure;
}

/// @nodoc
mixin _$NotificationsListingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationsListingEventFetch value) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsListingEventFetch value)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsListingEventFetch value)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsListingEventCopyWith<$Res> {
  factory $NotificationsListingEventCopyWith(NotificationsListingEvent value,
          $Res Function(NotificationsListingEvent) then) =
      _$NotificationsListingEventCopyWithImpl<$Res, NotificationsListingEvent>;
}

/// @nodoc
class _$NotificationsListingEventCopyWithImpl<$Res,
        $Val extends NotificationsListingEvent>
    implements $NotificationsListingEventCopyWith<$Res> {
  _$NotificationsListingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$NotificationsListingEventFetchCopyWith<$Res> {
  factory _$$NotificationsListingEventFetchCopyWith(
          _$NotificationsListingEventFetch value,
          $Res Function(_$NotificationsListingEventFetch) then) =
      __$$NotificationsListingEventFetchCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotificationsListingEventFetchCopyWithImpl<$Res>
    extends _$NotificationsListingEventCopyWithImpl<$Res,
        _$NotificationsListingEventFetch>
    implements _$$NotificationsListingEventFetchCopyWith<$Res> {
  __$$NotificationsListingEventFetchCopyWithImpl(
      _$NotificationsListingEventFetch _value,
      $Res Function(_$NotificationsListingEventFetch) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NotificationsListingEventFetch
    implements NotificationsListingEventFetch {
  _$NotificationsListingEventFetch();

  @override
  String toString() {
    return 'NotificationsListingEvent.fetch()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsListingEventFetch);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetch,
  }) {
    return fetch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetch,
  }) {
    return fetch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetch,
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
    required TResult Function(NotificationsListingEventFetch value) fetch,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsListingEventFetch value)? fetch,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsListingEventFetch value)? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class NotificationsListingEventFetch
    implements NotificationsListingEvent {
  factory NotificationsListingEventFetch() = _$NotificationsListingEventFetch;
}
