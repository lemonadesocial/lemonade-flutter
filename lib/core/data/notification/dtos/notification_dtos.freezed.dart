// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationDto _$NotificationDtoFromJson(Map<String, dynamic> json) {
  return _NotificationDto.fromJson(json);
}

/// @nodoc
mixin _$NotificationDto {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_expanded')
  UserDto? get fromExpanded => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  DateTime? get stamp => throw _privateConstructorUsedError;
  String? get from => throw _privateConstructorUsedError;
  bool? get seen => throw _privateConstructorUsedError;
  String? get object_id => throw _privateConstructorUsedError;
  String? get object_type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationDtoCopyWith<NotificationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationDtoCopyWith<$Res> {
  factory $NotificationDtoCopyWith(
          NotificationDto value, $Res Function(NotificationDto) then) =
      _$NotificationDtoCopyWithImpl<$Res, NotificationDto>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'from_expanded') UserDto? fromExpanded,
      String? message,
      String? type,
      DateTime? stamp,
      String? from,
      bool? seen,
      String? object_id,
      String? object_type});

  $UserDtoCopyWith<$Res>? get fromExpanded;
}

/// @nodoc
class _$NotificationDtoCopyWithImpl<$Res, $Val extends NotificationDto>
    implements $NotificationDtoCopyWith<$Res> {
  _$NotificationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fromExpanded = freezed,
    Object? message = freezed,
    Object? type = freezed,
    Object? stamp = freezed,
    Object? from = freezed,
    Object? seen = freezed,
    Object? object_id = freezed,
    Object? object_type = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      fromExpanded: freezed == fromExpanded
          ? _value.fromExpanded
          : fromExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      stamp: freezed == stamp
          ? _value.stamp
          : stamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
      seen: freezed == seen
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool?,
      object_id: freezed == object_id
          ? _value.object_id
          : object_id // ignore: cast_nullable_to_non_nullable
              as String?,
      object_type: freezed == object_type
          ? _value.object_type
          : object_type // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res>? get fromExpanded {
    if (_value.fromExpanded == null) {
      return null;
    }

    return $UserDtoCopyWith<$Res>(_value.fromExpanded!, (value) {
      return _then(_value.copyWith(fromExpanded: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_NotificationDtoCopyWith<$Res>
    implements $NotificationDtoCopyWith<$Res> {
  factory _$$_NotificationDtoCopyWith(
          _$_NotificationDto value, $Res Function(_$_NotificationDto) then) =
      __$$_NotificationDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'from_expanded') UserDto? fromExpanded,
      String? message,
      String? type,
      DateTime? stamp,
      String? from,
      bool? seen,
      String? object_id,
      String? object_type});

  @override
  $UserDtoCopyWith<$Res>? get fromExpanded;
}

/// @nodoc
class __$$_NotificationDtoCopyWithImpl<$Res>
    extends _$NotificationDtoCopyWithImpl<$Res, _$_NotificationDto>
    implements _$$_NotificationDtoCopyWith<$Res> {
  __$$_NotificationDtoCopyWithImpl(
      _$_NotificationDto _value, $Res Function(_$_NotificationDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fromExpanded = freezed,
    Object? message = freezed,
    Object? type = freezed,
    Object? stamp = freezed,
    Object? from = freezed,
    Object? seen = freezed,
    Object? object_id = freezed,
    Object? object_type = freezed,
  }) {
    return _then(_$_NotificationDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      fromExpanded: freezed == fromExpanded
          ? _value.fromExpanded
          : fromExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      stamp: freezed == stamp
          ? _value.stamp
          : stamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
      seen: freezed == seen
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool?,
      object_id: freezed == object_id
          ? _value.object_id
          : object_id // ignore: cast_nullable_to_non_nullable
              as String?,
      object_type: freezed == object_type
          ? _value.object_type
          : object_type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_NotificationDto implements _NotificationDto {
  _$_NotificationDto(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'from_expanded') this.fromExpanded,
      this.message,
      this.type,
      this.stamp,
      this.from,
      this.seen,
      this.object_id,
      this.object_type});

  factory _$_NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationDtoFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'from_expanded')
  final UserDto? fromExpanded;
  @override
  final String? message;
  @override
  final String? type;
  @override
  final DateTime? stamp;
  @override
  final String? from;
  @override
  final bool? seen;
  @override
  final String? object_id;
  @override
  final String? object_type;

  @override
  String toString() {
    return 'NotificationDto(id: $id, fromExpanded: $fromExpanded, message: $message, type: $type, stamp: $stamp, from: $from, seen: $seen, object_id: $object_id, object_type: $object_type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NotificationDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromExpanded, fromExpanded) ||
                other.fromExpanded == fromExpanded) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.stamp, stamp) || other.stamp == stamp) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.seen, seen) || other.seen == seen) &&
            (identical(other.object_id, object_id) ||
                other.object_id == object_id) &&
            (identical(other.object_type, object_type) ||
                other.object_type == object_type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, fromExpanded, message, type,
      stamp, from, seen, object_id, object_type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NotificationDtoCopyWith<_$_NotificationDto> get copyWith =>
      __$$_NotificationDtoCopyWithImpl<_$_NotificationDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationDtoToJson(
      this,
    );
  }
}

abstract class _NotificationDto implements NotificationDto {
  factory _NotificationDto(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'from_expanded') final UserDto? fromExpanded,
      final String? message,
      final String? type,
      final DateTime? stamp,
      final String? from,
      final bool? seen,
      final String? object_id,
      final String? object_type}) = _$_NotificationDto;

  factory _NotificationDto.fromJson(Map<String, dynamic> json) =
      _$_NotificationDto.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'from_expanded')
  UserDto? get fromExpanded;
  @override
  String? get message;
  @override
  String? get type;
  @override
  DateTime? get stamp;
  @override
  String? get from;
  @override
  bool? get seen;
  @override
  String? get object_id;
  @override
  String? get object_type;
  @override
  @JsonKey(ignore: true)
  _$$_NotificationDtoCopyWith<_$_NotificationDto> get copyWith =>
      throw _privateConstructorUsedError;
}
