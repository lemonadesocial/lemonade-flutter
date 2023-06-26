// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EventDto _$EventDtoFromJson(Map<String, dynamic> json) {
  return _EventDto.fromJson(json);
}

/// @nodoc
mixin _$EventDto {
  @JsonKey(name: '_id', includeIfNull: false)
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'host_expanded', includeIfNull: false)
  UserDto? get hostExpanded => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_new_photos_expanded', includeIfNull: false)
  List<DbFileDto>? get newNewPhotosExpanded =>
      throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  String? get host => throw _privateConstructorUsedError;
  List<BroadcastDto>? get broadcasts => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get start => throw _privateConstructorUsedError;
  DateTime? get end => throw _privateConstructorUsedError;
  double? get cost => throw _privateConstructorUsedError;
  Currency? get currency => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventDtoCopyWith<EventDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventDtoCopyWith<$Res> {
  factory $EventDtoCopyWith(EventDto value, $Res Function(EventDto) then) =
      _$EventDtoCopyWithImpl<$Res, EventDto>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id', includeIfNull: false)
          String? id,
      @JsonKey(name: 'host_expanded', includeIfNull: false)
          UserDto? hostExpanded,
      @JsonKey(name: 'new_new_photos_expanded', includeIfNull: false)
          List<DbFileDto>? newNewPhotosExpanded,
      String? title,
      String? slug,
      String? host,
      List<BroadcastDto>? broadcasts,
      String? description,
      DateTime? start,
      DateTime? end,
      double? cost,
      Currency? currency});

  $UserDtoCopyWith<$Res>? get hostExpanded;
}

