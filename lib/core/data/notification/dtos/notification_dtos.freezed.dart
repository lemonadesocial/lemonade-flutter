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
  String? get title => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get from => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_seen')
  String? get isSeen => throw _privateConstructorUsedError;
  @JsonKey(name: 'ref_event')
  String? get refEvent => throw _privateConstructorUsedError;
  @JsonKey(name: 'ref_room')
  String? get refRoom => throw _privateConstructorUsedError;
  @JsonKey(name: 'ref_store_order')
  String? get refStoreOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'ref_user')
  String? get refUser => throw _privateConstructorUsedError;

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
      String? title,
      String? message,
      String? type,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      String? from,
      @JsonKey(name: 'is_seen') String? isSeen,
      @JsonKey(name: 'ref_event') String? refEvent,
      @JsonKey(name: 'ref_room') String? refRoom,
      @JsonKey(name: 'ref_store_order') String? refStoreOrder,
      @JsonKey(name: 'ref_user') String? refUser});

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
    Object? title = freezed,
    Object? message = freezed,
    Object? type = freezed,
    Object? createdAt = freezed,
    Object? from = freezed,
    Object? isSeen = freezed,
    Object? refEvent = freezed,
    Object? refRoom = freezed,
    Object? refStoreOrder = freezed,
    Object? refUser = freezed,
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
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
      isSeen: freezed == isSeen
          ? _value.isSeen
          : isSeen // ignore: cast_nullable_to_non_nullable
              as String?,
      refEvent: freezed == refEvent
          ? _value.refEvent
          : refEvent // ignore: cast_nullable_to_non_nullable
              as String?,
      refRoom: freezed == refRoom
          ? _value.refRoom
          : refRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      refStoreOrder: freezed == refStoreOrder
          ? _value.refStoreOrder
          : refStoreOrder // ignore: cast_nullable_to_non_nullable
              as String?,
      refUser: freezed == refUser
          ? _value.refUser
          : refUser // ignore: cast_nullable_to_non_nullable
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
      String? title,
      String? message,
      String? type,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      String? from,
      @JsonKey(name: 'is_seen') String? isSeen,
      @JsonKey(name: 'ref_event') String? refEvent,
      @JsonKey(name: 'ref_room') String? refRoom,
      @JsonKey(name: 'ref_store_order') String? refStoreOrder,
      @JsonKey(name: 'ref_user') String? refUser});

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
    Object? title = freezed,
    Object? message = freezed,
    Object? type = freezed,
    Object? createdAt = freezed,
    Object? from = freezed,
    Object? isSeen = freezed,
    Object? refEvent = freezed,
    Object? refRoom = freezed,
    Object? refStoreOrder = freezed,
    Object? refUser = freezed,
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
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
      isSeen: freezed == isSeen
          ? _value.isSeen
          : isSeen // ignore: cast_nullable_to_non_nullable
              as String?,
      refEvent: freezed == refEvent
          ? _value.refEvent
          : refEvent // ignore: cast_nullable_to_non_nullable
              as String?,
      refRoom: freezed == refRoom
          ? _value.refRoom
          : refRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      refStoreOrder: freezed == refStoreOrder
          ? _value.refStoreOrder
          : refStoreOrder // ignore: cast_nullable_to_non_nullable
              as String?,
      refUser: freezed == refUser
          ? _value.refUser
          : refUser // ignore: cast_nullable_to_non_nullable
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
      this.title,
      this.message,
      this.type,
      @JsonKey(name: 'created_at') this.createdAt,
      this.from,
      @JsonKey(name: 'is_seen') this.isSeen,
      @JsonKey(name: 'ref_event') this.refEvent,
      @JsonKey(name: 'ref_room') this.refRoom,
      @JsonKey(name: 'ref_store_order') this.refStoreOrder,
      @JsonKey(name: 'ref_user') this.refUser});

  factory _$_NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationDtoFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'from_expanded')
  final UserDto? fromExpanded;
  @override
  final String? title;
  @override
  final String? message;
  @override
  final String? type;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  final String? from;
  @override
  @JsonKey(name: 'is_seen')
  final String? isSeen;
  @override
  @JsonKey(name: 'ref_event')
  final String? refEvent;
  @override
  @JsonKey(name: 'ref_room')
  final String? refRoom;
  @override
  @JsonKey(name: 'ref_store_order')
  final String? refStoreOrder;
  @override
  @JsonKey(name: 'ref_user')
  final String? refUser;

  @override
  String toString() {
    return 'NotificationDto(id: $id, fromExpanded: $fromExpanded, title: $title, message: $message, type: $type, createdAt: $createdAt, from: $from, isSeen: $isSeen, refEvent: $refEvent, refRoom: $refRoom, refStoreOrder: $refStoreOrder, refUser: $refUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NotificationDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromExpanded, fromExpanded) ||
                other.fromExpanded == fromExpanded) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.isSeen, isSeen) || other.isSeen == isSeen) &&
            (identical(other.refEvent, refEvent) ||
                other.refEvent == refEvent) &&
            (identical(other.refRoom, refRoom) || other.refRoom == refRoom) &&
            (identical(other.refStoreOrder, refStoreOrder) ||
                other.refStoreOrder == refStoreOrder) &&
            (identical(other.refUser, refUser) || other.refUser == refUser));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, fromExpanded, title, message,
      type, createdAt, from, isSeen, refEvent, refRoom, refStoreOrder, refUser);

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
      final String? title,
      final String? message,
      final String? type,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      final String? from,
      @JsonKey(name: 'is_seen') final String? isSeen,
      @JsonKey(name: 'ref_event') final String? refEvent,
      @JsonKey(name: 'ref_room') final String? refRoom,
      @JsonKey(name: 'ref_store_order') final String? refStoreOrder,
      @JsonKey(name: 'ref_user') final String? refUser}) = _$_NotificationDto;

  factory _NotificationDto.fromJson(Map<String, dynamic> json) =
      _$_NotificationDto.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'from_expanded')
  UserDto? get fromExpanded;
  @override
  String? get title;
  @override
  String? get message;
  @override
  String? get type;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  String? get from;
  @override
  @JsonKey(name: 'is_seen')
  String? get isSeen;
  @override
  @JsonKey(name: 'ref_event')
  String? get refEvent;
  @override
  @JsonKey(name: 'ref_room')
  String? get refRoom;
  @override
  @JsonKey(name: 'ref_store_order')
  String? get refStoreOrder;
  @override
  @JsonKey(name: 'ref_user')
  String? get refUser;
  @override
  @JsonKey(ignore: true)
  _$$_NotificationDtoCopyWith<_$_NotificationDto> get copyWith =>
      throw _privateConstructorUsedError;
}
