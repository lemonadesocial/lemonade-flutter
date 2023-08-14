// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badge_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BadgeDto _$BadgeDtoFromJson(Map<String, dynamic> json) {
  return _BadgeDto.fromJson(json);
}

/// @nodoc
mixin _$BadgeDto {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  bool? get claimable => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;
  String? get list => throw _privateConstructorUsedError;
  @JsonKey(name: 'list_expanded')
  BadgeListDto? get listExpanded => throw _privateConstructorUsedError;
  String? get contract => throw _privateConstructorUsedError;
  String? get network => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BadgeDtoCopyWith<BadgeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeDtoCopyWith<$Res> {
  factory $BadgeDtoCopyWith(BadgeDto value, $Res Function(BadgeDto) then) =
      _$BadgeDtoCopyWithImpl<$Res, BadgeDto>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? city,
      String? country,
      bool? claimable,
      double? distance,
      String? list,
      @JsonKey(name: 'list_expanded') BadgeListDto? listExpanded,
      String? contract,
      String? network});

  $BadgeListDtoCopyWith<$Res>? get listExpanded;
}

/// @nodoc
class _$BadgeDtoCopyWithImpl<$Res, $Val extends BadgeDto>
    implements $BadgeDtoCopyWith<$Res> {
  _$BadgeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? city = freezed,
    Object? country = freezed,
    Object? claimable = freezed,
    Object? distance = freezed,
    Object? list = freezed,
    Object? listExpanded = freezed,
    Object? contract = freezed,
    Object? network = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      claimable: freezed == claimable
          ? _value.claimable
          : claimable // ignore: cast_nullable_to_non_nullable
              as bool?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      list: freezed == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as String?,
      listExpanded: freezed == listExpanded
          ? _value.listExpanded
          : listExpanded // ignore: cast_nullable_to_non_nullable
              as BadgeListDto?,
      contract: freezed == contract
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as String?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BadgeListDtoCopyWith<$Res>? get listExpanded {
    if (_value.listExpanded == null) {
      return null;
    }

    return $BadgeListDtoCopyWith<$Res>(_value.listExpanded!, (value) {
      return _then(_value.copyWith(listExpanded: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BadgeDtoCopyWith<$Res> implements $BadgeDtoCopyWith<$Res> {
  factory _$$_BadgeDtoCopyWith(
          _$_BadgeDto value, $Res Function(_$_BadgeDto) then) =
      __$$_BadgeDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? city,
      String? country,
      bool? claimable,
      double? distance,
      String? list,
      @JsonKey(name: 'list_expanded') BadgeListDto? listExpanded,
      String? contract,
      String? network});

  @override
  $BadgeListDtoCopyWith<$Res>? get listExpanded;
}

/// @nodoc
class __$$_BadgeDtoCopyWithImpl<$Res>
    extends _$BadgeDtoCopyWithImpl<$Res, _$_BadgeDto>
    implements _$$_BadgeDtoCopyWith<$Res> {
  __$$_BadgeDtoCopyWithImpl(
      _$_BadgeDto _value, $Res Function(_$_BadgeDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? city = freezed,
    Object? country = freezed,
    Object? claimable = freezed,
    Object? distance = freezed,
    Object? list = freezed,
    Object? listExpanded = freezed,
    Object? contract = freezed,
    Object? network = freezed,
  }) {
    return _then(_$_BadgeDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      claimable: freezed == claimable
          ? _value.claimable
          : claimable // ignore: cast_nullable_to_non_nullable
              as bool?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      list: freezed == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as String?,
      listExpanded: freezed == listExpanded
          ? _value.listExpanded
          : listExpanded // ignore: cast_nullable_to_non_nullable
              as BadgeListDto?,
      contract: freezed == contract
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as String?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_BadgeDto implements _BadgeDto {
  _$_BadgeDto(
      {@JsonKey(name: '_id') this.id,
      this.city,
      this.country,
      this.claimable,
      this.distance,
      this.list,
      @JsonKey(name: 'list_expanded') this.listExpanded,
      this.contract,
      this.network});

  factory _$_BadgeDto.fromJson(Map<String, dynamic> json) =>
      _$$_BadgeDtoFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? city;
  @override
  final String? country;
  @override
  final bool? claimable;
  @override
  final double? distance;
  @override
  final String? list;
  @override
  @JsonKey(name: 'list_expanded')
  final BadgeListDto? listExpanded;
  @override
  final String? contract;
  @override
  final String? network;

  @override
  String toString() {
    return 'BadgeDto(id: $id, city: $city, country: $country, claimable: $claimable, distance: $distance, list: $list, listExpanded: $listExpanded, contract: $contract, network: $network)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BadgeDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.claimable, claimable) ||
                other.claimable == claimable) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.list, list) || other.list == list) &&
            (identical(other.listExpanded, listExpanded) ||
                other.listExpanded == listExpanded) &&
            (identical(other.contract, contract) ||
                other.contract == contract) &&
            (identical(other.network, network) || other.network == network));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, city, country, claimable,
      distance, list, listExpanded, contract, network);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BadgeDtoCopyWith<_$_BadgeDto> get copyWith =>
      __$$_BadgeDtoCopyWithImpl<_$_BadgeDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BadgeDtoToJson(
      this,
    );
  }
}

abstract class _BadgeDto implements BadgeDto {
  factory _BadgeDto(
      {@JsonKey(name: '_id') final String? id,
      final String? city,
      final String? country,
      final bool? claimable,
      final double? distance,
      final String? list,
      @JsonKey(name: 'list_expanded') final BadgeListDto? listExpanded,
      final String? contract,
      final String? network}) = _$_BadgeDto;

  factory _BadgeDto.fromJson(Map<String, dynamic> json) = _$_BadgeDto.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get city;
  @override
  String? get country;
  @override
  bool? get claimable;
  @override
  double? get distance;
  @override
  String? get list;
  @override
  @JsonKey(name: 'list_expanded')
  BadgeListDto? get listExpanded;
  @override
  String? get contract;
  @override
  String? get network;
  @override
  @JsonKey(ignore: true)
  _$$_BadgeDtoCopyWith<_$_BadgeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

BadgeListDto _$BadgeListDtoFromJson(Map<String, dynamic> json) {
  return _BadgeListDto.fromJson(json);
}

/// @nodoc
mixin _$BadgeListDto {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get user => throw _privateConstructorUsedError;
  UserDto? get userExpanded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BadgeListDtoCopyWith<BadgeListDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeListDtoCopyWith<$Res> {
  factory $BadgeListDtoCopyWith(
          BadgeListDto value, $Res Function(BadgeListDto) then) =
      _$BadgeListDtoCopyWithImpl<$Res, BadgeListDto>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'image_url') String? imageUrl,
      String? title,
      String? user,
      UserDto? userExpanded});

  $UserDtoCopyWith<$Res>? get userExpanded;
}

/// @nodoc
class _$BadgeListDtoCopyWithImpl<$Res, $Val extends BadgeListDto>
    implements $BadgeListDtoCopyWith<$Res> {
  _$BadgeListDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? imageUrl = freezed,
    Object? title = freezed,
    Object? user = freezed,
    Object? userExpanded = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      userExpanded: freezed == userExpanded
          ? _value.userExpanded
          : userExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
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
}

/// @nodoc
abstract class _$$_BadgeListDtoCopyWith<$Res>
    implements $BadgeListDtoCopyWith<$Res> {
  factory _$$_BadgeListDtoCopyWith(
          _$_BadgeListDto value, $Res Function(_$_BadgeListDto) then) =
      __$$_BadgeListDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'image_url') String? imageUrl,
      String? title,
      String? user,
      UserDto? userExpanded});

  @override
  $UserDtoCopyWith<$Res>? get userExpanded;
}

