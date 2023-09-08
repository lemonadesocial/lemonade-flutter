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
  NewsfeedStatus get status => throw _privateConstructorUsedError;
  List<Post> get posts => throw _privateConstructorUsedError;
  bool get scrollToTopEvent => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewsfeedListingStateCopyWith<NewsfeedListingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsfeedListingStateCopyWith<$Res> {
  factory $NewsfeedListingStateCopyWith(NewsfeedListingState value,
          $Res Function(NewsfeedListingState) then) =
      _$NewsfeedListingStateCopyWithImpl<$Res, NewsfeedListingState>;
  @useResult
  $Res call({NewsfeedStatus status, List<Post> posts, bool scrollToTopEvent});
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? posts = null,
    Object? scrollToTopEvent = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NewsfeedStatus,
      posts: null == posts
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      scrollToTopEvent: null == scrollToTopEvent
          ? _value.scrollToTopEvent
          : scrollToTopEvent // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsfeedListingStatusCopyWith<$Res>
    implements $NewsfeedListingStateCopyWith<$Res> {
  factory _$$NewsfeedListingStatusCopyWith(_$NewsfeedListingStatus value,
          $Res Function(_$NewsfeedListingStatus) then) =
      __$$NewsfeedListingStatusCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({NewsfeedStatus status, List<Post> posts, bool scrollToTopEvent});
}

/// @nodoc
class __$$NewsfeedListingStatusCopyWithImpl<$Res>
    extends _$NewsfeedListingStateCopyWithImpl<$Res, _$NewsfeedListingStatus>
    implements _$$NewsfeedListingStatusCopyWith<$Res> {
  __$$NewsfeedListingStatusCopyWithImpl(_$NewsfeedListingStatus _value,
      $Res Function(_$NewsfeedListingStatus) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? posts = null,
    Object? scrollToTopEvent = null,
  }) {
    return _then(_$NewsfeedListingStatus(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NewsfeedStatus,
      posts: null == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      scrollToTopEvent: null == scrollToTopEvent
          ? _value.scrollToTopEvent
          : scrollToTopEvent // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NewsfeedListingStatus implements NewsfeedListingStatus {
  const _$NewsfeedListingStatus(
      {this.status = NewsfeedStatus.initial,
      final List<Post> posts = const [],
      this.scrollToTopEvent = false})
      : _posts = posts;

  @override
  @JsonKey()
  final NewsfeedStatus status;
  final List<Post> _posts;
  @override
  @JsonKey()
  List<Post> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  @JsonKey()
  final bool scrollToTopEvent;

  @override
  String toString() {
    return 'NewsfeedListingState(status: $status, posts: $posts, scrollToTopEvent: $scrollToTopEvent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsfeedListingStatus &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            (identical(other.scrollToTopEvent, scrollToTopEvent) ||
                other.scrollToTopEvent == scrollToTopEvent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_posts), scrollToTopEvent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsfeedListingStatusCopyWith<_$NewsfeedListingStatus> get copyWith =>
      __$$NewsfeedListingStatusCopyWithImpl<_$NewsfeedListingStatus>(
          this, _$identity);
}

abstract class NewsfeedListingStatus implements NewsfeedListingState {
  const factory NewsfeedListingStatus(
      {final NewsfeedStatus status,
      final List<Post> posts,
      final bool scrollToTopEvent}) = _$NewsfeedListingStatus;

  @override
  NewsfeedStatus get status;
  @override
  List<Post> get posts;
  @override
  bool get scrollToTopEvent;
  @override
  @JsonKey(ignore: true)
  _$$NewsfeedListingStatusCopyWith<_$NewsfeedListingStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NewsfeedListingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetNewsfeedInput? input) fetch,
    required TResult Function(GetNewsfeedInput? input) refresh,
    required TResult Function(Post post) newPostAdded,
    required TResult Function(bool scrollToTopEvent) scrollToTop,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetNewsfeedInput? input)? fetch,
    TResult? Function(GetNewsfeedInput? input)? refresh,
    TResult? Function(Post post)? newPostAdded,
    TResult? Function(bool scrollToTopEvent)? scrollToTop,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetNewsfeedInput? input)? fetch,
    TResult Function(GetNewsfeedInput? input)? refresh,
    TResult Function(Post post)? newPostAdded,
    TResult Function(bool scrollToTopEvent)? scrollToTop,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewsfeedListingEventFetch value) fetch,
    required TResult Function(NewsfeedListingEventRefresh value) refresh,
    required TResult Function(NewsfeedListingEventNewPost value) newPostAdded,
    required TResult Function(NewsfeedListingEventScrollTop value) scrollToTop,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsfeedListingEventFetch value)? fetch,
    TResult? Function(NewsfeedListingEventRefresh value)? refresh,
    TResult? Function(NewsfeedListingEventNewPost value)? newPostAdded,
    TResult? Function(NewsfeedListingEventScrollTop value)? scrollToTop,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsfeedListingEventFetch value)? fetch,
    TResult Function(NewsfeedListingEventRefresh value)? refresh,
    TResult Function(NewsfeedListingEventNewPost value)? newPostAdded,
    TResult Function(NewsfeedListingEventScrollTop value)? scrollToTop,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsfeedListingEventCopyWith<$Res> {
  factory $NewsfeedListingEventCopyWith(NewsfeedListingEvent value,
          $Res Function(NewsfeedListingEvent) then) =
      _$NewsfeedListingEventCopyWithImpl<$Res, NewsfeedListingEvent>;
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
}

