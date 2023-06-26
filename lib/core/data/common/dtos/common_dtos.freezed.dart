// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddressDto _$AddressDtoFromJson(Map<String, dynamic> json) {
  return _AddressDto.fromJson(json);
}

/// @nodoc
mixin _$AddressDto {
  String? get street1 => throw _privateConstructorUsedError;
  String? get street2 => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  String? get postal => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'recipient_name', includeIfNull: false)
  String? get recipientName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressDtoCopyWith<AddressDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressDtoCopyWith<$Res> {
  factory $AddressDtoCopyWith(
          AddressDto value, $Res Function(AddressDto) then) =
      _$AddressDtoCopyWithImpl<$Res, AddressDto>;
  @useResult
  $Res call(
      {String? street1,
      String? street2,
      String? city,
      String? region,
      String? postal,
      String? country,
      String? title,
      double? latitude,
      double? longitude,
      @JsonKey(name: 'recipient_name', includeIfNull: false)
          String? recipientName});
}

/// @nodoc
class _$AddressDtoCopyWithImpl<$Res, $Val extends AddressDto>
    implements $AddressDtoCopyWith<$Res> {
  _$AddressDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street1 = freezed,
    Object? street2 = freezed,
    Object? city = freezed,
    Object? region = freezed,
    Object? postal = freezed,
    Object? country = freezed,
    Object? title = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? recipientName = freezed,
  }) {
    return _then(_value.copyWith(
      street1: freezed == street1
          ? _value.street1
          : street1 // ignore: cast_nullable_to_non_nullable
              as String?,
      street2: freezed == street2
          ? _value.street2
          : street2 // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      postal: freezed == postal
          ? _value.postal
          : postal // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      recipientName: freezed == recipientName
          ? _value.recipientName
          : recipientName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddressDtoCopyWith<$Res>
    implements $AddressDtoCopyWith<$Res> {
  factory _$$_AddressDtoCopyWith(
          _$_AddressDto value, $Res Function(_$_AddressDto) then) =
      __$$_AddressDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? street1,
      String? street2,
      String? city,
      String? region,
      String? postal,
      String? country,
      String? title,
      double? latitude,
      double? longitude,
      @JsonKey(name: 'recipient_name', includeIfNull: false)
          String? recipientName});
}

/// @nodoc
class __$$_AddressDtoCopyWithImpl<$Res>
    extends _$AddressDtoCopyWithImpl<$Res, _$_AddressDto>
    implements _$$_AddressDtoCopyWith<$Res> {
  __$$_AddressDtoCopyWithImpl(
      _$_AddressDto _value, $Res Function(_$_AddressDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street1 = freezed,
    Object? street2 = freezed,
    Object? city = freezed,
    Object? region = freezed,
    Object? postal = freezed,
    Object? country = freezed,
    Object? title = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? recipientName = freezed,
  }) {
    return _then(_$_AddressDto(
      street1: freezed == street1
          ? _value.street1
          : street1 // ignore: cast_nullable_to_non_nullable
              as String?,
      street2: freezed == street2
          ? _value.street2
          : street2 // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      postal: freezed == postal
          ? _value.postal
          : postal // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      recipientName: freezed == recipientName
          ? _value.recipientName
          : recipientName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AddressDto implements _AddressDto {
  const _$_AddressDto(
      {this.street1,
      this.street2,
      this.city,
      this.region,
      this.postal,
      this.country,
      this.title,
      this.latitude,
      this.longitude,
      @JsonKey(name: 'recipient_name', includeIfNull: false)
          this.recipientName});

  factory _$_AddressDto.fromJson(Map<String, dynamic> json) =>
      _$$_AddressDtoFromJson(json);

  @override
  final String? street1;
  @override
  final String? street2;
  @override
  final String? city;
  @override
  final String? region;
  @override
  final String? postal;
  @override
  final String? country;
  @override
  final String? title;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey(name: 'recipient_name', includeIfNull: false)
  final String? recipientName;

  @override
  String toString() {
    return 'AddressDto(street1: $street1, street2: $street2, city: $city, region: $region, postal: $postal, country: $country, title: $title, latitude: $latitude, longitude: $longitude, recipientName: $recipientName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddressDto &&
            (identical(other.street1, street1) || other.street1 == street1) &&
            (identical(other.street2, street2) || other.street2 == street2) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.postal, postal) || other.postal == postal) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, street1, street2, city, region,
      postal, country, title, latitude, longitude, recipientName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddressDtoCopyWith<_$_AddressDto> get copyWith =>
      __$$_AddressDtoCopyWithImpl<_$_AddressDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddressDtoToJson(
      this,
    );
  }
}

abstract class _AddressDto implements AddressDto {
  const factory _AddressDto(
      {final String? street1,
      final String? street2,
      final String? city,
      final String? region,
      final String? postal,
      final String? country,
      final String? title,
      final double? latitude,
      final double? longitude,
      @JsonKey(name: 'recipient_name', includeIfNull: false)
          final String? recipientName}) = _$_AddressDto;

  factory _AddressDto.fromJson(Map<String, dynamic> json) =
      _$_AddressDto.fromJson;

  @override
  String? get street1;
  @override
  String? get street2;
  @override
  String? get city;
  @override
  String? get region;
  @override
  String? get postal;
  @override
  String? get country;
  @override
  String? get title;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  @JsonKey(name: 'recipient_name', includeIfNull: false)
  String? get recipientName;
  @override
  @JsonKey(ignore: true)
  _$$_AddressDtoCopyWith<_$_AddressDto> get copyWith =>
      throw _privateConstructorUsedError;
}

DbFileDto _$DbFileDtoFromJson(Map<String, dynamic> json) {
  return _DbFileDto.fromJson(json);
}

/// @nodoc
mixin _$DbFileDto {
  @JsonKey(name: '_id', includeIfNull: false)
  String? get id => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get owner => throw _privateConstructorUsedError;
  String? get bucket => throw _privateConstructorUsedError;
  UserDto? get ownerExpanded => throw _privateConstructorUsedError;
  String? get stamp => throw _privateConstructorUsedError;
  int? get likes => throw _privateConstructorUsedError;
  bool? get liked => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get key => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DbFileDtoCopyWith<DbFileDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DbFileDtoCopyWith<$Res> {
  factory $DbFileDtoCopyWith(DbFileDto value, $Res Function(DbFileDto) then) =
      _$DbFileDtoCopyWithImpl<$Res, DbFileDto>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id', includeIfNull: false) String? id,
      String? url,
      String? owner,
      String? bucket,
      UserDto? ownerExpanded,
      String? stamp,
      int? likes,
      bool? liked,
      String? description,
      String? key,
      String? type});

  $UserDtoCopyWith<$Res>? get ownerExpanded;
}

/// @nodoc
class _$DbFileDtoCopyWithImpl<$Res, $Val extends DbFileDto>
    implements $DbFileDtoCopyWith<$Res> {
  _$DbFileDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
    Object? owner = freezed,
    Object? bucket = freezed,
    Object? ownerExpanded = freezed,
    Object? stamp = freezed,
    Object? likes = freezed,
    Object? liked = freezed,
    Object? description = freezed,
    Object? key = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      owner: freezed == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String?,
      bucket: freezed == bucket
          ? _value.bucket
          : bucket // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerExpanded: freezed == ownerExpanded
          ? _value.ownerExpanded
          : ownerExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      stamp: freezed == stamp
          ? _value.stamp
          : stamp // ignore: cast_nullable_to_non_nullable
              as String?,
      likes: freezed == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int?,
      liked: freezed == liked
          ? _value.liked
          : liked // ignore: cast_nullable_to_non_nullable
              as bool?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res>? get ownerExpanded {
    if (_value.ownerExpanded == null) {
      return null;
    }

    return $UserDtoCopyWith<$Res>(_value.ownerExpanded!, (value) {
      return _then(_value.copyWith(ownerExpanded: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DbFileDtoCopyWith<$Res> implements $DbFileDtoCopyWith<$Res> {
  factory _$$_DbFileDtoCopyWith(
          _$_DbFileDto value, $Res Function(_$_DbFileDto) then) =
      __$$_DbFileDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id', includeIfNull: false) String? id,
      String? url,
      String? owner,
      String? bucket,
      UserDto? ownerExpanded,
      String? stamp,
      int? likes,
      bool? liked,
      String? description,
      String? key,
      String? type});

  @override
  $UserDtoCopyWith<$Res>? get ownerExpanded;
}

/// @nodoc
class __$$_DbFileDtoCopyWithImpl<$Res>
    extends _$DbFileDtoCopyWithImpl<$Res, _$_DbFileDto>
    implements _$$_DbFileDtoCopyWith<$Res> {
  __$$_DbFileDtoCopyWithImpl(
      _$_DbFileDto _value, $Res Function(_$_DbFileDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
    Object? owner = freezed,
    Object? bucket = freezed,
    Object? ownerExpanded = freezed,
    Object? stamp = freezed,
    Object? likes = freezed,
    Object? liked = freezed,
    Object? description = freezed,
    Object? key = freezed,
    Object? type = freezed,
  }) {
    return _then(_$_DbFileDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      owner: freezed == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String?,
      bucket: freezed == bucket
          ? _value.bucket
          : bucket // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerExpanded: freezed == ownerExpanded
          ? _value.ownerExpanded
          : ownerExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      stamp: freezed == stamp
          ? _value.stamp
          : stamp // ignore: cast_nullable_to_non_nullable
              as String?,
      likes: freezed == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int?,
      liked: freezed == liked
          ? _value.liked
          : liked // ignore: cast_nullable_to_non_nullable
              as bool?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DbFileDto implements _DbFileDto {
  const _$_DbFileDto(
      {@JsonKey(name: '_id', includeIfNull: false) this.id,
      this.url,
      this.owner,
      this.bucket,
      this.ownerExpanded,
      this.stamp,
      this.likes,
      this.liked,
      this.description,
      this.key,
      this.type});

  factory _$_DbFileDto.fromJson(Map<String, dynamic> json) =>
      _$$_DbFileDtoFromJson(json);

  @override
  @JsonKey(name: '_id', includeIfNull: false)
  final String? id;
  @override
  final String? url;
  @override
  final String? owner;
  @override
  final String? bucket;
  @override
  final UserDto? ownerExpanded;
  @override
  final String? stamp;
  @override
  final int? likes;
  @override
  final bool? liked;
  @override
  final String? description;
  @override
  final String? key;
  @override
  final String? type;

  @override
  String toString() {
    return 'DbFileDto(id: $id, url: $url, owner: $owner, bucket: $bucket, ownerExpanded: $ownerExpanded, stamp: $stamp, likes: $likes, liked: $liked, description: $description, key: $key, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DbFileDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.bucket, bucket) || other.bucket == bucket) &&
            (identical(other.ownerExpanded, ownerExpanded) ||
                other.ownerExpanded == ownerExpanded) &&
            (identical(other.stamp, stamp) || other.stamp == stamp) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.liked, liked) || other.liked == liked) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, owner, bucket,
      ownerExpanded, stamp, likes, liked, description, key, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DbFileDtoCopyWith<_$_DbFileDto> get copyWith =>
      __$$_DbFileDtoCopyWithImpl<_$_DbFileDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DbFileDtoToJson(
      this,
    );
  }
}

abstract class _DbFileDto implements DbFileDto {
  const factory _DbFileDto(
      {@JsonKey(name: '_id', includeIfNull: false) final String? id,
      final String? url,
      final String? owner,
      final String? bucket,
      final UserDto? ownerExpanded,
      final String? stamp,
      final int? likes,
      final bool? liked,
      final String? description,
      final String? key,
      final String? type}) = _$_DbFileDto;

  factory _DbFileDto.fromJson(Map<String, dynamic> json) =
      _$_DbFileDto.fromJson;

  @override
  @JsonKey(name: '_id', includeIfNull: false)
  String? get id;
  @override
  String? get url;
  @override
  String? get owner;
  @override
  String? get bucket;
  @override
  UserDto? get ownerExpanded;
  @override
  String? get stamp;
  @override
  int? get likes;
  @override
  bool? get liked;
  @override
  String? get description;
  @override
  String? get key;
  @override
  String? get type;
  @override
  @JsonKey(ignore: true)
  _$$_DbFileDtoCopyWith<_$_DbFileDto> get copyWith =>
      throw _privateConstructorUsedError;
}