/// @nodoc
class __$$_BadgeListDtoCopyWithImpl<$Res>
    extends _$BadgeListDtoCopyWithImpl<$Res, _$_BadgeListDto>
    implements _$$_BadgeListDtoCopyWith<$Res> {
  __$$_BadgeListDtoCopyWithImpl(
      _$_BadgeListDto _value, $Res Function(_$_BadgeListDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? imageUrl = freezed,
    Object? title = freezed,
    Object? user = freezed,
    Object? userExpanded = freezed,
  }) {
    return _then(_$_BadgeListDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      userExpanded: freezed == userExpanded
          ? _value.userExpanded
          : userExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_BadgeListDto implements _BadgeListDto {
  _$_BadgeListDto(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'image_url') this.imageUrl,
      this.title,
      this.user,
      this.userExpanded});

  factory _$_BadgeListDto.fromJson(Map<String, dynamic> json) =>
      _$$_BadgeListDtoFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  final String? title;
  @override
  final String? user;
  @override
  final UserDto? userExpanded;

  @override
  String toString() {
    return 'BadgeListDto(id: $id, imageUrl: $imageUrl, title: $title, user: $user, userExpanded: $userExpanded)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BadgeListDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.userExpanded, userExpanded) ||
                other.userExpanded == userExpanded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, imageUrl, title, user, userExpanded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BadgeListDtoCopyWith<_$_BadgeListDto> get copyWith =>
      __$$_BadgeListDtoCopyWithImpl<_$_BadgeListDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BadgeListDtoToJson(
      this,
    );
  }
}

abstract class _BadgeListDto implements BadgeListDto {
  factory _BadgeListDto(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'image_url') final String? imageUrl,
      final String? title,
      final String? user,
      final UserDto? userExpanded}) = _$_BadgeListDto;

  factory _BadgeListDto.fromJson(Map<String, dynamic> json) =
      _$_BadgeListDto.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  String? get title;
  @override
  String? get user;
  @override
  UserDto? get userExpanded;
  @override
  @JsonKey(ignore: true)
  _$$_BadgeListDtoCopyWith<_$_BadgeListDto> get copyWith =>
      throw _privateConstructorUsedError;
}