/// @nodoc
abstract class _$$NewsfeedListingEventFetchCopyWith<$Res> {
  factory _$$NewsfeedListingEventFetchCopyWith(
          _$NewsfeedListingEventFetch value,
          $Res Function(_$NewsfeedListingEventFetch) then) =
      __$$NewsfeedListingEventFetchCopyWithImpl<$Res>;
  @useResult
  $Res call({GetNewsfeedInput? input});

  $GetNewsfeedInputCopyWith<$Res>? get input;
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
    Object? input = freezed,
  }) {
    return _then(_$NewsfeedListingEventFetch(
      input: freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as GetNewsfeedInput?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $GetNewsfeedInputCopyWith<$Res>? get input {
    if (_value.input == null) {
      return null;
    }

    return $GetNewsfeedInputCopyWith<$Res>(_value.input!, (value) {
      return _then(_value.copyWith(input: value));
    });
  }
}

/// @nodoc

class _$NewsfeedListingEventFetch implements NewsfeedListingEventFetch {
  _$NewsfeedListingEventFetch({this.input});

  @override
  final GetNewsfeedInput? input;

  @override
  String toString() {
    return 'NewsfeedListingEvent.fetch(input: $input)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsfeedListingEventFetch &&
            (identical(other.input, input) || other.input == input));
  }

  @override
  int get hashCode => Object.hash(runtimeType, input);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsfeedListingEventFetchCopyWith<_$NewsfeedListingEventFetch>
      get copyWith => __$$NewsfeedListingEventFetchCopyWithImpl<
          _$NewsfeedListingEventFetch>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetNewsfeedInput? input) fetch,
    required TResult Function(GetNewsfeedInput? input) refresh,
    required TResult Function(Post post) newPostAdded,
    required TResult Function(bool scrollToTopEvent) scrollToTop,
  }) {
    return fetch(input);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetNewsfeedInput? input)? fetch,
    TResult? Function(GetNewsfeedInput? input)? refresh,
    TResult? Function(Post post)? newPostAdded,
    TResult? Function(bool scrollToTopEvent)? scrollToTop,
  }) {
    return fetch?.call(input);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetNewsfeedInput? input)? fetch,
    TResult Function(GetNewsfeedInput? input)? refresh,
    TResult Function(Post post)? newPostAdded,
    TResult Function(bool scrollToTopEvent)? scrollToTop,
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
    required TResult Function(NewsfeedListingEventFetch value) fetch,
    required TResult Function(NewsfeedListingEventRefresh value) refresh,
    required TResult Function(NewsfeedListingEventNewPost value) newPostAdded,
    required TResult Function(NewsfeedListingEventScrollTop value) scrollToTop,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsfeedListingEventFetch value)? fetch,
    TResult? Function(NewsfeedListingEventRefresh value)? refresh,
    TResult? Function(NewsfeedListingEventNewPost value)? newPostAdded,
    TResult? Function(NewsfeedListingEventScrollTop value)? scrollToTop,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsfeedListingEventFetch value)? fetch,
    TResult Function(NewsfeedListingEventRefresh value)? refresh,
    TResult Function(NewsfeedListingEventNewPost value)? newPostAdded,
    TResult Function(NewsfeedListingEventScrollTop value)? scrollToTop,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class NewsfeedListingEventFetch implements NewsfeedListingEvent {
  factory NewsfeedListingEventFetch({final GetNewsfeedInput? input}) =
      _$NewsfeedListingEventFetch;

  GetNewsfeedInput? get input;
  @JsonKey(ignore: true)
  _$$NewsfeedListingEventFetchCopyWith<_$NewsfeedListingEventFetch>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NewsfeedListingEventRefreshCopyWith<$Res> {
  factory _$$NewsfeedListingEventRefreshCopyWith(
          _$NewsfeedListingEventRefresh value,
          $Res Function(_$NewsfeedListingEventRefresh) then) =
      __$$NewsfeedListingEventRefreshCopyWithImpl<$Res>;
  @useResult
  $Res call({GetNewsfeedInput? input});

  $GetNewsfeedInputCopyWith<$Res>? get input;
}

/// @nodoc
class __$$NewsfeedListingEventRefreshCopyWithImpl<$Res>
    extends _$NewsfeedListingEventCopyWithImpl<$Res,
        _$NewsfeedListingEventRefresh>
    implements _$$NewsfeedListingEventRefreshCopyWith<$Res> {
  __$$NewsfeedListingEventRefreshCopyWithImpl(
      _$NewsfeedListingEventRefresh _value,
      $Res Function(_$NewsfeedListingEventRefresh) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? input = freezed,
  }) {
    return _then(_$NewsfeedListingEventRefresh(
      input: freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as GetNewsfeedInput?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $GetNewsfeedInputCopyWith<$Res>? get input {
    if (_value.input == null) {
      return null;
    }

    return $GetNewsfeedInputCopyWith<$Res>(_value.input!, (value) {
      return _then(_value.copyWith(input: value));
    });
  }
}

/// @nodoc

class _$NewsfeedListingEventRefresh implements NewsfeedListingEventRefresh {
  _$NewsfeedListingEventRefresh({this.input});

  @override
  final GetNewsfeedInput? input;

  @override
  String toString() {
    return 'NewsfeedListingEvent.refresh(input: $input)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsfeedListingEventRefresh &&
            (identical(other.input, input) || other.input == input));
  }

  @override
  int get hashCode => Object.hash(runtimeType, input);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsfeedListingEventRefreshCopyWith<_$NewsfeedListingEventRefresh>
      get copyWith => __$$NewsfeedListingEventRefreshCopyWithImpl<
          _$NewsfeedListingEventRefresh>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetNewsfeedInput? input) fetch,
    required TResult Function(GetNewsfeedInput? input) refresh,
    required TResult Function(Post post) newPostAdded,
    required TResult Function(bool scrollToTopEvent) scrollToTop,
  }) {
    return refresh(input);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetNewsfeedInput? input)? fetch,
    TResult? Function(GetNewsfeedInput? input)? refresh,
    TResult? Function(Post post)? newPostAdded,
    TResult? Function(bool scrollToTopEvent)? scrollToTop,
  }) {
    return refresh?.call(input);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetNewsfeedInput? input)? fetch,
    TResult Function(GetNewsfeedInput? input)? refresh,
    TResult Function(Post post)? newPostAdded,
    TResult Function(bool scrollToTopEvent)? scrollToTop,
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
    required TResult Function(NewsfeedListingEventFetch value) fetch,
    required TResult Function(NewsfeedListingEventRefresh value) refresh,
    required TResult Function(NewsfeedListingEventNewPost value) newPostAdded,
    required TResult Function(NewsfeedListingEventScrollTop value) scrollToTop,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsfeedListingEventFetch value)? fetch,
    TResult? Function(NewsfeedListingEventRefresh value)? refresh,
    TResult? Function(NewsfeedListingEventNewPost value)? newPostAdded,
    TResult? Function(NewsfeedListingEventScrollTop value)? scrollToTop,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsfeedListingEventFetch value)? fetch,
    TResult Function(NewsfeedListingEventRefresh value)? refresh,
    TResult Function(NewsfeedListingEventNewPost value)? newPostAdded,
    TResult Function(NewsfeedListingEventScrollTop value)? scrollToTop,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class NewsfeedListingEventRefresh implements NewsfeedListingEvent {
  factory NewsfeedListingEventRefresh({final GetNewsfeedInput? input}) =
      _$NewsfeedListingEventRefresh;

  GetNewsfeedInput? get input;
  @JsonKey(ignore: true)
  _$$NewsfeedListingEventRefreshCopyWith<_$NewsfeedListingEventRefresh>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NewsfeedListingEventNewPostCopyWith<$Res> {
  factory _$$NewsfeedListingEventNewPostCopyWith(
          _$NewsfeedListingEventNewPost value,
          $Res Function(_$NewsfeedListingEventNewPost) then) =
      __$$NewsfeedListingEventNewPostCopyWithImpl<$Res>;
  @useResult
  $Res call({Post post});
}

/// @nodoc
class __$$NewsfeedListingEventNewPostCopyWithImpl<$Res>
    extends _$NewsfeedListingEventCopyWithImpl<$Res,
        _$NewsfeedListingEventNewPost>
    implements _$$NewsfeedListingEventNewPostCopyWith<$Res> {
  __$$NewsfeedListingEventNewPostCopyWithImpl(
      _$NewsfeedListingEventNewPost _value,
      $Res Function(_$NewsfeedListingEventNewPost) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = null,
  }) {
    return _then(_$NewsfeedListingEventNewPost(
      post: null == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post,
    ));
  }
}

