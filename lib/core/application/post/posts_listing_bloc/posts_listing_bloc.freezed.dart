// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'posts_listing_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PostsListingState {
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
    required TResult Function(PostsListingStateLoading value) loading,
    required TResult Function(PostsListingStateFetched value) fetched,
    required TResult Function(PostsListingStateFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostsListingStateLoading value)? loading,
    TResult? Function(PostsListingStateFetched value)? fetched,
    TResult? Function(PostsListingStateFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostsListingStateLoading value)? loading,
    TResult Function(PostsListingStateFetched value)? fetched,
    TResult Function(PostsListingStateFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostsListingStateCopyWith<$Res> {
  factory $PostsListingStateCopyWith(
          PostsListingState value, $Res Function(PostsListingState) then) =
      _$PostsListingStateCopyWithImpl<$Res, PostsListingState>;
}

/// @nodoc
class _$PostsListingStateCopyWithImpl<$Res, $Val extends PostsListingState>
    implements $PostsListingStateCopyWith<$Res> {
  _$PostsListingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$PostsListingStateLoadingCopyWith<$Res> {
  factory _$$PostsListingStateLoadingCopyWith(_$PostsListingStateLoading value,
          $Res Function(_$PostsListingStateLoading) then) =
      __$$PostsListingStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PostsListingStateLoadingCopyWithImpl<$Res>
    extends _$PostsListingStateCopyWithImpl<$Res, _$PostsListingStateLoading>
    implements _$$PostsListingStateLoadingCopyWith<$Res> {
  __$$PostsListingStateLoadingCopyWithImpl(_$PostsListingStateLoading _value,
      $Res Function(_$PostsListingStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PostsListingStateLoading implements PostsListingStateLoading {
  _$PostsListingStateLoading();

  @override
  String toString() {
    return 'PostsListingState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostsListingStateLoading);
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
    required TResult Function(PostsListingStateLoading value) loading,
    required TResult Function(PostsListingStateFetched value) fetched,
    required TResult Function(PostsListingStateFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostsListingStateLoading value)? loading,
    TResult? Function(PostsListingStateFetched value)? fetched,
    TResult? Function(PostsListingStateFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostsListingStateLoading value)? loading,
    TResult Function(PostsListingStateFetched value)? fetched,
    TResult Function(PostsListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PostsListingStateLoading implements PostsListingState {
  factory PostsListingStateLoading() = _$PostsListingStateLoading;
}

/// @nodoc
abstract class _$$PostsListingStateFetchedCopyWith<$Res> {
  factory _$$PostsListingStateFetchedCopyWith(_$PostsListingStateFetched value,
          $Res Function(_$PostsListingStateFetched) then) =
      __$$PostsListingStateFetchedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Post> posts});
}

/// @nodoc
class __$$PostsListingStateFetchedCopyWithImpl<$Res>
    extends _$PostsListingStateCopyWithImpl<$Res, _$PostsListingStateFetched>
    implements _$$PostsListingStateFetchedCopyWith<$Res> {
  __$$PostsListingStateFetchedCopyWithImpl(_$PostsListingStateFetched _value,
      $Res Function(_$PostsListingStateFetched) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
  }) {
    return _then(_$PostsListingStateFetched(
      posts: null == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
    ));
  }
}

/// @nodoc

class _$PostsListingStateFetched implements PostsListingStateFetched {
  _$PostsListingStateFetched({required final List<Post> posts})
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
    return 'PostsListingState.fetched(posts: $posts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostsListingStateFetched &&
            const DeepCollectionEquality().equals(other._posts, _posts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_posts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostsListingStateFetchedCopyWith<_$PostsListingStateFetched>
      get copyWith =>
          __$$PostsListingStateFetchedCopyWithImpl<_$PostsListingStateFetched>(
              this, _$identity);

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
    required TResult Function(PostsListingStateLoading value) loading,
    required TResult Function(PostsListingStateFetched value) fetched,
    required TResult Function(PostsListingStateFailure value) failure,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostsListingStateLoading value)? loading,
    TResult? Function(PostsListingStateFetched value)? fetched,
    TResult? Function(PostsListingStateFailure value)? failure,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostsListingStateLoading value)? loading,
    TResult Function(PostsListingStateFetched value)? fetched,
    TResult Function(PostsListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class PostsListingStateFetched implements PostsListingState {
  factory PostsListingStateFetched({required final List<Post> posts}) =
      _$PostsListingStateFetched;

  List<Post> get posts;
  @JsonKey(ignore: true)
  _$$PostsListingStateFetchedCopyWith<_$PostsListingStateFetched>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostsListingStateFailureCopyWith<$Res> {
  factory _$$PostsListingStateFailureCopyWith(_$PostsListingStateFailure value,
          $Res Function(_$PostsListingStateFailure) then) =
      __$$PostsListingStateFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PostsListingStateFailureCopyWithImpl<$Res>
    extends _$PostsListingStateCopyWithImpl<$Res, _$PostsListingStateFailure>
    implements _$$PostsListingStateFailureCopyWith<$Res> {
  __$$PostsListingStateFailureCopyWithImpl(_$PostsListingStateFailure _value,
      $Res Function(_$PostsListingStateFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PostsListingStateFailure implements PostsListingStateFailure {
  _$PostsListingStateFailure();

  @override
  String toString() {
    return 'PostsListingState.failure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostsListingStateFailure);
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
    required TResult Function(PostsListingStateLoading value) loading,
    required TResult Function(PostsListingStateFetched value) fetched,
    required TResult Function(PostsListingStateFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostsListingStateLoading value)? loading,
    TResult? Function(PostsListingStateFetched value)? fetched,
    TResult? Function(PostsListingStateFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostsListingStateLoading value)? loading,
    TResult Function(PostsListingStateFetched value)? fetched,
    TResult Function(PostsListingStateFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class PostsListingStateFailure implements PostsListingState {
  factory PostsListingStateFailure() = _$PostsListingStateFailure;
}

/// @nodoc
mixin _$PostsListingEvent {
  GetPostsInput? get input => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetPostsInput? input) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetPostsInput? input)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetPostsInput? input)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostsListingEventFetch value) fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostsListingEventFetch value)? fetch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostsListingEventFetch value)? fetch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PostsListingEventCopyWith<PostsListingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostsListingEventCopyWith<$Res> {
  factory $PostsListingEventCopyWith(
          PostsListingEvent value, $Res Function(PostsListingEvent) then) =
      _$PostsListingEventCopyWithImpl<$Res, PostsListingEvent>;
  @useResult
  $Res call({GetPostsInput? input});

  $GetPostsInputCopyWith<$Res>? get input;
}

/// @nodoc
class _$PostsListingEventCopyWithImpl<$Res, $Val extends PostsListingEvent>
    implements $PostsListingEventCopyWith<$Res> {
  _$PostsListingEventCopyWithImpl(this._value, this._then);

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
              as GetPostsInput?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GetPostsInputCopyWith<$Res>? get input {
    if (_value.input == null) {
      return null;
    }

    return $GetPostsInputCopyWith<$Res>(_value.input!, (value) {
      return _then(_value.copyWith(input: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostsListingEventFetchCopyWith<$Res>
    implements $PostsListingEventCopyWith<$Res> {
  factory _$$PostsListingEventFetchCopyWith(_$PostsListingEventFetch value,
          $Res Function(_$PostsListingEventFetch) then) =
      __$$PostsListingEventFetchCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GetPostsInput? input});

  @override
  $GetPostsInputCopyWith<$Res>? get input;
}

/// @nodoc
class __$$PostsListingEventFetchCopyWithImpl<$Res>
    extends _$PostsListingEventCopyWithImpl<$Res, _$PostsListingEventFetch>
    implements _$$PostsListingEventFetchCopyWith<$Res> {
  __$$PostsListingEventFetchCopyWithImpl(_$PostsListingEventFetch _value,
      $Res Function(_$PostsListingEventFetch) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? input = freezed,
  }) {
    return _then(_$PostsListingEventFetch(
      input: freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as GetPostsInput?,
    ));
  }
}

/// @nodoc

class _$PostsListingEventFetch implements PostsListingEventFetch {
  _$PostsListingEventFetch({this.input});

  @override
  final GetPostsInput? input;

  @override
  String toString() {
    return 'PostsListingEvent.fetch(input: $input)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostsListingEventFetch &&
            (identical(other.input, input) || other.input == input));
  }

  @override
  int get hashCode => Object.hash(runtimeType, input);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostsListingEventFetchCopyWith<_$PostsListingEventFetch> get copyWith =>
      __$$PostsListingEventFetchCopyWithImpl<_$PostsListingEventFetch>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetPostsInput? input) fetch,
  }) {
    return fetch(input);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetPostsInput? input)? fetch,
  }) {
    return fetch?.call(input);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetPostsInput? input)? fetch,
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
    required TResult Function(PostsListingEventFetch value) fetch,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostsListingEventFetch value)? fetch,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostsListingEventFetch value)? fetch,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class PostsListingEventFetch implements PostsListingEvent {
  factory PostsListingEventFetch({final GetPostsInput? input}) =
      _$PostsListingEventFetch;

  @override
  GetPostsInput? get input;
  @override
  @JsonKey(ignore: true)
  _$$PostsListingEventFetchCopyWith<_$PostsListingEventFetch> get copyWith =>
      throw _privateConstructorUsedError;
}
