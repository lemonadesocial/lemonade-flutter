// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'newsfeed_listing_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NewsfeedListingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Post> posts) fetched,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Post> posts)? fetched,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Post> posts)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewsfeedListingStateLoading value) loading,
    required TResult Function(NewsfeedListingStateFetched value) fetched,
    required TResult Function(NewsfeedListingStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsfeedListingStateLoading value)? loading,
    TResult? Function(NewsfeedListingStateFetched value)? fetched,
    TResult? Function(NewsfeedListingStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsfeedListingStateLoading value)? loading,
    TResult Function(NewsfeedListingStateFetched value)? fetched,
    TResult Function(NewsfeedListingStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsfeedListingStateCopyWith<$Res> {
  factory $NewsfeedListingStateCopyWith(NewsfeedListingState value,
          $Res Function(NewsfeedListingState) then) =
      _$NewsfeedListingStateCopyWithImpl<$Res, NewsfeedListingState>;
}

/// @nodoc
class _$NewsfeedListingStateCopyWithImpl<$Res,
        $Val extends NewsfeedListingState>
    implements $NewsfeedListingStateCopyWith<$Res> {
  _$NewsfeedListingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$NewsfeedListingStateLoadingCopyWith<$Res> {
  factory _$$NewsfeedListingStateLoadingCopyWith(
          _$NewsfeedListingStateLoading value,
          $Res Function(_$NewsfeedListingStateLoading) then) =
      __$$NewsfeedListingStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NewsfeedListingStateLoadingCopyWithImpl<$Res>
    extends _$NewsfeedListingStateCopyWithImpl<$Res,
        _$NewsfeedListingStateLoading>
    implements _$$NewsfeedListingStateLoadingCopyWith<$Res> {
  __$$NewsfeedListingStateLoadingCopyWithImpl(
      _$NewsfeedListingStateLoading _value,
      $Res Function(_$NewsfeedListingStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NewsfeedListingStateLoading implements NewsfeedListingStateLoading {
  _$NewsfeedListingStateLoading();

  @override
  String toString() {
    return 'NewsfeedListingState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsfeedListingStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Post> posts) fetched,
    required TResult Function() failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Post> posts)? fetched,
    TResult? Function()? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Post> posts)? fetched,
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
    required TResult Function(NewsfeedListingStateLoading value) loading,
    required TResult Function(NewsfeedListingStateFetched value) fetched,
    required TResult Function(NewsfeedListingStateFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsfeedListingStateLoading value)? loading,
    TResult? Function(NewsfeedListingStateFetched value)? fetched,
    TResult? Function(NewsfeedListingStateFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsfeedListingStateLoading value)? loading,
    TResult Function(NewsfeedListingStateFetched value)? fetched,
    TResult Function(NewsfeedListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class NewsfeedListingStateLoading implements NewsfeedListingState {
  factory NewsfeedListingStateLoading() = _$NewsfeedListingStateLoading;
}

/// @nodoc
abstract class _$$NewsfeedListingStateFetchedCopyWith<$Res> {
  factory _$$NewsfeedListingStateFetchedCopyWith(
          _$NewsfeedListingStateFetched value,
          $Res Function(_$NewsfeedListingStateFetched) then) =
      __$$NewsfeedListingStateFetchedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Post> posts});
}

/// @nodoc
class __$$NewsfeedListingStateFetchedCopyWithImpl<$Res>
    extends _$NewsfeedListingStateCopyWithImpl<$Res,
        _$NewsfeedListingStateFetched>
    implements _$$NewsfeedListingStateFetchedCopyWith<$Res> {
  __$$NewsfeedListingStateFetchedCopyWithImpl(
      _$NewsfeedListingStateFetched _value,
      $Res Function(_$NewsfeedListingStateFetched) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
  }) {
    return _then(_$NewsfeedListingStateFetched(
      posts: null == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
    ));
  }
}

/// @nodoc

class _$NewsfeedListingStateFetched implements NewsfeedListingStateFetched {
  _$NewsfeedListingStateFetched({required final List<Post> posts})
      : _posts = posts;

  final List<Post> _posts;
  @override
  List<Post> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  String toString() {
    return 'NewsfeedListingState.fetched(posts: $posts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsfeedListingStateFetched &&
            const DeepCollectionEquality().equals(other._posts, _posts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_posts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsfeedListingStateFetchedCopyWith<_$NewsfeedListingStateFetched>
      get copyWith => __$$NewsfeedListingStateFetchedCopyWithImpl<
          _$NewsfeedListingStateFetched>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Post> posts) fetched,
    required TResult Function() failure,
  }) {
    return fetched(posts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Post> posts)? fetched,
    TResult? Function()? failure,
  }) {
    return fetched?.call(posts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Post> posts)? fetched,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(posts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewsfeedListingStateLoading value) loading,
    required TResult Function(NewsfeedListingStateFetched value) fetched,
    required TResult Function(NewsfeedListingStateFailure value) failure,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsfeedListingStateLoading value)? loading,
    TResult? Function(NewsfeedListingStateFetched value)? fetched,
    TResult? Function(NewsfeedListingStateFailure value)? failure,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsfeedListingStateLoading value)? loading,
    TResult Function(NewsfeedListingStateFetched value)? fetched,
    TResult Function(NewsfeedListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class NewsfeedListingStateFetched implements NewsfeedListingState {
  factory NewsfeedListingStateFetched({required final List<Post> posts}) =
      _$NewsfeedListingStateFetched;

  List<Post> get posts;
  @JsonKey(ignore: true)
  _$$NewsfeedListingStateFetchedCopyWith<_$NewsfeedListingStateFetched>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NewsfeedListingStateFailureCopyWith<$Res> {
  factory _$$NewsfeedListingStateFailureCopyWith(
          _$NewsfeedListingStateFailure value,
          $Res Function(_$NewsfeedListingStateFailure) then) =
      __$$NewsfeedListingStateFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NewsfeedListingStateFailureCopyWithImpl<$Res>
    extends _$NewsfeedListingStateCopyWithImpl<$Res,
        _$NewsfeedListingStateFailure>
    implements _$$NewsfeedListingStateFailureCopyWith<$Res> {
  __$$NewsfeedListingStateFailureCopyWithImpl(
      _$NewsfeedListingStateFailure _value,
      $Res Function(_$NewsfeedListingStateFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NewsfeedListingStateFailure implements NewsfeedListingStateFailure {
  _$NewsfeedListingStateFailure();

  @override
  String toString() {
    return 'NewsfeedListingState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsfeedListingStateFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Post> posts) fetched,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Post> posts)? fetched,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Post> posts)? fetched,
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
    required TResult Function(NewsfeedListingStateLoading value) loading,
    required TResult Function(NewsfeedListingStateFetched value) fetched,
    required TResult Function(NewsfeedListingStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsfeedListingStateLoading value)? loading,
    TResult? Function(NewsfeedListingStateFetched value)? fetched,
    TResult? Function(NewsfeedListingStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsfeedListingStateLoading value)? loading,
    TResult Function(NewsfeedListingStateFetched value)? fetched,
    TResult Function(NewsfeedListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class NewsfeedListingStateFailure implements NewsfeedListingState {
  factory NewsfeedListingStateFailure() = _$NewsfeedListingStateFailure;
}

/// @nodoc
mixin _$NewsfeedListingEvent {
  int get offset => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int offset) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int offset)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int offset)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewsfeedListingEventFetch value) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsfeedListingEventFetch value)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsfeedListingEventFetch value)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewsfeedListingEventCopyWith<NewsfeedListingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsfeedListingEventCopyWith<$Res> {
  factory $NewsfeedListingEventCopyWith(NewsfeedListingEvent value,
          $Res Function(NewsfeedListingEvent) then) =
      _$NewsfeedListingEventCopyWithImpl<$Res, NewsfeedListingEvent>;
  @useResult
  $Res call({int offset});
}

/// @nodoc
class _$NewsfeedListingEventCopyWithImpl<$Res,
        $Val extends NewsfeedListingEvent>
    implements $NewsfeedListingEventCopyWith<$Res> {
  _$NewsfeedListingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = null,
  }) {
    return _then(_value.copyWith(
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsfeedListingEventFetchCopyWith<$Res>
    implements $NewsfeedListingEventCopyWith<$Res> {
  factory _$$NewsfeedListingEventFetchCopyWith(
          _$NewsfeedListingEventFetch value,
          $Res Function(_$NewsfeedListingEventFetch) then) =
      __$$NewsfeedListingEventFetchCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int offset});
}

/// @nodoc
class __$$NewsfeedListingEventFetchCopyWithImpl<$Res>
    extends _$NewsfeedListingEventCopyWithImpl<$Res,
        _$NewsfeedListingEventFetch>
    implements _$$NewsfeedListingEventFetchCopyWith<$Res> {
  __$$NewsfeedListingEventFetchCopyWithImpl(_$NewsfeedListingEventFetch _value,
      $Res Function(_$NewsfeedListingEventFetch) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = null,
  }) {
    return _then(_$NewsfeedListingEventFetch(
      null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$NewsfeedListingEventFetch implements NewsfeedListingEventFetch {
  _$NewsfeedListingEventFetch(this.offset);

  @override
  final int offset;

  @override
  String toString() {
    return 'NewsfeedListingEvent.fetch(offset: $offset)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsfeedListingEventFetch &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @override
  int get hashCode => Object.hash(runtimeType, offset);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsfeedListingEventFetchCopyWith<_$NewsfeedListingEventFetch>
      get copyWith => __$$NewsfeedListingEventFetchCopyWithImpl<
          _$NewsfeedListingEventFetch>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int offset) fetch,
  }) {
    return fetch(offset);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int offset)? fetch,
  }) {
    return fetch?.call(offset);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int offset)? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(offset);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewsfeedListingEventFetch value) fetch,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsfeedListingEventFetch value)? fetch,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsfeedListingEventFetch value)? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class NewsfeedListingEventFetch implements NewsfeedListingEvent {
  factory NewsfeedListingEventFetch(final int offset) =
      _$NewsfeedListingEventFetch;

  @override
  int get offset;
  @override
  @JsonKey(ignore: true)
  _$$NewsfeedListingEventFetchCopyWith<_$NewsfeedListingEventFetch>
      get copyWith => throw _privateConstructorUsedError;
}