/// @nodoc

class _$NewsfeedListingEventNewPost implements NewsfeedListingEventNewPost {
  _$NewsfeedListingEventNewPost({required this.post});

  @override
  final Post post;

  @override
  String toString() {
    return 'NewsfeedListingEvent.newPostAdded(post: $post)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsfeedListingEventNewPost &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsfeedListingEventNewPostCopyWith<_$NewsfeedListingEventNewPost>
      get copyWith => __$$NewsfeedListingEventNewPostCopyWithImpl<
          _$NewsfeedListingEventNewPost>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetNewsfeedInput? input) fetch,
    required TResult Function(GetNewsfeedInput? input) refresh,
    required TResult Function(Post post) newPostAdded,
    required TResult Function(bool scrollToTopEvent) scrollToTop,
  }) {
    return newPostAdded(post);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetNewsfeedInput? input)? fetch,
    TResult? Function(GetNewsfeedInput? input)? refresh,
    TResult? Function(Post post)? newPostAdded,
    TResult? Function(bool scrollToTopEvent)? scrollToTop,
  }) {
    return newPostAdded?.call(post);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetNewsfeedInput? input)? fetch,
    TResult Function(GetNewsfeedInput? input)? refresh,
    TResult Function(Post post)? newPostAdded,
    TResult Function(bool scrollToTopEvent)? scrollToTop,
    required TResult orElse(),
  }) {
    if (newPostAdded != null) {
      return newPostAdded(post);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewsfeedListingEventFetch value) fetch,
    required TResult Function(NewsfeedListingEventRefresh value) refresh,
    required TResult Function(NewsfeedListingEventNewPost value) newPostAdded,
    required TResult Function(NewsfeedListingEventScrollTop value) scrollToTop,
  }) {
    return newPostAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsfeedListingEventFetch value)? fetch,
    TResult? Function(NewsfeedListingEventRefresh value)? refresh,
    TResult? Function(NewsfeedListingEventNewPost value)? newPostAdded,
    TResult? Function(NewsfeedListingEventScrollTop value)? scrollToTop,
  }) {
    return newPostAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsfeedListingEventFetch value)? fetch,
    TResult Function(NewsfeedListingEventRefresh value)? refresh,
    TResult Function(NewsfeedListingEventNewPost value)? newPostAdded,
    TResult Function(NewsfeedListingEventScrollTop value)? scrollToTop,
    required TResult orElse(),
  }) {
    if (newPostAdded != null) {
      return newPostAdded(this);
    }
    return orElse();
  }
}

