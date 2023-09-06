// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_event_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GetEventDetailEvent {
  String get eventId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String eventId) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String eventId)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String eventId)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetEventDetailEventFetch value) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetEventDetailEventFetch value)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetEventDetailEventFetch value)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GetEventDetailEventCopyWith<GetEventDetailEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetEventDetailEventCopyWith<$Res> {
  factory $GetEventDetailEventCopyWith(
          GetEventDetailEvent value, $Res Function(GetEventDetailEvent) then) =
      _$GetEventDetailEventCopyWithImpl<$Res, GetEventDetailEvent>;
  @useResult
  $Res call({String eventId});
}

/// @nodoc
class _$GetEventDetailEventCopyWithImpl<$Res, $Val extends GetEventDetailEvent>
    implements $GetEventDetailEventCopyWith<$Res> {
  _$GetEventDetailEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
  }) {
    return _then(_value.copyWith(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetEventDetailEventFetchCopyWith<$Res>
    implements $GetEventDetailEventCopyWith<$Res> {
  factory _$$GetEventDetailEventFetchCopyWith(_$GetEventDetailEventFetch value,
          $Res Function(_$GetEventDetailEventFetch) then) =
      __$$GetEventDetailEventFetchCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String eventId});
}

/// @nodoc
class __$$GetEventDetailEventFetchCopyWithImpl<$Res>
    extends _$GetEventDetailEventCopyWithImpl<$Res, _$GetEventDetailEventFetch>
    implements _$$GetEventDetailEventFetchCopyWith<$Res> {
  __$$GetEventDetailEventFetchCopyWithImpl(_$GetEventDetailEventFetch _value,
      $Res Function(_$GetEventDetailEventFetch) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = null,
  }) {
    return _then(_$GetEventDetailEventFetch(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetEventDetailEventFetch implements GetEventDetailEventFetch {
  const _$GetEventDetailEventFetch({required this.eventId});

  @override
  final String eventId;

  @override
  String toString() {
    return 'GetEventDetailEvent.fetch(eventId: $eventId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetEventDetailEventFetch &&
            (identical(other.eventId, eventId) || other.eventId == eventId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, eventId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetEventDetailEventFetchCopyWith<_$GetEventDetailEventFetch>
      get copyWith =>
          __$$GetEventDetailEventFetchCopyWithImpl<_$GetEventDetailEventFetch>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String eventId) fetch,
  }) {
    return fetch(eventId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String eventId)? fetch,
  }) {
    return fetch?.call(eventId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String eventId)? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(eventId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetEventDetailEventFetch value) fetch,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetEventDetailEventFetch value)? fetch,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetEventDetailEventFetch value)? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class GetEventDetailEventFetch implements GetEventDetailEvent {
  const factory GetEventDetailEventFetch({required final String eventId}) =
      _$GetEventDetailEventFetch;

  @override
  String get eventId;
  @override
  @JsonKey(ignore: true)
  _$$GetEventDetailEventFetchCopyWith<_$GetEventDetailEventFetch>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GetEventDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Event eventDetail) fetched,
    required TResult Function() loading,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Event eventDetail)? fetched,
    TResult? Function()? loading,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Event eventDetail)? fetched,
    TResult Function()? loading,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetEventDetailStateFetched value) fetched,
    required TResult Function(GetEventDetailStateLoading value) loading,
    required TResult Function(GetEventDetailStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetEventDetailStateFetched value)? fetched,
    TResult? Function(GetEventDetailStateLoading value)? loading,
    TResult? Function(GetEventDetailStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetEventDetailStateFetched value)? fetched,
    TResult Function(GetEventDetailStateLoading value)? loading,
    TResult Function(GetEventDetailStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetEventDetailStateCopyWith<$Res> {
  factory $GetEventDetailStateCopyWith(
          GetEventDetailState value, $Res Function(GetEventDetailState) then) =
      _$GetEventDetailStateCopyWithImpl<$Res, GetEventDetailState>;
}

/// @nodoc
class _$GetEventDetailStateCopyWithImpl<$Res, $Val extends GetEventDetailState>
    implements $GetEventDetailStateCopyWith<$Res> {
  _$GetEventDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GetEventDetailStateFetchedCopyWith<$Res> {
  factory _$$GetEventDetailStateFetchedCopyWith(
          _$GetEventDetailStateFetched value,
          $Res Function(_$GetEventDetailStateFetched) then) =
      __$$GetEventDetailStateFetchedCopyWithImpl<$Res>;
  @useResult
  $Res call({Event eventDetail});
}

/// @nodoc
class __$$GetEventDetailStateFetchedCopyWithImpl<$Res>
    extends _$GetEventDetailStateCopyWithImpl<$Res,
        _$GetEventDetailStateFetched>
    implements _$$GetEventDetailStateFetchedCopyWith<$Res> {
  __$$GetEventDetailStateFetchedCopyWithImpl(
      _$GetEventDetailStateFetched _value,
      $Res Function(_$GetEventDetailStateFetched) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventDetail = null,
  }) {
    return _then(_$GetEventDetailStateFetched(
      eventDetail: null == eventDetail
          ? _value.eventDetail
          : eventDetail // ignore: cast_nullable_to_non_nullable
              as Event,
    ));
  }
}

/// @nodoc

class _$GetEventDetailStateFetched implements GetEventDetailStateFetched {
  const _$GetEventDetailStateFetched({required this.eventDetail});

  @override
  final Event eventDetail;

  @override
  String toString() {
    return 'GetEventDetailState.fetched(eventDetail: $eventDetail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetEventDetailStateFetched &&
            (identical(other.eventDetail, eventDetail) ||
                other.eventDetail == eventDetail));
  }

  @override
  int get hashCode => Object.hash(runtimeType, eventDetail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetEventDetailStateFetchedCopyWith<_$GetEventDetailStateFetched>
      get copyWith => __$$GetEventDetailStateFetchedCopyWithImpl<
          _$GetEventDetailStateFetched>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Event eventDetail) fetched,
    required TResult Function() loading,
    required TResult Function() failure,
  }) {
    return fetched(eventDetail);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Event eventDetail)? fetched,
    TResult? Function()? loading,
    TResult? Function()? failure,
  }) {
    return fetched?.call(eventDetail);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Event eventDetail)? fetched,
    TResult Function()? loading,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(eventDetail);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetEventDetailStateFetched value) fetched,
    required TResult Function(GetEventDetailStateLoading value) loading,
    required TResult Function(GetEventDetailStateFailure value) failure,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetEventDetailStateFetched value)? fetched,
    TResult? Function(GetEventDetailStateLoading value)? loading,
    TResult? Function(GetEventDetailStateFailure value)? failure,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetEventDetailStateFetched value)? fetched,
    TResult Function(GetEventDetailStateLoading value)? loading,
    TResult Function(GetEventDetailStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class GetEventDetailStateFetched implements GetEventDetailState {
  const factory GetEventDetailStateFetched({required final Event eventDetail}) =
      _$GetEventDetailStateFetched;

  Event get eventDetail;
  @JsonKey(ignore: true)
  _$$GetEventDetailStateFetchedCopyWith<_$GetEventDetailStateFetched>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetEventDetailStateLoadingCopyWith<$Res> {
  factory _$$GetEventDetailStateLoadingCopyWith(
          _$GetEventDetailStateLoading value,
          $Res Function(_$GetEventDetailStateLoading) then) =
      __$$GetEventDetailStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetEventDetailStateLoadingCopyWithImpl<$Res>
    extends _$GetEventDetailStateCopyWithImpl<$Res,
        _$GetEventDetailStateLoading>
    implements _$$GetEventDetailStateLoadingCopyWith<$Res> {
  __$$GetEventDetailStateLoadingCopyWithImpl(
      _$GetEventDetailStateLoading _value,
      $Res Function(_$GetEventDetailStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetEventDetailStateLoading implements GetEventDetailStateLoading {
  const _$GetEventDetailStateLoading();

  @override
  String toString() {
    return 'GetEventDetailState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetEventDetailStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Event eventDetail) fetched,
    required TResult Function() loading,
    required TResult Function() failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Event eventDetail)? fetched,
    TResult? Function()? loading,
    TResult? Function()? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Event eventDetail)? fetched,
    TResult Function()? loading,
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
    required TResult Function(GetEventDetailStateFetched value) fetched,
    required TResult Function(GetEventDetailStateLoading value) loading,
    required TResult Function(GetEventDetailStateFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetEventDetailStateFetched value)? fetched,
    TResult? Function(GetEventDetailStateLoading value)? loading,
    TResult? Function(GetEventDetailStateFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetEventDetailStateFetched value)? fetched,
    TResult Function(GetEventDetailStateLoading value)? loading,
    TResult Function(GetEventDetailStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class GetEventDetailStateLoading implements GetEventDetailState {
  const factory GetEventDetailStateLoading() = _$GetEventDetailStateLoading;
}

/// @nodoc
abstract class _$$GetEventDetailStateFailureCopyWith<$Res> {
  factory _$$GetEventDetailStateFailureCopyWith(
          _$GetEventDetailStateFailure value,
          $Res Function(_$GetEventDetailStateFailure) then) =
      __$$GetEventDetailStateFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetEventDetailStateFailureCopyWithImpl<$Res>
    extends _$GetEventDetailStateCopyWithImpl<$Res,
        _$GetEventDetailStateFailure>
    implements _$$GetEventDetailStateFailureCopyWith<$Res> {
  __$$GetEventDetailStateFailureCopyWithImpl(
      _$GetEventDetailStateFailure _value,
      $Res Function(_$GetEventDetailStateFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetEventDetailStateFailure implements GetEventDetailStateFailure {
  const _$GetEventDetailStateFailure();

  @override
  String toString() {
    return 'GetEventDetailState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetEventDetailStateFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Event eventDetail) fetched,
    required TResult Function() loading,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Event eventDetail)? fetched,
    TResult? Function()? loading,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Event eventDetail)? fetched,
    TResult Function()? loading,
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
    required TResult Function(GetEventDetailStateFetched value) fetched,
    required TResult Function(GetEventDetailStateLoading value) loading,
    required TResult Function(GetEventDetailStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetEventDetailStateFetched value)? fetched,
    TResult? Function(GetEventDetailStateLoading value)? loading,
    TResult? Function(GetEventDetailStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetEventDetailStateFetched value)? fetched,
    TResult Function(GetEventDetailStateLoading value)? loading,
    TResult Function(GetEventDetailStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class GetEventDetailStateFailure implements GetEventDetailState {
  const factory GetEventDetailStateFailure() = _$GetEventDetailStateFailure;
}
