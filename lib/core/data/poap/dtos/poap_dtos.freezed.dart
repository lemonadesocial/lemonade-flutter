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

TransferDto _$TransferDtoFromJson(Map<String, dynamic> json) {
  return _TransferDto.fromJson(json);
}

/// @nodoc
mixin _$TransferDto {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get network => throw _privateConstructorUsedError;
  TransferState? get state => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  TransferArgsDto? get args => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get tokenId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferDtoCopyWith<TransferDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferDtoCopyWith<$Res> {
  factory $TransferDtoCopyWith(
          TransferDto value, $Res Function(TransferDto) then) =
      _$TransferDtoCopyWithImpl<$Res, TransferDto>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? network,
      TransferState? state,
      String? errorMessage,
      TransferArgsDto? args,
      String? address,
      String? tokenId});

  $TransferArgsDtoCopyWith<$Res>? get args;
}

/// @nodoc
class _$TransferDtoCopyWithImpl<$Res, $Val extends TransferDto>
    implements $TransferDtoCopyWith<$Res> {
  _$TransferDtoCopyWithImpl(this._value, this._then);

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
              as TransferState?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      args: freezed == args
          ? _value.args
          : args // ignore: cast_nullable_to_non_nullable
              as TransferArgsDto?,
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
  $TransferArgsDtoCopyWith<$Res>? get args {
    if (_value.args == null) {
      return null;
    }

    return $TransferArgsDtoCopyWith<$Res>(_value.args!, (value) {
      return _then(_value.copyWith(args: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TransferDtoCopyWith<$Res>
    implements $TransferDtoCopyWith<$Res> {
  factory _$$_TransferDtoCopyWith(
          _$_TransferDto value, $Res Function(_$_TransferDto) then) =
      __$$_TransferDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? network,
      TransferState? state,
      String? errorMessage,
      TransferArgsDto? args,
      String? address,
      String? tokenId});

  @override
  $TransferArgsDtoCopyWith<$Res>? get args;
}

/// @nodoc
class __$$_TransferDtoCopyWithImpl<$Res>
    extends _$TransferDtoCopyWithImpl<$Res, _$_TransferDto>
    implements _$$_TransferDtoCopyWith<$Res> {
  __$$_TransferDtoCopyWithImpl(
      _$_TransferDto _value, $Res Function(_$_TransferDto) _then)
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
    return _then(_$_TransferDto(
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
              as TransferState?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      args: freezed == args
          ? _value.args
          : args // ignore: cast_nullable_to_non_nullable
              as TransferArgsDto?,
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
class _$_TransferDto implements _TransferDto {
  const _$_TransferDto(
      {@JsonKey(name: '_id') this.id,
      this.network,
      this.state,
      this.errorMessage,
      this.args,
      this.address,
      this.tokenId});

  factory _$_TransferDto.fromJson(Map<String, dynamic> json) =>
      _$$_TransferDtoFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? network;
  @override
  final TransferState? state;
  @override
  final String? errorMessage;
  @override
  final TransferArgsDto? args;
  @override
  final String? address;
  @override
  final String? tokenId;

  @override
  String toString() {
    return 'TransferDto(id: $id, network: $network, state: $state, errorMessage: $errorMessage, args: $args, address: $address, tokenId: $tokenId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransferDto &&
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
  _$$_TransferDtoCopyWith<_$_TransferDto> get copyWith =>
      __$$_TransferDtoCopyWithImpl<_$_TransferDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransferDtoToJson(
      this,
    );
  }
}

abstract class _TransferDto implements TransferDto {
  const factory _TransferDto(
      {@JsonKey(name: '_id') final String? id,
      final String? network,
      final TransferState? state,
      final String? errorMessage,
      final TransferArgsDto? args,
      final String? address,
      final String? tokenId}) = _$_TransferDto;

  factory _TransferDto.fromJson(Map<String, dynamic> json) =
      _$_TransferDto.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get network;
  @override
  TransferState? get state;
  @override
  String? get errorMessage;
  @override
  TransferArgsDto? get args;
  @override
  String? get address;
  @override
  String? get tokenId;
  @override
  @JsonKey(ignore: true)
  _$$_TransferDtoCopyWith<_$_TransferDto> get copyWith =>
      throw _privateConstructorUsedError;
}

TransferArgsDto _$TransferArgsDtoFromJson(Map<String, dynamic> json) {
  return _TransferArgsDto.fromJson(json);
}

/// @nodoc
mixin _$TransferArgsDto {
  String? get claimer => throw _privateConstructorUsedError;
  String? get tokenURI => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferArgsDtoCopyWith<TransferArgsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferArgsDtoCopyWith<$Res> {
  factory $TransferArgsDtoCopyWith(
          TransferArgsDto value, $Res Function(TransferArgsDto) then) =
      _$TransferArgsDtoCopyWithImpl<$Res, TransferArgsDto>;
  @useResult
  $Res call({String? claimer, String? tokenURI});
}

/// @nodoc
class _$TransferArgsDtoCopyWithImpl<$Res, $Val extends TransferArgsDto>
    implements $TransferArgsDtoCopyWith<$Res> {
  _$TransferArgsDtoCopyWithImpl(this._value, this._then);

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
abstract class _$$_TransferArgsDtoCopyWith<$Res>
    implements $TransferArgsDtoCopyWith<$Res> {
  factory _$$_TransferArgsDtoCopyWith(
          _$_TransferArgsDto value, $Res Function(_$_TransferArgsDto) then) =
      __$$_TransferArgsDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? claimer, String? tokenURI});
}

/// @nodoc
class __$$_TransferArgsDtoCopyWithImpl<$Res>
    extends _$TransferArgsDtoCopyWithImpl<$Res, _$_TransferArgsDto>
    implements _$$_TransferArgsDtoCopyWith<$Res> {
  __$$_TransferArgsDtoCopyWithImpl(
      _$_TransferArgsDto _value, $Res Function(_$_TransferArgsDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claimer = freezed,
    Object? tokenURI = freezed,
  }) {
    return _then(_$_TransferArgsDto(
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
class _$_TransferArgsDto implements _TransferArgsDto {
  const _$_TransferArgsDto({this.claimer, this.tokenURI});

  factory _$_TransferArgsDto.fromJson(Map<String, dynamic> json) =>
      _$$_TransferArgsDtoFromJson(json);

  @override
  final String? claimer;
  @override
  final String? tokenURI;

  @override
  String toString() {
    return 'TransferArgsDto(claimer: $claimer, tokenURI: $tokenURI)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransferArgsDto &&
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
  _$$_TransferArgsDtoCopyWith<_$_TransferArgsDto> get copyWith =>
      __$$_TransferArgsDtoCopyWithImpl<_$_TransferArgsDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransferArgsDtoToJson(
      this,
    );
  }
}

abstract class _TransferArgsDto implements TransferArgsDto {
  const factory _TransferArgsDto(
      {final String? claimer, final String? tokenURI}) = _$_TransferArgsDto;

  factory _TransferArgsDto.fromJson(Map<String, dynamic> json) =
      _$_TransferArgsDto.fromJson;

  @override
  String? get claimer;
  @override
  String? get tokenURI;
  @override
  @JsonKey(ignore: true)
  _$$_TransferArgsDtoCopyWith<_$_TransferArgsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

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

PoapPolicyNodeDto _$PoapPolicyNodeDtoFromJson(Map<String, dynamic> json) {
  return _PoapPolicyNodeDto.fromJson(json);
}

/// @nodoc
mixin _$PoapPolicyNodeDto {
  String get value => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: <PoapPolicyNodeDto>[])
  List<PoapPolicyNodeDto>? get children => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PoapPolicyNodeDtoCopyWith<PoapPolicyNodeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoapPolicyNodeDtoCopyWith<$Res> {
  factory $PoapPolicyNodeDtoCopyWith(
          PoapPolicyNodeDto value, $Res Function(PoapPolicyNodeDto) then) =
      _$PoapPolicyNodeDtoCopyWithImpl<$Res, PoapPolicyNodeDto>;
  @useResult
  $Res call(
      {String value,
      @JsonKey(defaultValue: <PoapPolicyNodeDto>[])
      List<PoapPolicyNodeDto>? children});
}

/// @nodoc
class _$PoapPolicyNodeDtoCopyWithImpl<$Res, $Val extends PoapPolicyNodeDto>
    implements $PoapPolicyNodeDtoCopyWith<$Res> {
  _$PoapPolicyNodeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? children = freezed,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      children: freezed == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<PoapPolicyNodeDto>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PoapPolicyNodeDtoCopyWith<$Res>
    implements $PoapPolicyNodeDtoCopyWith<$Res> {
  factory _$$_PoapPolicyNodeDtoCopyWith(_$_PoapPolicyNodeDto value,
          $Res Function(_$_PoapPolicyNodeDto) then) =
      __$$_PoapPolicyNodeDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String value,
      @JsonKey(defaultValue: <PoapPolicyNodeDto>[])
      List<PoapPolicyNodeDto>? children});
}

/// @nodoc
class __$$_PoapPolicyNodeDtoCopyWithImpl<$Res>
    extends _$PoapPolicyNodeDtoCopyWithImpl<$Res, _$_PoapPolicyNodeDto>
    implements _$$_PoapPolicyNodeDtoCopyWith<$Res> {
  __$$_PoapPolicyNodeDtoCopyWithImpl(
      _$_PoapPolicyNodeDto _value, $Res Function(_$_PoapPolicyNodeDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? children = freezed,
  }) {
    return _then(_$_PoapPolicyNodeDto(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      children: freezed == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<PoapPolicyNodeDto>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PoapPolicyNodeDto implements _PoapPolicyNodeDto {
  const _$_PoapPolicyNodeDto(
      {required this.value,
      @JsonKey(defaultValue: <PoapPolicyNodeDto>[])
      final List<PoapPolicyNodeDto>? children})
      : _children = children;

  factory _$_PoapPolicyNodeDto.fromJson(Map<String, dynamic> json) =>
      _$$_PoapPolicyNodeDtoFromJson(json);

  @override
  final String value;
  final List<PoapPolicyNodeDto>? _children;
  @override
  @JsonKey(defaultValue: <PoapPolicyNodeDto>[])
  List<PoapPolicyNodeDto>? get children {
    final value = _children;
    if (value == null) return null;
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PoapPolicyNodeDto(value: $value, children: $children)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PoapPolicyNodeDto &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, value, const DeepCollectionEquality().hash(_children));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PoapPolicyNodeDtoCopyWith<_$_PoapPolicyNodeDto> get copyWith =>
      __$$_PoapPolicyNodeDtoCopyWithImpl<_$_PoapPolicyNodeDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PoapPolicyNodeDtoToJson(
      this,
    );
  }
}

abstract class _PoapPolicyNodeDto implements PoapPolicyNodeDto {
  const factory _PoapPolicyNodeDto(
      {required final String value,
      @JsonKey(defaultValue: <PoapPolicyNodeDto>[])
      final List<PoapPolicyNodeDto>? children}) = _$_PoapPolicyNodeDto;

  factory _PoapPolicyNodeDto.fromJson(Map<String, dynamic> json) =
      _$_PoapPolicyNodeDto.fromJson;

  @override
  String get value;
  @override
  @JsonKey(defaultValue: <PoapPolicyNodeDto>[])
  List<PoapPolicyNodeDto>? get children;
  @override
  @JsonKey(ignore: true)
  _$$_PoapPolicyNodeDtoCopyWith<_$_PoapPolicyNodeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

PoapPolicyErrorDto _$PoapPolicyErrorDtoFromJson(Map<String, dynamic> json) {
  return _PoapPolicyErrorDto.fromJson(json);
}

/// @nodoc
mixin _$PoapPolicyErrorDto {
  String? get message => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PoapPolicyErrorDtoCopyWith<PoapPolicyErrorDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoapPolicyErrorDtoCopyWith<$Res> {
  factory $PoapPolicyErrorDtoCopyWith(
          PoapPolicyErrorDto value, $Res Function(PoapPolicyErrorDto) then) =
      _$PoapPolicyErrorDtoCopyWithImpl<$Res, PoapPolicyErrorDto>;
  @useResult
  $Res call({String? message, String? path});
}

/// @nodoc
class _$PoapPolicyErrorDtoCopyWithImpl<$Res, $Val extends PoapPolicyErrorDto>
    implements $PoapPolicyErrorDtoCopyWith<$Res> {
  _$PoapPolicyErrorDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? path = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PoapPolicyErrorDtoCopyWith<$Res>
    implements $PoapPolicyErrorDtoCopyWith<$Res> {
  factory _$$_PoapPolicyErrorDtoCopyWith(_$_PoapPolicyErrorDto value,
          $Res Function(_$_PoapPolicyErrorDto) then) =
      __$$_PoapPolicyErrorDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, String? path});
}

/// @nodoc
class __$$_PoapPolicyErrorDtoCopyWithImpl<$Res>
    extends _$PoapPolicyErrorDtoCopyWithImpl<$Res, _$_PoapPolicyErrorDto>
    implements _$$_PoapPolicyErrorDtoCopyWith<$Res> {
  __$$_PoapPolicyErrorDtoCopyWithImpl(
      _$_PoapPolicyErrorDto _value, $Res Function(_$_PoapPolicyErrorDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? path = freezed,
  }) {
    return _then(_$_PoapPolicyErrorDto(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PoapPolicyErrorDto implements _PoapPolicyErrorDto {
  const _$_PoapPolicyErrorDto({this.message, this.path});

  factory _$_PoapPolicyErrorDto.fromJson(Map<String, dynamic> json) =>
      _$$_PoapPolicyErrorDtoFromJson(json);

  @override
  final String? message;
  @override
  final String? path;

  @override
  String toString() {
    return 'PoapPolicyErrorDto(message: $message, path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PoapPolicyErrorDto &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, path);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PoapPolicyErrorDtoCopyWith<_$_PoapPolicyErrorDto> get copyWith =>
      __$$_PoapPolicyErrorDtoCopyWithImpl<_$_PoapPolicyErrorDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PoapPolicyErrorDtoToJson(
      this,
    );
  }
}

abstract class _PoapPolicyErrorDto implements PoapPolicyErrorDto {
  const factory _PoapPolicyErrorDto(
      {final String? message, final String? path}) = _$_PoapPolicyErrorDto;

  factory _PoapPolicyErrorDto.fromJson(Map<String, dynamic> json) =
      _$_PoapPolicyErrorDto.fromJson;

  @override
  String? get message;
  @override
  String? get path;
  @override
  @JsonKey(ignore: true)
  _$$_PoapPolicyErrorDtoCopyWith<_$_PoapPolicyErrorDto> get copyWith =>
      throw _privateConstructorUsedError;
}

PoapPolicyResultDto _$PoapPolicyResultDtoFromJson(Map<String, dynamic> json) {
  return _PoapPolicyResultDto.fromJson(json);
}

/// @nodoc
mixin _$PoapPolicyResultDto {
  bool? get boolean => throw _privateConstructorUsedError;
  PoapPolicyNodeDto? get node => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: <PoapPolicyErrorDto>[])
  List<PoapPolicyErrorDto>? get errors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PoapPolicyResultDtoCopyWith<PoapPolicyResultDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoapPolicyResultDtoCopyWith<$Res> {
  factory $PoapPolicyResultDtoCopyWith(
          PoapPolicyResultDto value, $Res Function(PoapPolicyResultDto) then) =
      _$PoapPolicyResultDtoCopyWithImpl<$Res, PoapPolicyResultDto>;
  @useResult
  $Res call(
      {bool? boolean,
      PoapPolicyNodeDto? node,
      @JsonKey(defaultValue: <PoapPolicyErrorDto>[])
      List<PoapPolicyErrorDto>? errors});

  $PoapPolicyNodeDtoCopyWith<$Res>? get node;
}

/// @nodoc
class _$PoapPolicyResultDtoCopyWithImpl<$Res, $Val extends PoapPolicyResultDto>
    implements $PoapPolicyResultDtoCopyWith<$Res> {
  _$PoapPolicyResultDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boolean = freezed,
    Object? node = freezed,
    Object? errors = freezed,
  }) {
    return _then(_value.copyWith(
      boolean: freezed == boolean
          ? _value.boolean
          : boolean // ignore: cast_nullable_to_non_nullable
              as bool?,
      node: freezed == node
          ? _value.node
          : node // ignore: cast_nullable_to_non_nullable
              as PoapPolicyNodeDto?,
      errors: freezed == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<PoapPolicyErrorDto>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PoapPolicyNodeDtoCopyWith<$Res>? get node {
    if (_value.node == null) {
      return null;
    }

    return $PoapPolicyNodeDtoCopyWith<$Res>(_value.node!, (value) {
      return _then(_value.copyWith(node: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PoapPolicyResultDtoCopyWith<$Res>
    implements $PoapPolicyResultDtoCopyWith<$Res> {
  factory _$$_PoapPolicyResultDtoCopyWith(_$_PoapPolicyResultDto value,
          $Res Function(_$_PoapPolicyResultDto) then) =
      __$$_PoapPolicyResultDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? boolean,
      PoapPolicyNodeDto? node,
      @JsonKey(defaultValue: <PoapPolicyErrorDto>[])
      List<PoapPolicyErrorDto>? errors});

  @override
  $PoapPolicyNodeDtoCopyWith<$Res>? get node;
}

/// @nodoc
class __$$_PoapPolicyResultDtoCopyWithImpl<$Res>
    extends _$PoapPolicyResultDtoCopyWithImpl<$Res, _$_PoapPolicyResultDto>
    implements _$$_PoapPolicyResultDtoCopyWith<$Res> {
  __$$_PoapPolicyResultDtoCopyWithImpl(_$_PoapPolicyResultDto _value,
      $Res Function(_$_PoapPolicyResultDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boolean = freezed,
    Object? node = freezed,
    Object? errors = freezed,
  }) {
    return _then(_$_PoapPolicyResultDto(
      boolean: freezed == boolean
          ? _value.boolean
          : boolean // ignore: cast_nullable_to_non_nullable
              as bool?,
      node: freezed == node
          ? _value.node
          : node // ignore: cast_nullable_to_non_nullable
              as PoapPolicyNodeDto?,
      errors: freezed == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<PoapPolicyErrorDto>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PoapPolicyResultDto implements _PoapPolicyResultDto {
  _$_PoapPolicyResultDto(
      {this.boolean,
      this.node,
      @JsonKey(defaultValue: <PoapPolicyErrorDto>[])
      final List<PoapPolicyErrorDto>? errors})
      : _errors = errors;

  factory _$_PoapPolicyResultDto.fromJson(Map<String, dynamic> json) =>
      _$$_PoapPolicyResultDtoFromJson(json);

  @override
  final bool? boolean;
  @override
  final PoapPolicyNodeDto? node;
  final List<PoapPolicyErrorDto>? _errors;
  @override
  @JsonKey(defaultValue: <PoapPolicyErrorDto>[])
  List<PoapPolicyErrorDto>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PoapPolicyResultDto(boolean: $boolean, node: $node, errors: $errors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PoapPolicyResultDto &&
            (identical(other.boolean, boolean) || other.boolean == boolean) &&
            (identical(other.node, node) || other.node == node) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, boolean, node, const DeepCollectionEquality().hash(_errors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PoapPolicyResultDtoCopyWith<_$_PoapPolicyResultDto> get copyWith =>
      __$$_PoapPolicyResultDtoCopyWithImpl<_$_PoapPolicyResultDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PoapPolicyResultDtoToJson(
      this,
    );
  }
}

abstract class _PoapPolicyResultDto implements PoapPolicyResultDto {
  factory _PoapPolicyResultDto(
      {final bool? boolean,
      final PoapPolicyNodeDto? node,
      @JsonKey(defaultValue: <PoapPolicyErrorDto>[])
      final List<PoapPolicyErrorDto>? errors}) = _$_PoapPolicyResultDto;

  factory _PoapPolicyResultDto.fromJson(Map<String, dynamic> json) =
      _$_PoapPolicyResultDto.fromJson;

  @override
  bool? get boolean;
  @override
  PoapPolicyNodeDto? get node;
  @override
  @JsonKey(defaultValue: <PoapPolicyErrorDto>[])
  List<PoapPolicyErrorDto>? get errors;
  @override
  @JsonKey(ignore: true)
  _$$_PoapPolicyResultDtoCopyWith<_$_PoapPolicyResultDto> get copyWith =>
      throw _privateConstructorUsedError;
}

PoapPolicyDto _$PoapPolicyDtoFromJson(Map<String, dynamic> json) {
  return _PoapPolicyDto.fromJson(json);
}

/// @nodoc
mixin _$PoapPolicyDto {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get network => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  PoapPolicyNodeDto? get node => throw _privateConstructorUsedError;
  PoapPolicyResultDto? get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PoapPolicyDtoCopyWith<PoapPolicyDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoapPolicyDtoCopyWith<$Res> {
  factory $PoapPolicyDtoCopyWith(
          PoapPolicyDto value, $Res Function(PoapPolicyDto) then) =
      _$PoapPolicyDtoCopyWithImpl<$Res, PoapPolicyDto>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? network,
      String? address,
      PoapPolicyNodeDto? node,
      PoapPolicyResultDto? result});

  $PoapPolicyNodeDtoCopyWith<$Res>? get node;
  $PoapPolicyResultDtoCopyWith<$Res>? get result;
}

/// @nodoc
class _$PoapPolicyDtoCopyWithImpl<$Res, $Val extends PoapPolicyDto>
    implements $PoapPolicyDtoCopyWith<$Res> {
  _$PoapPolicyDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? network = freezed,
    Object? address = freezed,
    Object? node = freezed,
    Object? result = freezed,
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
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      node: freezed == node
          ? _value.node
          : node // ignore: cast_nullable_to_non_nullable
              as PoapPolicyNodeDto?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as PoapPolicyResultDto?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PoapPolicyNodeDtoCopyWith<$Res>? get node {
    if (_value.node == null) {
      return null;
    }

    return $PoapPolicyNodeDtoCopyWith<$Res>(_value.node!, (value) {
      return _then(_value.copyWith(node: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PoapPolicyResultDtoCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $PoapPolicyResultDtoCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PoapPolicyDtoCopyWith<$Res>
    implements $PoapPolicyDtoCopyWith<$Res> {
  factory _$$_PoapPolicyDtoCopyWith(
          _$_PoapPolicyDto value, $Res Function(_$_PoapPolicyDto) then) =
      __$$_PoapPolicyDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? network,
      String? address,
      PoapPolicyNodeDto? node,
      PoapPolicyResultDto? result});

  @override
  $PoapPolicyNodeDtoCopyWith<$Res>? get node;
  @override
  $PoapPolicyResultDtoCopyWith<$Res>? get result;
}

/// @nodoc
class __$$_PoapPolicyDtoCopyWithImpl<$Res>
    extends _$PoapPolicyDtoCopyWithImpl<$Res, _$_PoapPolicyDto>
    implements _$$_PoapPolicyDtoCopyWith<$Res> {
  __$$_PoapPolicyDtoCopyWithImpl(
      _$_PoapPolicyDto _value, $Res Function(_$_PoapPolicyDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? network = freezed,
    Object? address = freezed,
    Object? node = freezed,
    Object? result = freezed,
  }) {
    return _then(_$_PoapPolicyDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      node: freezed == node
          ? _value.node
          : node // ignore: cast_nullable_to_non_nullable
              as PoapPolicyNodeDto?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as PoapPolicyResultDto?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PoapPolicyDto implements _PoapPolicyDto {
  _$_PoapPolicyDto(
      {@JsonKey(name: '_id') this.id,
      this.network,
      this.address,
      this.node,
      this.result});

  factory _$_PoapPolicyDto.fromJson(Map<String, dynamic> json) =>
      _$$_PoapPolicyDtoFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? network;
  @override
  final String? address;
  @override
  final PoapPolicyNodeDto? node;
  @override
  final PoapPolicyResultDto? result;

  @override
  String toString() {
    return 'PoapPolicyDto(id: $id, network: $network, address: $address, node: $node, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PoapPolicyDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.node, node) || other.node == node) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, network, address, node, result);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PoapPolicyDtoCopyWith<_$_PoapPolicyDto> get copyWith =>
      __$$_PoapPolicyDtoCopyWithImpl<_$_PoapPolicyDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PoapPolicyDtoToJson(
      this,
    );
  }
}

abstract class _PoapPolicyDto implements PoapPolicyDto {
  factory _PoapPolicyDto(
      {@JsonKey(name: '_id') final String? id,
      final String? network,
      final String? address,
      final PoapPolicyNodeDto? node,
      final PoapPolicyResultDto? result}) = _$_PoapPolicyDto;

  factory _PoapPolicyDto.fromJson(Map<String, dynamic> json) =
      _$_PoapPolicyDto.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get network;
  @override
  String? get address;
  @override
  PoapPolicyNodeDto? get node;
  @override
  PoapPolicyResultDto? get result;
  @override
  @JsonKey(ignore: true)
  _$$_PoapPolicyDtoCopyWith<_$_PoapPolicyDto> get copyWith =>
      throw _privateConstructorUsedError;
}
