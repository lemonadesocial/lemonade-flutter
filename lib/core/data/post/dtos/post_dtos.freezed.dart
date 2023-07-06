// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostDto _$PostDtoFromJson(Map<String, dynamic> json) {
  return _PostDto.fromJson(json);
}

/// @nodoc
mixin _$PostDto {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get user => throw _privateConstructorUsedError;
  PostVisibility get visibility => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_expanded')
  UserDto? get userExpanded => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'ref_id')
  String? get refId => throw _privateConstructorUsedError;
  @JsonKey(name: 'ref_type')
  PostRefType? get refType => throw _privateConstructorUsedError;
  @JsonKey(name: 'ref_event')
  EventDto? get refEvent => throw _privateConstructorUsedError;
  @JsonKey(name: 'ref_file')
  DbFileDto? get refFile => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_reaction')
  bool? get hasReaction => throw _privateConstructorUsedError;
  int? get reactions => throw _privateConstructorUsedError;
  int? get comments => throw _privateConstructorUsedError;
  bool? get published => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostDtoCopyWith<PostDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostDtoCopyWith<$Res> {
  factory $PostDtoCopyWith(PostDto value, $Res Function(PostDto) then) =
      _$PostDtoCopyWithImpl<$Res, PostDto>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'created_at') DateTime createdAt,
      String user,
      PostVisibility visibility,
      @JsonKey(name: 'user_expanded') UserDto? userExpanded,
      String? text,
      @JsonKey(name: 'ref_id') String? refId,
      @JsonKey(name: 'ref_type') PostRefType? refType,
      @JsonKey(name: 'ref_event') EventDto? refEvent,
      @JsonKey(name: 'ref_file') DbFileDto? refFile,
      @JsonKey(name: 'has_reaction') bool? hasReaction,
      int? reactions,
      int? comments,
      bool? published});

  $UserDtoCopyWith<$Res>? get userExpanded;
  $EventDtoCopyWith<$Res>? get refEvent;
  $DbFileDtoCopyWith<$Res>? get refFile;
}

