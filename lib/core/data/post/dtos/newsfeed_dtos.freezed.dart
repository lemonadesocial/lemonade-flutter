// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'newsfeed_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NewsfeedDto _$NewsfeedDtoFromJson(Map<String, dynamic> json) {
  return _NewsfeedDto.fromJson(json);
}

/// @nodoc
mixin _$NewsfeedDto {
  @JsonKey(name: 'posts')
  List<PostDto>? get posts => throw _privateConstructorUsedError;
  int? get offset => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewsfeedDtoCopyWith<NewsfeedDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsfeedDtoCopyWith<$Res> {
  factory $NewsfeedDtoCopyWith(
          NewsfeedDto value, $Res Function(NewsfeedDto) then) =
      _$NewsfeedDtoCopyWithImpl<$Res, NewsfeedDto>;
  @useResult
  $Res call({@JsonKey(name: 'posts') List<PostDto>? posts, int? offset});
}

/// @nodoc
class _$NewsfeedDtoCopyWithImpl<$Res, $Val extends NewsfeedDto>
    implements $NewsfeedDtoCopyWith<$Res> {
  _$NewsfeedDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = freezed,
    Object? offset = freezed,
  }) {
    return _then(_value.copyWith(
      posts: freezed == posts
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostDto>?,
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewsfeedDtoCopyWith<$Res>
    implements $NewsfeedDtoCopyWith<$Res> {
  factory _$$_NewsfeedDtoCopyWith(
          _$_NewsfeedDto value, $Res Function(_$_NewsfeedDto) then) =
      __$$_NewsfeedDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'posts') List<PostDto>? posts, int? offset});
}

/// @nodoc
class __$$_NewsfeedDtoCopyWithImpl<$Res>
    extends _$NewsfeedDtoCopyWithImpl<$Res, _$_NewsfeedDto>
    implements _$$_NewsfeedDtoCopyWith<$Res> {
  __$$_NewsfeedDtoCopyWithImpl(
      _$_NewsfeedDto _value, $Res Function(_$_NewsfeedDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = freezed,
    Object? offset = freezed,
  }) {
    return _then(_$_NewsfeedDto(
      posts: freezed == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostDto>?,
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NewsfeedDto implements _NewsfeedDto {
  const _$_NewsfeedDto(
      {@JsonKey(name: 'posts') final List<PostDto>? posts, this.offset})
      : _posts = posts;

  factory _$_NewsfeedDto.fromJson(Map<String, dynamic> json) =>
      _$$_NewsfeedDtoFromJson(json);

  final List<PostDto>? _posts;
  @override
  @JsonKey(name: 'posts')
  List<PostDto>? get posts {
    final value = _posts;
    if (value == null) return null;
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? offset;

  @override
  String toString() {
    return 'NewsfeedDto(posts: $posts, offset: $offset)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewsfeedDto &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_posts), offset);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewsfeedDtoCopyWith<_$_NewsfeedDto> get copyWith =>
      __$$_NewsfeedDtoCopyWithImpl<_$_NewsfeedDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NewsfeedDtoToJson(
      this,
    );
  }
}

abstract class _NewsfeedDto implements NewsfeedDto {
  const factory _NewsfeedDto(
      {@JsonKey(name: 'posts') final List<PostDto>? posts,
      final int? offset}) = _$_NewsfeedDto;

  factory _NewsfeedDto.fromJson(Map<String, dynamic> json) =
      _$_NewsfeedDto.fromJson;

  @override
  @JsonKey(name: 'posts')
  List<PostDto>? get posts;
  @override
  int? get offset;
  @override
  @JsonKey(ignore: true)
  _$$_NewsfeedDtoCopyWith<_$_NewsfeedDto> get copyWith =>
      throw _privateConstructorUsedError;
}
