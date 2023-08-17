// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_post_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreatePostState {
  CreatePostStatus get status => throw _privateConstructorUsedError;
  PostPrivacy get postPrivacy => throw _privateConstructorUsedError;
  String? get postDescription => throw _privateConstructorUsedError;
  Event? get selectEvent => throw _privateConstructorUsedError;
  XFile? get uploadImage => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreatePostStateCopyWith<CreatePostState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePostStateCopyWith<$Res> {
  factory $CreatePostStateCopyWith(
          CreatePostState value, $Res Function(CreatePostState) then) =
      _$CreatePostStateCopyWithImpl<$Res, CreatePostState>;
  @useResult
  $Res call(
      {CreatePostStatus status,
      PostPrivacy postPrivacy,
      String? postDescription,
      Event? selectEvent,
      XFile? uploadImage,
      String? error});
}

/// @nodoc
class _$CreatePostStateCopyWithImpl<$Res, $Val extends CreatePostState>
    implements $CreatePostStateCopyWith<$Res> {
  _$CreatePostStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? postPrivacy = null,
    Object? postDescription = freezed,
    Object? selectEvent = freezed,
    Object? uploadImage = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CreatePostStatus,
      postPrivacy: null == postPrivacy
          ? _value.postPrivacy
          : postPrivacy // ignore: cast_nullable_to_non_nullable
              as PostPrivacy,
      postDescription: freezed == postDescription
          ? _value.postDescription
          : postDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      selectEvent: freezed == selectEvent
          ? _value.selectEvent
          : selectEvent // ignore: cast_nullable_to_non_nullable
              as Event?,
      uploadImage: freezed == uploadImage
          ? _value.uploadImage
          : uploadImage // ignore: cast_nullable_to_non_nullable
              as XFile?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreatePostStateCopyWith<$Res>
    implements $CreatePostStateCopyWith<$Res> {
  factory _$$_CreatePostStateCopyWith(
          _$_CreatePostState value, $Res Function(_$_CreatePostState) then) =
      __$$_CreatePostStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CreatePostStatus status,
      PostPrivacy postPrivacy,
      String? postDescription,
      Event? selectEvent,
      XFile? uploadImage,
      String? error});
}

/// @nodoc
class __$$_CreatePostStateCopyWithImpl<$Res>
    extends _$CreatePostStateCopyWithImpl<$Res, _$_CreatePostState>
    implements _$$_CreatePostStateCopyWith<$Res> {
  __$$_CreatePostStateCopyWithImpl(
      _$_CreatePostState _value, $Res Function(_$_CreatePostState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? postPrivacy = null,
    Object? postDescription = freezed,
    Object? selectEvent = freezed,
    Object? uploadImage = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_CreatePostState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CreatePostStatus,
      postPrivacy: null == postPrivacy
          ? _value.postPrivacy
          : postPrivacy // ignore: cast_nullable_to_non_nullable
              as PostPrivacy,
      postDescription: freezed == postDescription
          ? _value.postDescription
          : postDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      selectEvent: freezed == selectEvent
          ? _value.selectEvent
          : selectEvent // ignore: cast_nullable_to_non_nullable
              as Event?,
      uploadImage: freezed == uploadImage
          ? _value.uploadImage
          : uploadImage // ignore: cast_nullable_to_non_nullable
              as XFile?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_CreatePostState implements _CreatePostState {
  const _$_CreatePostState(
      {this.status = CreatePostStatus.initial,
      this.postPrivacy = PostPrivacy.public,
      this.postDescription,
      this.selectEvent,
      this.uploadImage,
      this.error});

  @override
  @JsonKey()
  final CreatePostStatus status;
  @override
  @JsonKey()
  final PostPrivacy postPrivacy;
  @override
  final String? postDescription;
  @override
  final Event? selectEvent;
  @override
  final XFile? uploadImage;
  @override
  final String? error;

  @override
  String toString() {
    return 'CreatePostState(status: $status, postPrivacy: $postPrivacy, postDescription: $postDescription, selectEvent: $selectEvent, uploadImage: $uploadImage, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreatePostState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.postPrivacy, postPrivacy) ||
                other.postPrivacy == postPrivacy) &&
            (identical(other.postDescription, postDescription) ||
                other.postDescription == postDescription) &&
            (identical(other.selectEvent, selectEvent) ||
                other.selectEvent == selectEvent) &&
            (identical(other.uploadImage, uploadImage) ||
                other.uploadImage == uploadImage) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, postPrivacy,
      postDescription, selectEvent, uploadImage, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreatePostStateCopyWith<_$_CreatePostState> get copyWith =>
      __$$_CreatePostStateCopyWithImpl<_$_CreatePostState>(this, _$identity);
}

abstract class _CreatePostState implements CreatePostState {
  const factory _CreatePostState(
      {final CreatePostStatus status,
      final PostPrivacy postPrivacy,
      final String? postDescription,
      final Event? selectEvent,
      final XFile? uploadImage,
      final String? error}) = _$_CreatePostState;

  @override
  CreatePostStatus get status;
  @override
  PostPrivacy get postPrivacy;
  @override
  String? get postDescription;
  @override
  Event? get selectEvent;
  @override
  XFile? get uploadImage;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$_CreatePostStateCopyWith<_$_CreatePostState> get copyWith =>
      throw _privateConstructorUsedError;
}
