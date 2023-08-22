// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poap_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClaimDto _$ClaimDtoFromJson(Map<String, dynamic> json) {
  return _ClaimDto.fromJson(json);
}

/// @nodoc
mixin _$ClaimDto {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get network => throw _privateConstructorUsedError;
  ClaimState? get state => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  ClaimArgsDto? get args => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get tokenId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClaimDtoCopyWith<ClaimDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaimDtoCopyWith<$Res> {
  factory $ClaimDtoCopyWith(ClaimDto value, $Res Function(ClaimDto) then) =
      _$ClaimDtoCopyWithImpl<$Res, ClaimDto>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? network,
      ClaimState? state,
      String? errorMessage,
      ClaimArgsDto? args,
      String? address,
      String? tokenId});

  $ClaimArgsDtoCopyWith<$Res>? get args;
}

/// @nodoc
class _$ClaimDtoCopyWithImpl<$Res, $Val extends ClaimDto>
    implements $ClaimDtoCopyWith<$Res> {
  _$ClaimDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? network = freezed,
    Object? state = freezed,
    Object? errorMessage = freezed,
    Object? args = freezed,
    Object? address = freezed,
    Object? tokenId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ClaimState?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      args: freezed == args
          ? _value.args
          : args // ignore: cast_nullable_to_non_nullable
              as ClaimArgsDto?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenId: freezed == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClaimArgsDtoCopyWith<$Res>? get args {
    if (_value.args == null) {
      return null;
    }

    return $ClaimArgsDtoCopyWith<$Res>(_value.args!, (value) {
      return _then(_value.copyWith(args: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ClaimDtoCopyWith<$Res> implements $ClaimDtoCopyWith<$Res> {
  factory _$$_ClaimDtoCopyWith(
          _$_ClaimDto value, $Res Function(_$_ClaimDto) then) =
      __$$_ClaimDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? network,
      ClaimState? state,
      String? errorMessage,
      ClaimArgsDto? args,
      String? address,
      String? tokenId});

  @override
  $ClaimArgsDtoCopyWith<$Res>? get args;
}

/// @nodoc
class __$$_ClaimDtoCopyWithImpl<$Res>
    extends _$ClaimDtoCopyWithImpl<$Res, _$_ClaimDto>
    implements _$$_ClaimDtoCopyWith<$Res> {
  __$$_ClaimDtoCopyWithImpl(
      _$_ClaimDto _value, $Res Function(_$_ClaimDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? network = freezed,
    Object? state = freezed,
    Object? errorMessage = freezed,
    Object? args = freezed,
    Object? address = freezed,
    Object? tokenId = freezed,
  }) {
    return _then(_$_ClaimDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ClaimState?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      args: freezed == args
          ? _value.args
          : args // ignore: cast_nullable_to_non_nullable
              as ClaimArgsDto?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenId: freezed == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClaimDto implements _ClaimDto {
  const _$_ClaimDto(
      {@JsonKey(name: '_id') this.id,
      this.network,
      this.state,
      this.errorMessage,
      this.args,
      this.address,
      this.tokenId});

  factory _$_ClaimDto.fromJson(Map<String, dynamic> json) =>
      _$$_ClaimDtoFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? network;
  @override
  final ClaimState? state;
  @override
  final String? errorMessage;
  @override
  final ClaimArgsDto? args;
  @override
  final String? address;
  @override
  final String? tokenId;

  @override
  String toString() {
    return 'ClaimDto(id: $id, network: $network, state: $state, errorMessage: $errorMessage, args: $args, address: $address, tokenId: $tokenId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClaimDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.args, args) || other.args == args) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.tokenId, tokenId) || other.tokenId == tokenId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, network, state, errorMessage, args, address, tokenId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClaimDtoCopyWith<_$_ClaimDto> get copyWith =>
      __$$_ClaimDtoCopyWithImpl<_$_ClaimDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClaimDtoToJson(
      this,
    );
  }
}

abstract class _ClaimDto implements ClaimDto {
  const factory _ClaimDto(
      {@JsonKey(name: '_id') final String? id,
      final String? network,
      final ClaimState? state,
      final String? errorMessage,
      final ClaimArgsDto? args,
      final String? address,
      final String? tokenId}) = _$_ClaimDto;

  factory _ClaimDto.fromJson(Map<String, dynamic> json) = _$_ClaimDto.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get network;
  @override
  ClaimState? get state;
  @override
  String? get errorMessage;
  @override
  ClaimArgsDto? get args;
  @override
  String? get address;
  @override
  String? get tokenId;
  @override
  @JsonKey(ignore: true)
  _$$_ClaimDtoCopyWith<_$_ClaimDto> get copyWith =>
      throw _privateConstructorUsedError;
}

ClaimArgsDto _$ClaimArgsDtoFromJson(Map<String, dynamic> json) {
  return _ClaimArgsDto.fromJson(json);
}

/// @nodoc
mixin _$ClaimArgsDto {
  String? get claimer => throw _privateConstructorUsedError;
  String? get tokenURI => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClaimArgsDtoCopyWith<ClaimArgsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaimArgsDtoCopyWith<$Res> {
  factory $ClaimArgsDtoCopyWith(
          ClaimArgsDto value, $Res Function(ClaimArgsDto) then) =
      _$ClaimArgsDtoCopyWithImpl<$Res, ClaimArgsDto>;
  @useResult
  $Res call({String? claimer, String? tokenURI});
}

/// @nodoc
class _$ClaimArgsDtoCopyWithImpl<$Res, $Val extends ClaimArgsDto>
    implements $ClaimArgsDtoCopyWith<$Res> {
  _$ClaimArgsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claimer = freezed,
    Object? tokenURI = freezed,
  }) {
    return _then(_value.copyWith(
      claimer: freezed == claimer
          ? _value.claimer
          : claimer // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenURI: freezed == tokenURI
          ? _value.tokenURI
          : tokenURI // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClaimArgsDtoCopyWith<$Res>
    implements $ClaimArgsDtoCopyWith<$Res> {
  factory _$$_ClaimArgsDtoCopyWith(
          _$_ClaimArgsDto value, $Res Function(_$_ClaimArgsDto) then) =
      __$$_ClaimArgsDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? claimer, String? tokenURI});
}

/// @nodoc
class __$$_ClaimArgsDtoCopyWithImpl<$Res>
    extends _$ClaimArgsDtoCopyWithImpl<$Res, _$_ClaimArgsDto>
    implements _$$_ClaimArgsDtoCopyWith<$Res> {
  __$$_ClaimArgsDtoCopyWithImpl(
      _$_ClaimArgsDto _value, $Res Function(_$_ClaimArgsDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claimer = freezed,
    Object? tokenURI = freezed,
  }) {
    return _then(_$_ClaimArgsDto(
      claimer: freezed == claimer
          ? _value.claimer
          : claimer // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenURI: freezed == tokenURI
          ? _value.tokenURI
          : tokenURI // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClaimArgsDto implements _ClaimArgsDto {
  const _$_ClaimArgsDto({this.claimer, this.tokenURI});

  factory _$_ClaimArgsDto.fromJson(Map<String, dynamic> json) =>
      _$$_ClaimArgsDtoFromJson(json);

  @override
  final String? claimer;
  @override
  final String? tokenURI;

  @override
  String toString() {
    return 'ClaimArgsDto(claimer: $claimer, tokenURI: $tokenURI)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClaimArgsDto &&
            (identical(other.claimer, claimer) || other.claimer == claimer) &&
            (identical(other.tokenURI, tokenURI) ||
                other.tokenURI == tokenURI));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, claimer, tokenURI);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClaimArgsDtoCopyWith<_$_ClaimArgsDto> get copyWith =>
      __$$_ClaimArgsDtoCopyWithImpl<_$_ClaimArgsDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClaimArgsDtoToJson(
      this,
    );
  }
}

abstract class _ClaimArgsDto implements ClaimArgsDto {
  const factory _ClaimArgsDto({final String? claimer, final String? tokenURI}) =
      _$_ClaimArgsDto;

  factory _ClaimArgsDto.fromJson(Map<String, dynamic> json) =
      _$_ClaimArgsDto.fromJson;

  @override
  String? get claimer;
  @override
  String? get tokenURI;
  @override
  @JsonKey(ignore: true)
  _$$_ClaimArgsDtoCopyWith<_$_ClaimArgsDto> get copyWith =>
      throw _privateConstructorUsedError;
}