abstract class NewsfeedListingEventNewPost implements NewsfeedListingEvent {
  factory NewsfeedListingEventNewPost({required final Post post}) =
      _$NewsfeedListingEventNewPost;

  Post get post;
  @JsonKey(ignore: true)
  _$$NewsfeedListingEventNewPostCopyWith<_$NewsfeedListingEventNewPost>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NewsfeedListingEventScrollTopCopyWith<$Res> {
  factory _$$NewsfeedListingEventScrollTopCopyWith(
          _$NewsfeedListingEventScrollTop value,
          $Res Function(_$NewsfeedListingEventScrollTop) then) =
      __$$NewsfeedListingEventScrollTopCopyWithImpl<$Res>;
  @useResult
  $Res call({bool scrollToTopEvent});
}

/// @nodoc
class __$$NewsfeedListingEventScrollTopCopyWithImpl<$Res>
    extends _$NewsfeedListingEventCopyWithImpl<$Res,
        _$NewsfeedListingEventScrollTop>
    implements _$$NewsfeedListingEventScrollTopCopyWith<$Res> {
  __$$NewsfeedListingEventScrollTopCopyWithImpl(
      _$NewsfeedListingEventScrollTop _value,
      $Res Function(_$NewsfeedListingEventScrollTop) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scrollToTopEvent = null,
  }) {
    return _then(_$NewsfeedListingEventScrollTop(
      scrollToTopEvent: null == scrollToTopEvent
          ? _value.scrollToTopEvent
          : scrollToTopEvent // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NewsfeedListingEventScrollTop implements NewsfeedListingEventScrollTop {
  _$NewsfeedListingEventScrollTop({required this.scrollToTopEvent});

  @override
  final bool scrollToTopEvent;

  @override
  String toString() {
    return 'NewsfeedListingEvent.scrollToTop(scrollToTopEvent: $scrollToTopEvent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsfeedListingEventScrollTop &&
            (identical(other.scrollToTopEvent, scrollToTopEvent) ||
                other.scrollToTopEvent == scrollToTopEvent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, scrollToTopEvent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsfeedListingEventScrollTopCopyWith<_$NewsfeedListingEventScrollTop>
      get copyWith => __$$NewsfeedListingEventScrollTopCopyWithImpl<
          _$NewsfeedListingEventScrollTop>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GetNewsfeedInput? input) fetch,
    required TResult Function(GetNewsfeedInput? input) refresh,
    required TResult Function(Post post) newPostAdded,
    required TResult Function(bool scrollToTopEvent) scrollToTop,
  }) {
    return scrollToTop(scrollToTopEvent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(GetNewsfeedInput? input)? fetch,
    TResult? Function(GetNewsfeedInput? input)? refresh,
    TResult? Function(Post post)? newPostAdded,
    TResult? Function(bool scrollToTopEvent)? scrollToTop,
  }) {
    return scrollToTop?.call(scrollToTopEvent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GetNewsfeedInput? input)? fetch,
    TResult Function(GetNewsfeedInput? input)? refresh,
    TResult Function(Post post)? newPostAdded,
    TResult Function(bool scrollToTopEvent)? scrollToTop,
    required TResult orElse(),
  }) {
    if (scrollToTop != null) {
      return scrollToTop(scrollToTopEvent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NewsfeedListingEventFetch value) fetch,
    required TResult Function(NewsfeedListingEventRefresh value) refresh,
    required TResult Function(NewsfeedListingEventNewPost value) newPostAdded,
    required TResult Function(NewsfeedListingEventScrollTop value) scrollToTop,
  }) {
    return scrollToTop(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NewsfeedListingEventFetch value)? fetch,
    TResult? Function(NewsfeedListingEventRefresh value)? refresh,
    TResult? Function(NewsfeedListingEventNewPost value)? newPostAdded,
    TResult? Function(NewsfeedListingEventScrollTop value)? scrollToTop,
  }) {
    return scrollToTop?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NewsfeedListingEventFetch value)? fetch,
    TResult Function(NewsfeedListingEventRefresh value)? refresh,
    TResult Function(NewsfeedListingEventNewPost value)? newPostAdded,
    TResult Function(NewsfeedListingEventScrollTop value)? scrollToTop,
    required TResult orElse(),
  }) {
    if (scrollToTop != null) {
      return scrollToTop(this);
    }
    return orElse();
  }
}

abstract class NewsfeedListingEventScrollTop implements NewsfeedListingEvent {
  factory NewsfeedListingEventScrollTop(
      {required final bool scrollToTopEvent}) = _$NewsfeedListingEventScrollTop;

  bool get scrollToTopEvent;
  @JsonKey(ignore: true)
  _$$NewsfeedListingEventScrollTopCopyWith<_$NewsfeedListingEventScrollTop>
      get copyWith => throw _privateConstructorUsedError;
}