/// @nodoc
class _$EventDtoCopyWithImpl<$Res, $Val extends EventDto>
    implements $EventDtoCopyWith<$Res> {
  _$EventDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? hostExpanded = freezed,
    Object? newNewPhotosExpanded = freezed,
    Object? title = freezed,
    Object? slug = freezed,
    Object? host = freezed,
    Object? broadcasts = freezed,
    Object? description = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? cost = freezed,
    Object? currency = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      hostExpanded: freezed == hostExpanded
          ? _value.hostExpanded
          : hostExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      newNewPhotosExpanded: freezed == newNewPhotosExpanded
          ? _value.newNewPhotosExpanded
          : newNewPhotosExpanded // ignore: cast_nullable_to_non_nullable
              as List<DbFileDto>?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      host: freezed == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
      broadcasts: freezed == broadcasts
          ? _value.broadcasts
          : broadcasts // ignore: cast_nullable_to_non_nullable
              as List<BroadcastDto>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cost: freezed == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res>? get hostExpanded {
    if (_value.hostExpanded == null) {
      return null;
    }

    return $UserDtoCopyWith<$Res>(_value.hostExpanded!, (value) {
      return _then(_value.copyWith(hostExpanded: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EventDtoCopyWith<$Res> implements $EventDtoCopyWith<$Res> {
  factory _$$_EventDtoCopyWith(
          _$_EventDto value, $Res Function(_$_EventDto) then) =
      __$$_EventDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id', includeIfNull: false)
          String? id,
      @JsonKey(name: 'host_expanded', includeIfNull: false)
          UserDto? hostExpanded,
      @JsonKey(name: 'new_new_photos_expanded', includeIfNull: false)
          List<DbFileDto>? newNewPhotosExpanded,
      String? title,
      String? slug,
      String? host,
      List<BroadcastDto>? broadcasts,
      String? description,
      DateTime? start,
      DateTime? end,
      double? cost,
      Currency? currency});

  @override
  $UserDtoCopyWith<$Res>? get hostExpanded;
}

/// @nodoc
class __$$_EventDtoCopyWithImpl<$Res>
    extends _$EventDtoCopyWithImpl<$Res, _$_EventDto>
    implements _$$_EventDtoCopyWith<$Res> {
  __$$_EventDtoCopyWithImpl(
      _$_EventDto _value, $Res Function(_$_EventDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? hostExpanded = freezed,
    Object? newNewPhotosExpanded = freezed,
    Object? title = freezed,
    Object? slug = freezed,
    Object? host = freezed,
    Object? broadcasts = freezed,
    Object? description = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? cost = freezed,
    Object? currency = freezed,
  }) {
    return _then(_$_EventDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      hostExpanded: freezed == hostExpanded
          ? _value.hostExpanded
          : hostExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      newNewPhotosExpanded: freezed == newNewPhotosExpanded
          ? _value._newNewPhotosExpanded
          : newNewPhotosExpanded // ignore: cast_nullable_to_non_nullable
              as List<DbFileDto>?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      host: freezed == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
      broadcasts: freezed == broadcasts
          ? _value._broadcasts
          : broadcasts // ignore: cast_nullable_to_non_nullable
              as List<BroadcastDto>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cost: freezed == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_EventDto implements _EventDto {
  _$_EventDto(
      {@JsonKey(name: '_id', includeIfNull: false)
          this.id,
      @JsonKey(name: 'host_expanded', includeIfNull: false)
          this.hostExpanded,
      @JsonKey(name: 'new_new_photos_expanded', includeIfNull: false)
          final List<DbFileDto>? newNewPhotosExpanded,
      this.title,
      this.slug,
      this.host,
      final List<BroadcastDto>? broadcasts,
      this.description,
      this.start,
      this.end,
      this.cost,
      this.currency})
      : _newNewPhotosExpanded = newNewPhotosExpanded,
        _broadcasts = broadcasts;

  factory _$_EventDto.fromJson(Map<String, dynamic> json) =>
      _$$_EventDtoFromJson(json);

  @override
  @JsonKey(name: '_id', includeIfNull: false)
  final String? id;
  @override
  @JsonKey(name: 'host_expanded', includeIfNull: false)
  final UserDto? hostExpanded;
  final List<DbFileDto>? _newNewPhotosExpanded;
  @override
  @JsonKey(name: 'new_new_photos_expanded', includeIfNull: false)
  List<DbFileDto>? get newNewPhotosExpanded {
    final value = _newNewPhotosExpanded;
    if (value == null) return null;
    if (_newNewPhotosExpanded is EqualUnmodifiableListView)
      return _newNewPhotosExpanded;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? title;
  @override
  final String? slug;
  @override
  final String? host;
  final List<BroadcastDto>? _broadcasts;
  @override
  List<BroadcastDto>? get broadcasts {
    final value = _broadcasts;
    if (value == null) return null;
    if (_broadcasts is EqualUnmodifiableListView) return _broadcasts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? description;
  @override
  final DateTime? start;
  @override
  final DateTime? end;
  @override
  final double? cost;
  @override
  final Currency? currency;

  @override
  String toString() {
    return 'EventDto(id: $id, hostExpanded: $hostExpanded, newNewPhotosExpanded: $newNewPhotosExpanded, title: $title, slug: $slug, host: $host, broadcasts: $broadcasts, description: $description, start: $start, end: $end, cost: $cost, currency: $currency)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hostExpanded, hostExpanded) ||
                other.hostExpanded == hostExpanded) &&
            const DeepCollectionEquality()
                .equals(other._newNewPhotosExpanded, _newNewPhotosExpanded) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.host, host) || other.host == host) &&
            const DeepCollectionEquality()
                .equals(other._broadcasts, _broadcasts) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      hostExpanded,
      const DeepCollectionEquality().hash(_newNewPhotosExpanded),
      title,
      slug,
      host,
      const DeepCollectionEquality().hash(_broadcasts),
      description,
      start,
      end,
      cost,
      currency);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventDtoCopyWith<_$_EventDto> get copyWith =>
      __$$_EventDtoCopyWithImpl<_$_EventDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventDtoToJson(
      this,
    );
  }
}

abstract class _EventDto implements EventDto {
  factory _EventDto(
      {@JsonKey(name: '_id', includeIfNull: false)
          final String? id,
      @JsonKey(name: 'host_expanded', includeIfNull: false)
          final UserDto? hostExpanded,
      @JsonKey(name: 'new_new_photos_expanded', includeIfNull: false)
          final List<DbFileDto>? newNewPhotosExpanded,
      final String? title,
      final String? slug,
      final String? host,
      final List<BroadcastDto>? broadcasts,
      final String? description,
      final DateTime? start,
      final DateTime? end,
      final double? cost,
      final Currency? currency}) = _$_EventDto;

  factory _EventDto.fromJson(Map<String, dynamic> json) = _$_EventDto.fromJson;

  @override
  @JsonKey(name: '_id', includeIfNull: false)
  String? get id;
  @override
  @JsonKey(name: 'host_expanded', includeIfNull: false)
  UserDto? get hostExpanded;
  @override
  @JsonKey(name: 'new_new_photos_expanded', includeIfNull: false)
  List<DbFileDto>? get newNewPhotosExpanded;
  @override
  String? get title;
  @override
  String? get slug;
  @override
  String? get host;
  @override
  List<BroadcastDto>? get broadcasts;
  @override
  String? get description;
  @override
  DateTime? get start;
  @override
  DateTime? get end;
  @override
  double? get cost;
  @override
  Currency? get currency;
  @override
  @JsonKey(ignore: true)
  _$$_EventDtoCopyWith<_$_EventDto> get copyWith =>
      throw _privateConstructorUsedError;
}

BroadcastDto _$BroadcastDtoFromJson(Map<String, dynamic> json) {
  return _BroadcastDto.fromJson(json);
}

/// @nodoc
mixin _$BroadcastDto {
  @JsonKey(name: 'provider_id', includeIfNull: false)
  String? get providerId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BroadcastDtoCopyWith<BroadcastDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BroadcastDtoCopyWith<$Res> {
  factory $BroadcastDtoCopyWith(
          BroadcastDto value, $Res Function(BroadcastDto) then) =
      _$BroadcastDtoCopyWithImpl<$Res, BroadcastDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'provider_id', includeIfNull: false) String? providerId});
}

/// @nodoc
class _$BroadcastDtoCopyWithImpl<$Res, $Val extends BroadcastDto>
    implements $BroadcastDtoCopyWith<$Res> {
  _$BroadcastDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = freezed,
  }) {
    return _then(_value.copyWith(
      providerId: freezed == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BroadcastDtoCopyWith<$Res>
    implements $BroadcastDtoCopyWith<$Res> {
  factory _$$_BroadcastDtoCopyWith(
          _$_BroadcastDto value, $Res Function(_$_BroadcastDto) then) =
      __$$_BroadcastDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'provider_id', includeIfNull: false) String? providerId});
}

/// @nodoc
class __$$_BroadcastDtoCopyWithImpl<$Res>
    extends _$BroadcastDtoCopyWithImpl<$Res, _$_BroadcastDto>
    implements _$$_BroadcastDtoCopyWith<$Res> {
  __$$_BroadcastDtoCopyWithImpl(
      _$_BroadcastDto _value, $Res Function(_$_BroadcastDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = freezed,
  }) {
    return _then(_$_BroadcastDto(
      providerId: freezed == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_BroadcastDto implements _BroadcastDto {
  _$_BroadcastDto(
      {@JsonKey(name: 'provider_id', includeIfNull: false) this.providerId});

  factory _$_BroadcastDto.fromJson(Map<String, dynamic> json) =>
      _$$_BroadcastDtoFromJson(json);

  @override
  @JsonKey(name: 'provider_id', includeIfNull: false)
  final String? providerId;

  @override
  String toString() {
    return 'BroadcastDto(providerId: $providerId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BroadcastDto &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, providerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BroadcastDtoCopyWith<_$_BroadcastDto> get copyWith =>
      __$$_BroadcastDtoCopyWithImpl<_$_BroadcastDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BroadcastDtoToJson(
      this,
    );
  }
}

abstract class _BroadcastDto implements BroadcastDto {
  factory _BroadcastDto(
      {@JsonKey(name: 'provider_id', includeIfNull: false)
          final String? providerId}) = _$_BroadcastDto;

  factory _BroadcastDto.fromJson(Map<String, dynamic> json) =
      _$_BroadcastDto.fromJson;

  @override
  @JsonKey(name: 'provider_id', includeIfNull: false)
  String? get providerId;
  @override
  @JsonKey(ignore: true)
  _$$_BroadcastDtoCopyWith<_$_BroadcastDto> get copyWith =>
      throw _privateConstructorUsedError;
}