/// @nodoc
class _$PostDtoCopyWithImpl<$Res, $Val extends PostDto>
    implements $PostDtoCopyWith<$Res> {
  _$PostDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? user = null,
    Object? visibility = null,
    Object? userExpanded = freezed,
    Object? text = freezed,
    Object? refId = freezed,
    Object? refType = freezed,
    Object? refEvent = freezed,
    Object? refFile = freezed,
    Object? hasReaction = freezed,
    Object? reactions = freezed,
    Object? comments = freezed,
    Object? published = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as PostVisibility,
      userExpanded: freezed == userExpanded
          ? _value.userExpanded
          : userExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      refId: freezed == refId
          ? _value.refId
          : refId // ignore: cast_nullable_to_non_nullable
              as String?,
      refType: freezed == refType
          ? _value.refType
          : refType // ignore: cast_nullable_to_non_nullable
              as PostRefType?,
      refEvent: freezed == refEvent
          ? _value.refEvent
          : refEvent // ignore: cast_nullable_to_non_nullable
              as EventDto?,
      refFile: freezed == refFile
          ? _value.refFile
          : refFile // ignore: cast_nullable_to_non_nullable
              as DbFileDto?,
      hasReaction: freezed == hasReaction
          ? _value.hasReaction
          : hasReaction // ignore: cast_nullable_to_non_nullable
              as bool?,
      reactions: freezed == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as int?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as int?,
      published: freezed == published
          ? _value.published
          : published // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res>? get userExpanded {
    if (_value.userExpanded == null) {
      return null;
    }

    return $UserDtoCopyWith<$Res>(_value.userExpanded!, (value) {
      return _then(_value.copyWith(userExpanded: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EventDtoCopyWith<$Res>? get refEvent {
    if (_value.refEvent == null) {
      return null;
    }

    return $EventDtoCopyWith<$Res>(_value.refEvent!, (value) {
      return _then(_value.copyWith(refEvent: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DbFileDtoCopyWith<$Res>? get refFile {
    if (_value.refFile == null) {
      return null;
    }

    return $DbFileDtoCopyWith<$Res>(_value.refFile!, (value) {
      return _then(_value.copyWith(refFile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PostDtoCopyWith<$Res> implements $PostDtoCopyWith<$Res> {
  factory _$$_PostDtoCopyWith(
          _$_PostDto value, $Res Function(_$_PostDto) then) =
      __$$_PostDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'created_at') DateTime createdAt,
      String user,
      PostVisibility visibility,
      @JsonKey(name: 'user_expanded') UserDto? userExpanded,
      String? text,
      @JsonKey(name: 'ref_id') String? refId,
      @JsonKey(name: 'ref_type') PostRefType? refType,
      @JsonKey(name: 'ref_event') EventDto? refEvent,
      @JsonKey(name: 'ref_file') DbFileDto? refFile,
      @JsonKey(name: 'has_reaction') bool? hasReaction,
      int? reactions,
      int? comments,
      bool? published});

  @override
  $UserDtoCopyWith<$Res>? get userExpanded;
  @override
  $EventDtoCopyWith<$Res>? get refEvent;
  @override
  $DbFileDtoCopyWith<$Res>? get refFile;
}

/// @nodoc
class __$$_PostDtoCopyWithImpl<$Res>
    extends _$PostDtoCopyWithImpl<$Res, _$_PostDto>
    implements _$$_PostDtoCopyWith<$Res> {
  __$$_PostDtoCopyWithImpl(_$_PostDto _value, $Res Function(_$_PostDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? user = null,
    Object? visibility = null,
    Object? userExpanded = freezed,
    Object? text = freezed,
    Object? refId = freezed,
    Object? refType = freezed,
    Object? refEvent = freezed,
    Object? refFile = freezed,
    Object? hasReaction = freezed,
    Object? reactions = freezed,
    Object? comments = freezed,
    Object? published = freezed,
  }) {
    return _then(_$_PostDto(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as PostVisibility,
      userExpanded: freezed == userExpanded
          ? _value.userExpanded
          : userExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      refId: freezed == refId
          ? _value.refId
          : refId // ignore: cast_nullable_to_non_nullable
              as String?,
      refType: freezed == refType
          ? _value.refType
          : refType // ignore: cast_nullable_to_non_nullable
              as PostRefType?,
      refEvent: freezed == refEvent
          ? _value.refEvent
          : refEvent // ignore: cast_nullable_to_non_nullable
              as EventDto?,
      refFile: freezed == refFile
          ? _value.refFile
          : refFile // ignore: cast_nullable_to_non_nullable
              as DbFileDto?,
      hasReaction: freezed == hasReaction
          ? _value.hasReaction
          : hasReaction // ignore: cast_nullable_to_non_nullable
              as bool?,
      reactions: freezed == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as int?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as int?,
      published: freezed == published
          ? _value.published
          : published // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PostDto implements _PostDto {
  const _$_PostDto(
      {required this.id,
      @JsonKey(name: 'created_at') required this.createdAt,
      required this.user,
      required this.visibility,
      @JsonKey(name: 'user_expanded') this.userExpanded,
      this.text,
      @JsonKey(name: 'ref_id') this.refId,
      @JsonKey(name: 'ref_type') this.refType,
      @JsonKey(name: 'ref_event') this.refEvent,
      @JsonKey(name: 'ref_file') this.refFile,
      @JsonKey(name: 'has_reaction') this.hasReaction,
      this.reactions,
      this.comments,
      this.published});

  factory _$_PostDto.fromJson(Map<String, dynamic> json) =>
      _$$_PostDtoFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  final String user;
  @override
  final PostVisibility visibility;
  @override
  @JsonKey(name: 'user_expanded')
  final UserDto? userExpanded;
  @override
  final String? text;
  @override
  @JsonKey(name: 'ref_id')
  final String? refId;
  @override
  @JsonKey(name: 'ref_type')
  final PostRefType? refType;
  @override
  @JsonKey(name: 'ref_event')
  final EventDto? refEvent;
  @override
  @JsonKey(name: 'ref_file')
  final DbFileDto? refFile;
  @override
  @JsonKey(name: 'has_reaction')
  final bool? hasReaction;
  @override
  final int? reactions;
  @override
  final int? comments;
  @override
  final bool? published;

  @override
  String toString() {
    return 'PostDto(id: $id, createdAt: $createdAt, user: $user, visibility: $visibility, userExpanded: $userExpanded, text: $text, refId: $refId, refType: $refType, refEvent: $refEvent, refFile: $refFile, hasReaction: $hasReaction, reactions: $reactions, comments: $comments, published: $published)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.userExpanded, userExpanded) ||
                other.userExpanded == userExpanded) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.refId, refId) || other.refId == refId) &&
            (identical(other.refType, refType) || other.refType == refType) &&
            (identical(other.refEvent, refEvent) ||
                other.refEvent == refEvent) &&
            (identical(other.refFile, refFile) || other.refFile == refFile) &&
            (identical(other.hasReaction, hasReaction) ||
                other.hasReaction == hasReaction) &&
            (identical(other.reactions, reactions) ||
                other.reactions == reactions) &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.published, published) ||
                other.published == published));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      user,
      visibility,
      userExpanded,
      text,
      refId,
      refType,
      refEvent,
      refFile,
      hasReaction,
      reactions,
      comments,
      published);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostDtoCopyWith<_$_PostDto> get copyWith =>
      __$$_PostDtoCopyWithImpl<_$_PostDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostDtoToJson(
      this,
    );
  }
}

abstract class _PostDto implements PostDto {
  const factory _PostDto(
      {required final String id,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      required final String user,
      required final PostVisibility visibility,
      @JsonKey(name: 'user_expanded') final UserDto? userExpanded,
      final String? text,
      @JsonKey(name: 'ref_id') final String? refId,
      @JsonKey(name: 'ref_type') final PostRefType? refType,
      @JsonKey(name: 'ref_event') final EventDto? refEvent,
      @JsonKey(name: 'ref_file') final DbFileDto? refFile,
      @JsonKey(name: 'has_reaction') final bool? hasReaction,
      final int? reactions,
      final int? comments,
      final bool? published}) = _$_PostDto;

  factory _PostDto.fromJson(Map<String, dynamic> json) = _$_PostDto.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  String get user;
  @override
  PostVisibility get visibility;
  @override
  @JsonKey(name: 'user_expanded')
  UserDto? get userExpanded;
  @override
  String? get text;
  @override
  @JsonKey(name: 'ref_id')
  String? get refId;
  @override
  @JsonKey(name: 'ref_type')
  PostRefType? get refType;
  @override
  @JsonKey(name: 'ref_event')
  EventDto? get refEvent;
  @override
  @JsonKey(name: 'ref_file')
  DbFileDto? get refFile;
  @override
  @JsonKey(name: 'has_reaction')
  bool? get hasReaction;
  @override
  int? get reactions;
  @override
  int? get comments;
  @override
  bool? get published;
  @override
  @JsonKey(ignore: true)
  _$$_PostDtoCopyWith<_$_PostDto> get copyWith =>
      throw _privateConstructorUsedError;
}