BadgeCityDto _$BadgeCityDtoFromJson(Map<String, dynamic> json) {
  return _BadgeCityDto.fromJson(json);
}

/// @nodoc
mixin _$BadgeCityDto {
  String? get city => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BadgeCityDtoCopyWith<BadgeCityDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeCityDtoCopyWith<$Res> {
  factory $BadgeCityDtoCopyWith(
          BadgeCityDto value, $Res Function(BadgeCityDto) then) =
      _$BadgeCityDtoCopyWithImpl<$Res, BadgeCityDto>;
  @useResult
  $Res call({String? city, String? country});
}

/// @nodoc
class _$BadgeCityDtoCopyWithImpl<$Res, $Val extends BadgeCityDto>
    implements $BadgeCityDtoCopyWith<$Res> {
  _$BadgeCityDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = freezed,
    Object? country = freezed,
  }) {
    return _then(_value.copyWith(
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BadgeCityDtoCopyWith<$Res>
    implements $BadgeCityDtoCopyWith<$Res> {
  factory _$$_BadgeCityDtoCopyWith(
          _$_BadgeCityDto value, $Res Function(_$_BadgeCityDto) then) =
      __$$_BadgeCityDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? city, String? country});
}

/// @nodoc
class __$$_BadgeCityDtoCopyWithImpl<$Res>
    extends _$BadgeCityDtoCopyWithImpl<$Res, _$_BadgeCityDto>
    implements _$$_BadgeCityDtoCopyWith<$Res> {
  __$$_BadgeCityDtoCopyWithImpl(
      _$_BadgeCityDto _value, $Res Function(_$_BadgeCityDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = freezed,
    Object? country = freezed,
  }) {
    return _then(_$_BadgeCityDto(
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BadgeCityDto implements _BadgeCityDto {
  _$_BadgeCityDto({this.city, this.country});

  factory _$_BadgeCityDto.fromJson(Map<String, dynamic> json) =>
      _$$_BadgeCityDtoFromJson(json);

  @override
  final String? city;
  @override
  final String? country;

  @override
  String toString() {
    return 'BadgeCityDto(city: $city, country: $country)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BadgeCityDto &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, city, country);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BadgeCityDtoCopyWith<_$_BadgeCityDto> get copyWith =>
      __$$_BadgeCityDtoCopyWithImpl<_$_BadgeCityDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BadgeCityDtoToJson(
      this,
    );
  }
}

abstract class _BadgeCityDto implements BadgeCityDto {
  factory _BadgeCityDto({final String? city, final String? country}) =
      _$_BadgeCityDto;

  factory _BadgeCityDto.fromJson(Map<String, dynamic> json) =
      _$_BadgeCityDto.fromJson;

  @override
  String? get city;
  @override
  String? get country;
  @override
  @JsonKey(ignore: true)
  _$$_BadgeCityDtoCopyWith<_$_BadgeCityDto> get copyWith =>
      throw _privateConstructorUsedError;
}
