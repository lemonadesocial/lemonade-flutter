// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TokenComplexDto _$TokenComplexDtoFromJson(Map<String, dynamic> json) {
  return _TokenComplexDto.fromJson(json);
}

/// @nodoc
mixin _$TokenComplexDto {
  String get id => throw _privateConstructorUsedError;
  String get network => throw _privateConstructorUsedError;
  String get tokenId => throw _privateConstructorUsedError;
  RegistryDto get registry => throw _privateConstructorUsedError;
  String get contract => throw _privateConstructorUsedError;
  OrderSimpleDto? get order => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get creator => throw _privateConstructorUsedError;
  UserDto? get creatorExpanded => throw _privateConstructorUsedError;
  double? get enrichCount => throw _privateConstructorUsedError;
  DateTime? get enrichedAt => throw _privateConstructorUsedError;
  String? get founder => throw _privateConstructorUsedError;
  UserDto? get founderExpanded => throw _privateConstructorUsedError;
  TokenMetadataDto? get metadata => throw _privateConstructorUsedError;
  List<dynamic>? get metadataCreatorsExpanded =>
      throw _privateConstructorUsedError;
  String? get owner => throw _privateConstructorUsedError;
  UserDto? get ownerExpanded => throw _privateConstructorUsedError;
  List<TokenRoyaltyDto>? get royalties => throw _privateConstructorUsedError;
  String? get uri => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenComplexDtoCopyWith<TokenComplexDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenComplexDtoCopyWith<$Res> {
  factory $TokenComplexDtoCopyWith(
          TokenComplexDto value, $Res Function(TokenComplexDto) then) =
      _$TokenComplexDtoCopyWithImpl<$Res, TokenComplexDto>;
  @useResult
  $Res call(
      {String id,
      String network,
      String tokenId,
      RegistryDto registry,
      String contract,
      OrderSimpleDto? order,
      DateTime? createdAt,
      String? creator,
      UserDto? creatorExpanded,
      double? enrichCount,
      DateTime? enrichedAt,
      String? founder,
      UserDto? founderExpanded,
      TokenMetadataDto? metadata,
      List<dynamic>? metadataCreatorsExpanded,
      String? owner,
      UserDto? ownerExpanded,
      List<TokenRoyaltyDto>? royalties,
      String? uri});

  $RegistryDtoCopyWith<$Res> get registry;
  $OrderSimpleDtoCopyWith<$Res>? get order;
  $UserDtoCopyWith<$Res>? get creatorExpanded;
  $UserDtoCopyWith<$Res>? get founderExpanded;
  $TokenMetadataDtoCopyWith<$Res>? get metadata;
  $UserDtoCopyWith<$Res>? get ownerExpanded;
}

/// @nodoc
class _$TokenComplexDtoCopyWithImpl<$Res, $Val extends TokenComplexDto>
    implements $TokenComplexDtoCopyWith<$Res> {
  _$TokenComplexDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? network = null,
    Object? tokenId = null,
    Object? registry = null,
    Object? contract = null,
    Object? order = freezed,
    Object? createdAt = freezed,
    Object? creator = freezed,
    Object? creatorExpanded = freezed,
    Object? enrichCount = freezed,
    Object? enrichedAt = freezed,
    Object? founder = freezed,
    Object? founderExpanded = freezed,
    Object? metadata = freezed,
    Object? metadataCreatorsExpanded = freezed,
    Object? owner = freezed,
    Object? ownerExpanded = freezed,
    Object? royalties = freezed,
    Object? uri = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      tokenId: null == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String,
      registry: null == registry
          ? _value.registry
          : registry // ignore: cast_nullable_to_non_nullable
              as RegistryDto,
      contract: null == contract
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as String,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderSimpleDto?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorExpanded: freezed == creatorExpanded
          ? _value.creatorExpanded
          : creatorExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      enrichCount: freezed == enrichCount
          ? _value.enrichCount
          : enrichCount // ignore: cast_nullable_to_non_nullable
              as double?,
      enrichedAt: freezed == enrichedAt
          ? _value.enrichedAt
          : enrichedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      founder: freezed == founder
          ? _value.founder
          : founder // ignore: cast_nullable_to_non_nullable
              as String?,
      founderExpanded: freezed == founderExpanded
          ? _value.founderExpanded
          : founderExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as TokenMetadataDto?,
      metadataCreatorsExpanded: freezed == metadataCreatorsExpanded
          ? _value.metadataCreatorsExpanded
          : metadataCreatorsExpanded // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      owner: freezed == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerExpanded: freezed == ownerExpanded
          ? _value.ownerExpanded
          : ownerExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      royalties: freezed == royalties
          ? _value.royalties
          : royalties // ignore: cast_nullable_to_non_nullable
              as List<TokenRoyaltyDto>?,
      uri: freezed == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RegistryDtoCopyWith<$Res> get registry {
    return $RegistryDtoCopyWith<$Res>(_value.registry, (value) {
      return _then(_value.copyWith(registry: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderSimpleDtoCopyWith<$Res>? get order {
    if (_value.order == null) {
      return null;
    }

    return $OrderSimpleDtoCopyWith<$Res>(_value.order!, (value) {
      return _then(_value.copyWith(order: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res>? get creatorExpanded {
    if (_value.creatorExpanded == null) {
      return null;
    }

    return $UserDtoCopyWith<$Res>(_value.creatorExpanded!, (value) {
      return _then(_value.copyWith(creatorExpanded: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res>? get founderExpanded {
    if (_value.founderExpanded == null) {
      return null;
    }

    return $UserDtoCopyWith<$Res>(_value.founderExpanded!, (value) {
      return _then(_value.copyWith(founderExpanded: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TokenMetadataDtoCopyWith<$Res>? get metadata {
    if (_value.metadata == null) {
      return null;
    }

    return $TokenMetadataDtoCopyWith<$Res>(_value.metadata!, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
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
abstract class _$$_TokenComplexDtoCopyWith<$Res>
    implements $TokenComplexDtoCopyWith<$Res> {
  factory _$$_TokenComplexDtoCopyWith(
          _$_TokenComplexDto value, $Res Function(_$_TokenComplexDto) then) =
      __$$_TokenComplexDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String network,
      String tokenId,
      RegistryDto registry,
      String contract,
      OrderSimpleDto? order,
      DateTime? createdAt,
      String? creator,
      UserDto? creatorExpanded,
      double? enrichCount,
      DateTime? enrichedAt,
      String? founder,
      UserDto? founderExpanded,
      TokenMetadataDto? metadata,
      List<dynamic>? metadataCreatorsExpanded,
      String? owner,
      UserDto? ownerExpanded,
      List<TokenRoyaltyDto>? royalties,
      String? uri});

  @override
  $RegistryDtoCopyWith<$Res> get registry;
  @override
  $OrderSimpleDtoCopyWith<$Res>? get order;
  @override
  $UserDtoCopyWith<$Res>? get creatorExpanded;
  @override
  $UserDtoCopyWith<$Res>? get founderExpanded;
  @override
  $TokenMetadataDtoCopyWith<$Res>? get metadata;
  @override
  $UserDtoCopyWith<$Res>? get ownerExpanded;
}

/// @nodoc
class __$$_TokenComplexDtoCopyWithImpl<$Res>
    extends _$TokenComplexDtoCopyWithImpl<$Res, _$_TokenComplexDto>
    implements _$$_TokenComplexDtoCopyWith<$Res> {
  __$$_TokenComplexDtoCopyWithImpl(
      _$_TokenComplexDto _value, $Res Function(_$_TokenComplexDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? network = null,
    Object? tokenId = null,
    Object? registry = null,
    Object? contract = null,
    Object? order = freezed,
    Object? createdAt = freezed,
    Object? creator = freezed,
    Object? creatorExpanded = freezed,
    Object? enrichCount = freezed,
    Object? enrichedAt = freezed,
    Object? founder = freezed,
    Object? founderExpanded = freezed,
    Object? metadata = freezed,
    Object? metadataCreatorsExpanded = freezed,
    Object? owner = freezed,
    Object? ownerExpanded = freezed,
    Object? royalties = freezed,
    Object? uri = freezed,
  }) {
    return _then(_$_TokenComplexDto(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      tokenId: null == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String,
      registry: null == registry
          ? _value.registry
          : registry // ignore: cast_nullable_to_non_nullable
              as RegistryDto,
      contract: null == contract
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as String,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderSimpleDto?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorExpanded: freezed == creatorExpanded
          ? _value.creatorExpanded
          : creatorExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      enrichCount: freezed == enrichCount
          ? _value.enrichCount
          : enrichCount // ignore: cast_nullable_to_non_nullable
              as double?,
      enrichedAt: freezed == enrichedAt
          ? _value.enrichedAt
          : enrichedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      founder: freezed == founder
          ? _value.founder
          : founder // ignore: cast_nullable_to_non_nullable
              as String?,
      founderExpanded: freezed == founderExpanded
          ? _value.founderExpanded
          : founderExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as TokenMetadataDto?,
      metadataCreatorsExpanded: freezed == metadataCreatorsExpanded
          ? _value._metadataCreatorsExpanded
          : metadataCreatorsExpanded // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      owner: freezed == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerExpanded: freezed == ownerExpanded
          ? _value.ownerExpanded
          : ownerExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      royalties: freezed == royalties
          ? _value._royalties
          : royalties // ignore: cast_nullable_to_non_nullable
              as List<TokenRoyaltyDto>?,
      uri: freezed == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TokenComplexDto implements _TokenComplexDto {
  const _$_TokenComplexDto(
      {required this.id,
      required this.network,
      required this.tokenId,
      required this.registry,
      required this.contract,
      this.order,
      this.createdAt,
      this.creator,
      this.creatorExpanded,
      this.enrichCount,
      this.enrichedAt,
      this.founder,
      this.founderExpanded,
      this.metadata,
      final List<dynamic>? metadataCreatorsExpanded,
      this.owner,
      this.ownerExpanded,
      final List<TokenRoyaltyDto>? royalties,
      this.uri})
      : _metadataCreatorsExpanded = metadataCreatorsExpanded,
        _royalties = royalties;

  factory _$_TokenComplexDto.fromJson(Map<String, dynamic> json) =>
      _$$_TokenComplexDtoFromJson(json);

  @override
  final String id;
  @override
  final String network;
  @override
  final String tokenId;
  @override
  final RegistryDto registry;
  @override
  final String contract;
  @override
  final OrderSimpleDto? order;
  @override
  final DateTime? createdAt;
  @override
  final String? creator;
  @override
  final UserDto? creatorExpanded;
  @override
  final double? enrichCount;
  @override
  final DateTime? enrichedAt;
  @override
  final String? founder;
  @override
  final UserDto? founderExpanded;
  @override
  final TokenMetadataDto? metadata;
  final List<dynamic>? _metadataCreatorsExpanded;
  @override
  List<dynamic>? get metadataCreatorsExpanded {
    final value = _metadataCreatorsExpanded;
    if (value == null) return null;
    if (_metadataCreatorsExpanded is EqualUnmodifiableListView)
      return _metadataCreatorsExpanded;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? owner;
  @override
  final UserDto? ownerExpanded;
  final List<TokenRoyaltyDto>? _royalties;
  @override
  List<TokenRoyaltyDto>? get royalties {
    final value = _royalties;
    if (value == null) return null;
    if (_royalties is EqualUnmodifiableListView) return _royalties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? uri;

  @override
  String toString() {
    return 'TokenComplexDto(id: $id, network: $network, tokenId: $tokenId, registry: $registry, contract: $contract, order: $order, createdAt: $createdAt, creator: $creator, creatorExpanded: $creatorExpanded, enrichCount: $enrichCount, enrichedAt: $enrichedAt, founder: $founder, founderExpanded: $founderExpanded, metadata: $metadata, metadataCreatorsExpanded: $metadataCreatorsExpanded, owner: $owner, ownerExpanded: $ownerExpanded, royalties: $royalties, uri: $uri)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TokenComplexDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.tokenId, tokenId) || other.tokenId == tokenId) &&
            (identical(other.registry, registry) ||
                other.registry == registry) &&
            (identical(other.contract, contract) ||
                other.contract == contract) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.creatorExpanded, creatorExpanded) ||
                other.creatorExpanded == creatorExpanded) &&
            (identical(other.enrichCount, enrichCount) ||
                other.enrichCount == enrichCount) &&
            (identical(other.enrichedAt, enrichedAt) ||
                other.enrichedAt == enrichedAt) &&
            (identical(other.founder, founder) || other.founder == founder) &&
            (identical(other.founderExpanded, founderExpanded) ||
                other.founderExpanded == founderExpanded) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            const DeepCollectionEquality().equals(
                other._metadataCreatorsExpanded, _metadataCreatorsExpanded) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.ownerExpanded, ownerExpanded) ||
                other.ownerExpanded == ownerExpanded) &&
            const DeepCollectionEquality()
                .equals(other._royalties, _royalties) &&
            (identical(other.uri, uri) || other.uri == uri));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        network,
        tokenId,
        registry,
        contract,
        order,
        createdAt,
        creator,
        creatorExpanded,
        enrichCount,
        enrichedAt,
        founder,
        founderExpanded,
        metadata,
        const DeepCollectionEquality().hash(_metadataCreatorsExpanded),
        owner,
        ownerExpanded,
        const DeepCollectionEquality().hash(_royalties),
        uri
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TokenComplexDtoCopyWith<_$_TokenComplexDto> get copyWith =>
      __$$_TokenComplexDtoCopyWithImpl<_$_TokenComplexDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokenComplexDtoToJson(
      this,
    );
  }
}

abstract class _TokenComplexDto implements TokenComplexDto {
  const factory _TokenComplexDto(
      {required final String id,
      required final String network,
      required final String tokenId,
      required final RegistryDto registry,
      required final String contract,
      final OrderSimpleDto? order,
      final DateTime? createdAt,
      final String? creator,
      final UserDto? creatorExpanded,
      final double? enrichCount,
      final DateTime? enrichedAt,
      final String? founder,
      final UserDto? founderExpanded,
      final TokenMetadataDto? metadata,
      final List<dynamic>? metadataCreatorsExpanded,
      final String? owner,
      final UserDto? ownerExpanded,
      final List<TokenRoyaltyDto>? royalties,
      final String? uri}) = _$_TokenComplexDto;

  factory _TokenComplexDto.fromJson(Map<String, dynamic> json) =
      _$_TokenComplexDto.fromJson;

  @override
  String get id;
  @override
  String get network;
  @override
  String get tokenId;
  @override
  RegistryDto get registry;
  @override
  String get contract;
  @override
  OrderSimpleDto? get order;
  @override
  DateTime? get createdAt;
  @override
  String? get creator;
  @override
  UserDto? get creatorExpanded;
  @override
  double? get enrichCount;
  @override
  DateTime? get enrichedAt;
  @override
  String? get founder;
  @override
  UserDto? get founderExpanded;
  @override
  TokenMetadataDto? get metadata;
  @override
  List<dynamic>? get metadataCreatorsExpanded;
  @override
  String? get owner;
  @override
  UserDto? get ownerExpanded;
  @override
  List<TokenRoyaltyDto>? get royalties;
  @override
  String? get uri;
  @override
  @JsonKey(ignore: true)
  _$$_TokenComplexDtoCopyWith<_$_TokenComplexDto> get copyWith =>
      throw _privateConstructorUsedError;
}

RegistryDto _$RegistryDtoFromJson(Map<String, dynamic> json) {
  return _RegistryDto.fromJson(json);
}

/// @nodoc
mixin _$RegistryDto {
  String? get id => throw _privateConstructorUsedError;
  String? get network => throw _privateConstructorUsedError;
  bool? get isERC721 => throw _privateConstructorUsedError;
  bool? get supportsERC721Metadata => throw _privateConstructorUsedError;
  bool? get supportsERC2981 => throw _privateConstructorUsedError;
  bool? get supportsLemonadePoapV1 => throw _privateConstructorUsedError;
  bool? get supportsRaribleRoyaltiesV2 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegistryDtoCopyWith<RegistryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistryDtoCopyWith<$Res> {
  factory $RegistryDtoCopyWith(
          RegistryDto value, $Res Function(RegistryDto) then) =
      _$RegistryDtoCopyWithImpl<$Res, RegistryDto>;
  @useResult
  $Res call(
      {String? id,
      String? network,
      bool? isERC721,
      bool? supportsERC721Metadata,
      bool? supportsERC2981,
      bool? supportsLemonadePoapV1,
      bool? supportsRaribleRoyaltiesV2});
}

/// @nodoc
class _$RegistryDtoCopyWithImpl<$Res, $Val extends RegistryDto>
    implements $RegistryDtoCopyWith<$Res> {
  _$RegistryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? network = freezed,
    Object? isERC721 = freezed,
    Object? supportsERC721Metadata = freezed,
    Object? supportsERC2981 = freezed,
    Object? supportsLemonadePoapV1 = freezed,
    Object? supportsRaribleRoyaltiesV2 = freezed,
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
      isERC721: freezed == isERC721
          ? _value.isERC721
          : isERC721 // ignore: cast_nullable_to_non_nullable
              as bool?,
      supportsERC721Metadata: freezed == supportsERC721Metadata
          ? _value.supportsERC721Metadata
          : supportsERC721Metadata // ignore: cast_nullable_to_non_nullable
              as bool?,
      supportsERC2981: freezed == supportsERC2981
          ? _value.supportsERC2981
          : supportsERC2981 // ignore: cast_nullable_to_non_nullable
              as bool?,
      supportsLemonadePoapV1: freezed == supportsLemonadePoapV1
          ? _value.supportsLemonadePoapV1
          : supportsLemonadePoapV1 // ignore: cast_nullable_to_non_nullable
              as bool?,
      supportsRaribleRoyaltiesV2: freezed == supportsRaribleRoyaltiesV2
          ? _value.supportsRaribleRoyaltiesV2
          : supportsRaribleRoyaltiesV2 // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegistryDtoCopyWith<$Res>
    implements $RegistryDtoCopyWith<$Res> {
  factory _$$_RegistryDtoCopyWith(
          _$_RegistryDto value, $Res Function(_$_RegistryDto) then) =
      __$$_RegistryDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? network,
      bool? isERC721,
      bool? supportsERC721Metadata,
      bool? supportsERC2981,
      bool? supportsLemonadePoapV1,
      bool? supportsRaribleRoyaltiesV2});
}

/// @nodoc
class __$$_RegistryDtoCopyWithImpl<$Res>
    extends _$RegistryDtoCopyWithImpl<$Res, _$_RegistryDto>
    implements _$$_RegistryDtoCopyWith<$Res> {
  __$$_RegistryDtoCopyWithImpl(
      _$_RegistryDto _value, $Res Function(_$_RegistryDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? network = freezed,
    Object? isERC721 = freezed,
    Object? supportsERC721Metadata = freezed,
    Object? supportsERC2981 = freezed,
    Object? supportsLemonadePoapV1 = freezed,
    Object? supportsRaribleRoyaltiesV2 = freezed,
  }) {
    return _then(_$_RegistryDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      isERC721: freezed == isERC721
          ? _value.isERC721
          : isERC721 // ignore: cast_nullable_to_non_nullable
              as bool?,
      supportsERC721Metadata: freezed == supportsERC721Metadata
          ? _value.supportsERC721Metadata
          : supportsERC721Metadata // ignore: cast_nullable_to_non_nullable
              as bool?,
      supportsERC2981: freezed == supportsERC2981
          ? _value.supportsERC2981
          : supportsERC2981 // ignore: cast_nullable_to_non_nullable
              as bool?,
      supportsLemonadePoapV1: freezed == supportsLemonadePoapV1
          ? _value.supportsLemonadePoapV1
          : supportsLemonadePoapV1 // ignore: cast_nullable_to_non_nullable
              as bool?,
      supportsRaribleRoyaltiesV2: freezed == supportsRaribleRoyaltiesV2
          ? _value.supportsRaribleRoyaltiesV2
          : supportsRaribleRoyaltiesV2 // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RegistryDto implements _RegistryDto {
  const _$_RegistryDto(
      {this.id,
      this.network,
      this.isERC721,
      this.supportsERC721Metadata,
      this.supportsERC2981,
      this.supportsLemonadePoapV1,
      this.supportsRaribleRoyaltiesV2});

  factory _$_RegistryDto.fromJson(Map<String, dynamic> json) =>
      _$$_RegistryDtoFromJson(json);

  @override
  final String? id;
  @override
  final String? network;
  @override
  final bool? isERC721;
  @override
  final bool? supportsERC721Metadata;
  @override
  final bool? supportsERC2981;
  @override
  final bool? supportsLemonadePoapV1;
  @override
  final bool? supportsRaribleRoyaltiesV2;

  @override
  String toString() {
    return 'RegistryDto(id: $id, network: $network, isERC721: $isERC721, supportsERC721Metadata: $supportsERC721Metadata, supportsERC2981: $supportsERC2981, supportsLemonadePoapV1: $supportsLemonadePoapV1, supportsRaribleRoyaltiesV2: $supportsRaribleRoyaltiesV2)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegistryDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.isERC721, isERC721) ||
                other.isERC721 == isERC721) &&
            (identical(other.supportsERC721Metadata, supportsERC721Metadata) ||
                other.supportsERC721Metadata == supportsERC721Metadata) &&
            (identical(other.supportsERC2981, supportsERC2981) ||
                other.supportsERC2981 == supportsERC2981) &&
            (identical(other.supportsLemonadePoapV1, supportsLemonadePoapV1) ||
                other.supportsLemonadePoapV1 == supportsLemonadePoapV1) &&
            (identical(other.supportsRaribleRoyaltiesV2,
                    supportsRaribleRoyaltiesV2) ||
                other.supportsRaribleRoyaltiesV2 ==
                    supportsRaribleRoyaltiesV2));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      network,
      isERC721,
      supportsERC721Metadata,
      supportsERC2981,
      supportsLemonadePoapV1,
      supportsRaribleRoyaltiesV2);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegistryDtoCopyWith<_$_RegistryDto> get copyWith =>
      __$$_RegistryDtoCopyWithImpl<_$_RegistryDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RegistryDtoToJson(
      this,
    );
  }
}

abstract class _RegistryDto implements RegistryDto {
  const factory _RegistryDto(
      {final String? id,
      final String? network,
      final bool? isERC721,
      final bool? supportsERC721Metadata,
      final bool? supportsERC2981,
      final bool? supportsLemonadePoapV1,
      final bool? supportsRaribleRoyaltiesV2}) = _$_RegistryDto;

  factory _RegistryDto.fromJson(Map<String, dynamic> json) =
      _$_RegistryDto.fromJson;

  @override
  String? get id;
  @override
  String? get network;
  @override
  bool? get isERC721;
  @override
  bool? get supportsERC721Metadata;
  @override
  bool? get supportsERC2981;
  @override
  bool? get supportsLemonadePoapV1;
  @override
  bool? get supportsRaribleRoyaltiesV2;
  @override
  @JsonKey(ignore: true)
  _$$_RegistryDtoCopyWith<_$_RegistryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderSimpleDto _$OrderSimpleDtoFromJson(Map<String, dynamic> json) {
  return _OrderSimpleDto.fromJson(json);
}

/// @nodoc
mixin _$OrderSimpleDto {
  String get id => throw _privateConstructorUsedError;
  String get contract => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  OrderKind get kind => throw _privateConstructorUsedError;
  String get maker => throw _privateConstructorUsedError;
  String get network => throw _privateConstructorUsedError;
  bool get open => throw _privateConstructorUsedError;
  String get orderId => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  String? get bidAmount => throw _privateConstructorUsedError;
  String? get bidder => throw _privateConstructorUsedError;
  OrderCurrencyDto? get currency => throw _privateConstructorUsedError;
  UserDto? get makerExpanded => throw _privateConstructorUsedError;
  DateTime? get openFrom => throw _privateConstructorUsedError;
  DateTime? get openTo => throw _privateConstructorUsedError;
  String? get paidAmount => throw _privateConstructorUsedError;
  String? get taker => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderSimpleDtoCopyWith<OrderSimpleDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderSimpleDtoCopyWith<$Res> {
  factory $OrderSimpleDtoCopyWith(
          OrderSimpleDto value, $Res Function(OrderSimpleDto) then) =
      _$OrderSimpleDtoCopyWithImpl<$Res, OrderSimpleDto>;
  @useResult
  $Res call(
      {String id,
      String contract,
      DateTime createdAt,
      OrderKind kind,
      String maker,
      String network,
      bool open,
      String orderId,
      String price,
      String token,
      String? bidAmount,
      String? bidder,
      OrderCurrencyDto? currency,
      UserDto? makerExpanded,
      DateTime? openFrom,
      DateTime? openTo,
      String? paidAmount,
      String? taker,
      DateTime? updatedAt});

  $OrderCurrencyDtoCopyWith<$Res>? get currency;
  $UserDtoCopyWith<$Res>? get makerExpanded;
}

/// @nodoc
class _$OrderSimpleDtoCopyWithImpl<$Res, $Val extends OrderSimpleDto>
    implements $OrderSimpleDtoCopyWith<$Res> {
  _$OrderSimpleDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contract = null,
    Object? createdAt = null,
    Object? kind = null,
    Object? maker = null,
    Object? network = null,
    Object? open = null,
    Object? orderId = null,
    Object? price = null,
    Object? token = null,
    Object? bidAmount = freezed,
    Object? bidder = freezed,
    Object? currency = freezed,
    Object? makerExpanded = freezed,
    Object? openFrom = freezed,
    Object? openTo = freezed,
    Object? paidAmount = freezed,
    Object? taker = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      contract: null == contract
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as OrderKind,
      maker: null == maker
          ? _value.maker
          : maker // ignore: cast_nullable_to_non_nullable
              as String,
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as bool,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      bidAmount: freezed == bidAmount
          ? _value.bidAmount
          : bidAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      bidder: freezed == bidder
          ? _value.bidder
          : bidder // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as OrderCurrencyDto?,
      makerExpanded: freezed == makerExpanded
          ? _value.makerExpanded
          : makerExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      openFrom: freezed == openFrom
          ? _value.openFrom
          : openFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      openTo: freezed == openTo
          ? _value.openTo
          : openTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      taker: freezed == taker
          ? _value.taker
          : taker // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderCurrencyDtoCopyWith<$Res>? get currency {
    if (_value.currency == null) {
      return null;
    }

    return $OrderCurrencyDtoCopyWith<$Res>(_value.currency!, (value) {
      return _then(_value.copyWith(currency: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res>? get makerExpanded {
    if (_value.makerExpanded == null) {
      return null;
    }

    return $UserDtoCopyWith<$Res>(_value.makerExpanded!, (value) {
      return _then(_value.copyWith(makerExpanded: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_OrderSimpleDtoCopyWith<$Res>
    implements $OrderSimpleDtoCopyWith<$Res> {
  factory _$$_OrderSimpleDtoCopyWith(
          _$_OrderSimpleDto value, $Res Function(_$_OrderSimpleDto) then) =
      __$$_OrderSimpleDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String contract,
      DateTime createdAt,
      OrderKind kind,
      String maker,
      String network,
      bool open,
      String orderId,
      String price,
      String token,
      String? bidAmount,
      String? bidder,
      OrderCurrencyDto? currency,
      UserDto? makerExpanded,
      DateTime? openFrom,
      DateTime? openTo,
      String? paidAmount,
      String? taker,
      DateTime? updatedAt});

  @override
  $OrderCurrencyDtoCopyWith<$Res>? get currency;
  @override
  $UserDtoCopyWith<$Res>? get makerExpanded;
}

/// @nodoc
class __$$_OrderSimpleDtoCopyWithImpl<$Res>
    extends _$OrderSimpleDtoCopyWithImpl<$Res, _$_OrderSimpleDto>
    implements _$$_OrderSimpleDtoCopyWith<$Res> {
  __$$_OrderSimpleDtoCopyWithImpl(
      _$_OrderSimpleDto _value, $Res Function(_$_OrderSimpleDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contract = null,
    Object? createdAt = null,
    Object? kind = null,
    Object? maker = null,
    Object? network = null,
    Object? open = null,
    Object? orderId = null,
    Object? price = null,
    Object? token = null,
    Object? bidAmount = freezed,
    Object? bidder = freezed,
    Object? currency = freezed,
    Object? makerExpanded = freezed,
    Object? openFrom = freezed,
    Object? openTo = freezed,
    Object? paidAmount = freezed,
    Object? taker = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_OrderSimpleDto(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      contract: null == contract
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as OrderKind,
      maker: null == maker
          ? _value.maker
          : maker // ignore: cast_nullable_to_non_nullable
              as String,
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as bool,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      bidAmount: freezed == bidAmount
          ? _value.bidAmount
          : bidAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      bidder: freezed == bidder
          ? _value.bidder
          : bidder // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as OrderCurrencyDto?,
      makerExpanded: freezed == makerExpanded
          ? _value.makerExpanded
          : makerExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      openFrom: freezed == openFrom
          ? _value.openFrom
          : openFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      openTo: freezed == openTo
          ? _value.openTo
          : openTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      taker: freezed == taker
          ? _value.taker
          : taker // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderSimpleDto implements _OrderSimpleDto {
  const _$_OrderSimpleDto(
      {required this.id,
      required this.contract,
      required this.createdAt,
      required this.kind,
      required this.maker,
      required this.network,
      required this.open,
      required this.orderId,
      required this.price,
      required this.token,
      this.bidAmount,
      this.bidder,
      this.currency,
      this.makerExpanded,
      this.openFrom,
      this.openTo,
      this.paidAmount,
      this.taker,
      this.updatedAt});

  factory _$_OrderSimpleDto.fromJson(Map<String, dynamic> json) =>
      _$$_OrderSimpleDtoFromJson(json);

  @override
  final String id;
  @override
  final String contract;
  @override
  final DateTime createdAt;
  @override
  final OrderKind kind;
  @override
  final String maker;
  @override
  final String network;
  @override
  final bool open;
  @override
  final String orderId;
  @override
  final String price;
  @override
  final String token;
  @override
  final String? bidAmount;
  @override
  final String? bidder;
  @override
  final OrderCurrencyDto? currency;
  @override
  final UserDto? makerExpanded;
  @override
  final DateTime? openFrom;
  @override
  final DateTime? openTo;
  @override
  final String? paidAmount;
  @override
  final String? taker;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'OrderSimpleDto(id: $id, contract: $contract, createdAt: $createdAt, kind: $kind, maker: $maker, network: $network, open: $open, orderId: $orderId, price: $price, token: $token, bidAmount: $bidAmount, bidder: $bidder, currency: $currency, makerExpanded: $makerExpanded, openFrom: $openFrom, openTo: $openTo, paidAmount: $paidAmount, taker: $taker, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderSimpleDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.contract, contract) ||
                other.contract == contract) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.maker, maker) || other.maker == maker) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.open, open) || other.open == open) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.bidAmount, bidAmount) ||
                other.bidAmount == bidAmount) &&
            (identical(other.bidder, bidder) || other.bidder == bidder) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.makerExpanded, makerExpanded) ||
                other.makerExpanded == makerExpanded) &&
            (identical(other.openFrom, openFrom) ||
                other.openFrom == openFrom) &&
            (identical(other.openTo, openTo) || other.openTo == openTo) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.taker, taker) || other.taker == taker) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        contract,
        createdAt,
        kind,
        maker,
        network,
        open,
        orderId,
        price,
        token,
        bidAmount,
        bidder,
        currency,
        makerExpanded,
        openFrom,
        openTo,
        paidAmount,
        taker,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderSimpleDtoCopyWith<_$_OrderSimpleDto> get copyWith =>
      __$$_OrderSimpleDtoCopyWithImpl<_$_OrderSimpleDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderSimpleDtoToJson(
      this,
    );
  }
}

abstract class _OrderSimpleDto implements OrderSimpleDto {
  const factory _OrderSimpleDto(
      {required final String id,
      required final String contract,
      required final DateTime createdAt,
      required final OrderKind kind,
      required final String maker,
      required final String network,
      required final bool open,
      required final String orderId,
      required final String price,
      required final String token,
      final String? bidAmount,
      final String? bidder,
      final OrderCurrencyDto? currency,
      final UserDto? makerExpanded,
      final DateTime? openFrom,
      final DateTime? openTo,
      final String? paidAmount,
      final String? taker,
      final DateTime? updatedAt}) = _$_OrderSimpleDto;

  factory _OrderSimpleDto.fromJson(Map<String, dynamic> json) =
      _$_OrderSimpleDto.fromJson;

  @override
  String get id;
  @override
  String get contract;
  @override
  DateTime get createdAt;
  @override
  OrderKind get kind;
  @override
  String get maker;
  @override
  String get network;
  @override
  bool get open;
  @override
  String get orderId;
  @override
  String get price;
  @override
  String get token;
  @override
  String? get bidAmount;
  @override
  String? get bidder;
  @override
  OrderCurrencyDto? get currency;
  @override
  UserDto? get makerExpanded;
  @override
  DateTime? get openFrom;
  @override
  DateTime? get openTo;
  @override
  String? get paidAmount;
  @override
  String? get taker;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_OrderSimpleDtoCopyWith<_$_OrderSimpleDto> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderCurrencyDto _$OrderCurrencyDtoFromJson(Map<String, dynamic> json) {
  return _OrderCurrencyDto.fromJson(json);
}

/// @nodoc
mixin _$OrderCurrencyDto {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get symbol => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCurrencyDtoCopyWith<OrderCurrencyDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCurrencyDtoCopyWith<$Res> {
  factory $OrderCurrencyDtoCopyWith(
          OrderCurrencyDto value, $Res Function(OrderCurrencyDto) then) =
      _$OrderCurrencyDtoCopyWithImpl<$Res, OrderCurrencyDto>;
  @useResult
  $Res call({String id, String? name, String? symbol});
}

/// @nodoc
class _$OrderCurrencyDtoCopyWithImpl<$Res, $Val extends OrderCurrencyDto>
    implements $OrderCurrencyDtoCopyWith<$Res> {
  _$OrderCurrencyDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? symbol = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrderCurrencyDtoCopyWith<$Res>
    implements $OrderCurrencyDtoCopyWith<$Res> {
  factory _$$_OrderCurrencyDtoCopyWith(
          _$_OrderCurrencyDto value, $Res Function(_$_OrderCurrencyDto) then) =
      __$$_OrderCurrencyDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? name, String? symbol});
}

/// @nodoc
class __$$_OrderCurrencyDtoCopyWithImpl<$Res>
    extends _$OrderCurrencyDtoCopyWithImpl<$Res, _$_OrderCurrencyDto>
    implements _$$_OrderCurrencyDtoCopyWith<$Res> {
  __$$_OrderCurrencyDtoCopyWithImpl(
      _$_OrderCurrencyDto _value, $Res Function(_$_OrderCurrencyDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? symbol = freezed,
  }) {
    return _then(_$_OrderCurrencyDto(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderCurrencyDto implements _OrderCurrencyDto {
  const _$_OrderCurrencyDto({required this.id, this.name, this.symbol});

  factory _$_OrderCurrencyDto.fromJson(Map<String, dynamic> json) =>
      _$$_OrderCurrencyDtoFromJson(json);

  @override
  final String id;
  @override
  final String? name;
  @override
  final String? symbol;

  @override
  String toString() {
    return 'OrderCurrencyDto(id: $id, name: $name, symbol: $symbol)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderCurrencyDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, symbol);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderCurrencyDtoCopyWith<_$_OrderCurrencyDto> get copyWith =>
      __$$_OrderCurrencyDtoCopyWithImpl<_$_OrderCurrencyDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderCurrencyDtoToJson(
      this,
    );
  }
}

abstract class _OrderCurrencyDto implements OrderCurrencyDto {
  const factory _OrderCurrencyDto(
      {required final String id,
      final String? name,
      final String? symbol}) = _$_OrderCurrencyDto;

  factory _OrderCurrencyDto.fromJson(Map<String, dynamic> json) =
      _$_OrderCurrencyDto.fromJson;

  @override
  String get id;
  @override
  String? get name;
  @override
  String? get symbol;
  @override
  @JsonKey(ignore: true)
  _$$_OrderCurrencyDtoCopyWith<_$_OrderCurrencyDto> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenRoyaltyDto _$TokenRoyaltyDtoFromJson(Map<String, dynamic> json) {
  return _TokenRoyaltyDto.fromJson(json);
}

/// @nodoc
mixin _$TokenRoyaltyDto {
  String get account => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenRoyaltyDtoCopyWith<TokenRoyaltyDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenRoyaltyDtoCopyWith<$Res> {
  factory $TokenRoyaltyDtoCopyWith(
          TokenRoyaltyDto value, $Res Function(TokenRoyaltyDto) then) =
      _$TokenRoyaltyDtoCopyWithImpl<$Res, TokenRoyaltyDto>;
  @useResult
  $Res call({String account, String value});
}

/// @nodoc
class _$TokenRoyaltyDtoCopyWithImpl<$Res, $Val extends TokenRoyaltyDto>
    implements $TokenRoyaltyDtoCopyWith<$Res> {
  _$TokenRoyaltyDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TokenRoyaltyDtoCopyWith<$Res>
    implements $TokenRoyaltyDtoCopyWith<$Res> {
  factory _$$_TokenRoyaltyDtoCopyWith(
          _$_TokenRoyaltyDto value, $Res Function(_$_TokenRoyaltyDto) then) =
      __$$_TokenRoyaltyDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String account, String value});
}

/// @nodoc
class __$$_TokenRoyaltyDtoCopyWithImpl<$Res>
    extends _$TokenRoyaltyDtoCopyWithImpl<$Res, _$_TokenRoyaltyDto>
    implements _$$_TokenRoyaltyDtoCopyWith<$Res> {
  __$$_TokenRoyaltyDtoCopyWithImpl(
      _$_TokenRoyaltyDto _value, $Res Function(_$_TokenRoyaltyDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
    Object? value = null,
  }) {
    return _then(_$_TokenRoyaltyDto(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TokenRoyaltyDto implements _TokenRoyaltyDto {
  const _$_TokenRoyaltyDto({required this.account, required this.value});

  factory _$_TokenRoyaltyDto.fromJson(Map<String, dynamic> json) =>
      _$$_TokenRoyaltyDtoFromJson(json);

  @override
  final String account;
  @override
  final String value;

  @override
  String toString() {
    return 'TokenRoyaltyDto(account: $account, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TokenRoyaltyDto &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, account, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TokenRoyaltyDtoCopyWith<_$_TokenRoyaltyDto> get copyWith =>
      __$$_TokenRoyaltyDtoCopyWithImpl<_$_TokenRoyaltyDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokenRoyaltyDtoToJson(
      this,
    );
  }
}

abstract class _TokenRoyaltyDto implements TokenRoyaltyDto {
  const factory _TokenRoyaltyDto(
      {required final String account,
      required final String value}) = _$_TokenRoyaltyDto;

  factory _TokenRoyaltyDto.fromJson(Map<String, dynamic> json) =
      _$_TokenRoyaltyDto.fromJson;

  @override
  String get account;
  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$_TokenRoyaltyDtoCopyWith<_$_TokenRoyaltyDto> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenMetadataDto _$TokenMetadataDtoFromJson(Map<String, dynamic> json) {
  return _TokenMetadataDto.fromJson(json);
}

/// @nodoc
mixin _$TokenMetadataDto {
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get animation_url => throw _privateConstructorUsedError;
  String? get external_url => throw _privateConstructorUsedError;
  List<String?>? get creators => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenMetadataDtoCopyWith<TokenMetadataDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenMetadataDtoCopyWith<$Res> {
  factory $TokenMetadataDtoCopyWith(
          TokenMetadataDto value, $Res Function(TokenMetadataDto) then) =
      _$TokenMetadataDtoCopyWithImpl<$Res, TokenMetadataDto>;
  @useResult
  $Res call(
      {String? name,
      String? description,
      String? image,
      String? animation_url,
      String? external_url,
      List<String?>? creators});
}

/// @nodoc
class _$TokenMetadataDtoCopyWithImpl<$Res, $Val extends TokenMetadataDto>
    implements $TokenMetadataDtoCopyWith<$Res> {
  _$TokenMetadataDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? animation_url = freezed,
    Object? external_url = freezed,
    Object? creators = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      animation_url: freezed == animation_url
          ? _value.animation_url
          : animation_url // ignore: cast_nullable_to_non_nullable
              as String?,
      external_url: freezed == external_url
          ? _value.external_url
          : external_url // ignore: cast_nullable_to_non_nullable
              as String?,
      creators: freezed == creators
          ? _value.creators
          : creators // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TokenMetadataDtoCopyWith<$Res>
    implements $TokenMetadataDtoCopyWith<$Res> {
  factory _$$_TokenMetadataDtoCopyWith(
          _$_TokenMetadataDto value, $Res Function(_$_TokenMetadataDto) then) =
      __$$_TokenMetadataDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? description,
      String? image,
      String? animation_url,
      String? external_url,
      List<String?>? creators});
}

/// @nodoc
class __$$_TokenMetadataDtoCopyWithImpl<$Res>
    extends _$TokenMetadataDtoCopyWithImpl<$Res, _$_TokenMetadataDto>
    implements _$$_TokenMetadataDtoCopyWith<$Res> {
  __$$_TokenMetadataDtoCopyWithImpl(
      _$_TokenMetadataDto _value, $Res Function(_$_TokenMetadataDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? animation_url = freezed,
    Object? external_url = freezed,
    Object? creators = freezed,
  }) {
    return _then(_$_TokenMetadataDto(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      animation_url: freezed == animation_url
          ? _value.animation_url
          : animation_url // ignore: cast_nullable_to_non_nullable
              as String?,
      external_url: freezed == external_url
          ? _value.external_url
          : external_url // ignore: cast_nullable_to_non_nullable
              as String?,
      creators: freezed == creators
          ? _value._creators
          : creators // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TokenMetadataDto implements _TokenMetadataDto {
  const _$_TokenMetadataDto(
      {this.name,
      this.description,
      this.image,
      this.animation_url,
      this.external_url,
      final List<String?>? creators})
      : _creators = creators;

  factory _$_TokenMetadataDto.fromJson(Map<String, dynamic> json) =>
      _$$_TokenMetadataDtoFromJson(json);

  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? image;
  @override
  final String? animation_url;
  @override
  final String? external_url;
  final List<String?>? _creators;
  @override
  List<String?>? get creators {
    final value = _creators;
    if (value == null) return null;
    if (_creators is EqualUnmodifiableListView) return _creators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TokenMetadataDto(name: $name, description: $description, image: $image, animation_url: $animation_url, external_url: $external_url, creators: $creators)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TokenMetadataDto &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.animation_url, animation_url) ||
                other.animation_url == animation_url) &&
            (identical(other.external_url, external_url) ||
                other.external_url == external_url) &&
            const DeepCollectionEquality().equals(other._creators, _creators));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      image,
      animation_url,
      external_url,
      const DeepCollectionEquality().hash(_creators));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TokenMetadataDtoCopyWith<_$_TokenMetadataDto> get copyWith =>
      __$$_TokenMetadataDtoCopyWithImpl<_$_TokenMetadataDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokenMetadataDtoToJson(
      this,
    );
  }
}

abstract class _TokenMetadataDto implements TokenMetadataDto {
  const factory _TokenMetadataDto(
      {final String? name,
      final String? description,
      final String? image,
      final String? animation_url,
      final String? external_url,
      final List<String?>? creators}) = _$_TokenMetadataDto;

  factory _TokenMetadataDto.fromJson(Map<String, dynamic> json) =
      _$_TokenMetadataDto.fromJson;

  @override
  String? get name;
  @override
  String? get description;
  @override
  String? get image;
  @override
  String? get animation_url;
  @override
  String? get external_url;
  @override
  List<String?>? get creators;
  @override
  @JsonKey(ignore: true)
  _$$_TokenMetadataDtoCopyWith<_$_TokenMetadataDto> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenSimpleDto _$TokenSimpleDtoFromJson(Map<String, dynamic> json) {
  return _TokenSimpleDto.fromJson(json);
}

/// @nodoc
mixin _$TokenSimpleDto {
  String get id => throw _privateConstructorUsedError;
  String get network => throw _privateConstructorUsedError;
  String get tokenId => throw _privateConstructorUsedError;
  String? get typename => throw _privateConstructorUsedError;
  String? get contract => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get creator => throw _privateConstructorUsedError;
  UserDto? get creatorExpanded => throw _privateConstructorUsedError;
  double? get enrichCount => throw _privateConstructorUsedError;
  String? get enrichedAt => throw _privateConstructorUsedError;
  String? get founder => throw _privateConstructorUsedError;
  UserDto? get founderExpanded => throw _privateConstructorUsedError;
  TokenMetadataDto? get metadata => throw _privateConstructorUsedError;
  List<UserDto>? get metadataCreatorsExpanded =>
      throw _privateConstructorUsedError;
  String? get order => throw _privateConstructorUsedError;
  List<TokenRoyaltyDto>? get royalties => throw _privateConstructorUsedError;
  String? get royaltyFraction => throw _privateConstructorUsedError;
  String? get royaltyMaker => throw _privateConstructorUsedError;
  String? get uri => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenSimpleDtoCopyWith<TokenSimpleDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenSimpleDtoCopyWith<$Res> {
  factory $TokenSimpleDtoCopyWith(
          TokenSimpleDto value, $Res Function(TokenSimpleDto) then) =
      _$TokenSimpleDtoCopyWithImpl<$Res, TokenSimpleDto>;
  @useResult
  $Res call(
      {String id,
      String network,
      String tokenId,
      String? typename,
      String? contract,
      String? createdAt,
      String? creator,
      UserDto? creatorExpanded,
      double? enrichCount,
      String? enrichedAt,
      String? founder,
      UserDto? founderExpanded,
      TokenMetadataDto? metadata,
      List<UserDto>? metadataCreatorsExpanded,
      String? order,
      List<TokenRoyaltyDto>? royalties,
      String? royaltyFraction,
      String? royaltyMaker,
      String? uri});

  $UserDtoCopyWith<$Res>? get creatorExpanded;
  $UserDtoCopyWith<$Res>? get founderExpanded;
  $TokenMetadataDtoCopyWith<$Res>? get metadata;
}

/// @nodoc
class _$TokenSimpleDtoCopyWithImpl<$Res, $Val extends TokenSimpleDto>
    implements $TokenSimpleDtoCopyWith<$Res> {
  _$TokenSimpleDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? network = null,
    Object? tokenId = null,
    Object? typename = freezed,
    Object? contract = freezed,
    Object? createdAt = freezed,
    Object? creator = freezed,
    Object? creatorExpanded = freezed,
    Object? enrichCount = freezed,
    Object? enrichedAt = freezed,
    Object? founder = freezed,
    Object? founderExpanded = freezed,
    Object? metadata = freezed,
    Object? metadataCreatorsExpanded = freezed,
    Object? order = freezed,
    Object? royalties = freezed,
    Object? royaltyFraction = freezed,
    Object? royaltyMaker = freezed,
    Object? uri = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      tokenId: null == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String,
      typename: freezed == typename
          ? _value.typename
          : typename // ignore: cast_nullable_to_non_nullable
              as String?,
      contract: freezed == contract
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorExpanded: freezed == creatorExpanded
          ? _value.creatorExpanded
          : creatorExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      enrichCount: freezed == enrichCount
          ? _value.enrichCount
          : enrichCount // ignore: cast_nullable_to_non_nullable
              as double?,
      enrichedAt: freezed == enrichedAt
          ? _value.enrichedAt
          : enrichedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      founder: freezed == founder
          ? _value.founder
          : founder // ignore: cast_nullable_to_non_nullable
              as String?,
      founderExpanded: freezed == founderExpanded
          ? _value.founderExpanded
          : founderExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as TokenMetadataDto?,
      metadataCreatorsExpanded: freezed == metadataCreatorsExpanded
          ? _value.metadataCreatorsExpanded
          : metadataCreatorsExpanded // ignore: cast_nullable_to_non_nullable
              as List<UserDto>?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as String?,
      royalties: freezed == royalties
          ? _value.royalties
          : royalties // ignore: cast_nullable_to_non_nullable
              as List<TokenRoyaltyDto>?,
      royaltyFraction: freezed == royaltyFraction
          ? _value.royaltyFraction
          : royaltyFraction // ignore: cast_nullable_to_non_nullable
              as String?,
      royaltyMaker: freezed == royaltyMaker
          ? _value.royaltyMaker
          : royaltyMaker // ignore: cast_nullable_to_non_nullable
              as String?,
      uri: freezed == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res>? get creatorExpanded {
    if (_value.creatorExpanded == null) {
      return null;
    }

    return $UserDtoCopyWith<$Res>(_value.creatorExpanded!, (value) {
      return _then(_value.copyWith(creatorExpanded: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res>? get founderExpanded {
    if (_value.founderExpanded == null) {
      return null;
    }

    return $UserDtoCopyWith<$Res>(_value.founderExpanded!, (value) {
      return _then(_value.copyWith(founderExpanded: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TokenMetadataDtoCopyWith<$Res>? get metadata {
    if (_value.metadata == null) {
      return null;
    }

    return $TokenMetadataDtoCopyWith<$Res>(_value.metadata!, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TokenSimpleDtoCopyWith<$Res>
    implements $TokenSimpleDtoCopyWith<$Res> {
  factory _$$_TokenSimpleDtoCopyWith(
          _$_TokenSimpleDto value, $Res Function(_$_TokenSimpleDto) then) =
      __$$_TokenSimpleDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String network,
      String tokenId,
      String? typename,
      String? contract,
      String? createdAt,
      String? creator,
      UserDto? creatorExpanded,
      double? enrichCount,
      String? enrichedAt,
      String? founder,
      UserDto? founderExpanded,
      TokenMetadataDto? metadata,
      List<UserDto>? metadataCreatorsExpanded,
      String? order,
      List<TokenRoyaltyDto>? royalties,
      String? royaltyFraction,
      String? royaltyMaker,
      String? uri});

  @override
  $UserDtoCopyWith<$Res>? get creatorExpanded;
  @override
  $UserDtoCopyWith<$Res>? get founderExpanded;
  @override
  $TokenMetadataDtoCopyWith<$Res>? get metadata;
}

/// @nodoc
class __$$_TokenSimpleDtoCopyWithImpl<$Res>
    extends _$TokenSimpleDtoCopyWithImpl<$Res, _$_TokenSimpleDto>
    implements _$$_TokenSimpleDtoCopyWith<$Res> {
  __$$_TokenSimpleDtoCopyWithImpl(
      _$_TokenSimpleDto _value, $Res Function(_$_TokenSimpleDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? network = null,
    Object? tokenId = null,
    Object? typename = freezed,
    Object? contract = freezed,
    Object? createdAt = freezed,
    Object? creator = freezed,
    Object? creatorExpanded = freezed,
    Object? enrichCount = freezed,
    Object? enrichedAt = freezed,
    Object? founder = freezed,
    Object? founderExpanded = freezed,
    Object? metadata = freezed,
    Object? metadataCreatorsExpanded = freezed,
    Object? order = freezed,
    Object? royalties = freezed,
    Object? royaltyFraction = freezed,
    Object? royaltyMaker = freezed,
    Object? uri = freezed,
  }) {
    return _then(_$_TokenSimpleDto(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      tokenId: null == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String,
      typename: freezed == typename
          ? _value.typename
          : typename // ignore: cast_nullable_to_non_nullable
              as String?,
      contract: freezed == contract
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorExpanded: freezed == creatorExpanded
          ? _value.creatorExpanded
          : creatorExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      enrichCount: freezed == enrichCount
          ? _value.enrichCount
          : enrichCount // ignore: cast_nullable_to_non_nullable
              as double?,
      enrichedAt: freezed == enrichedAt
          ? _value.enrichedAt
          : enrichedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      founder: freezed == founder
          ? _value.founder
          : founder // ignore: cast_nullable_to_non_nullable
              as String?,
      founderExpanded: freezed == founderExpanded
          ? _value.founderExpanded
          : founderExpanded // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as TokenMetadataDto?,
      metadataCreatorsExpanded: freezed == metadataCreatorsExpanded
          ? _value._metadataCreatorsExpanded
          : metadataCreatorsExpanded // ignore: cast_nullable_to_non_nullable
              as List<UserDto>?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as String?,
      royalties: freezed == royalties
          ? _value._royalties
          : royalties // ignore: cast_nullable_to_non_nullable
              as List<TokenRoyaltyDto>?,
      royaltyFraction: freezed == royaltyFraction
          ? _value.royaltyFraction
          : royaltyFraction // ignore: cast_nullable_to_non_nullable
              as String?,
      royaltyMaker: freezed == royaltyMaker
          ? _value.royaltyMaker
          : royaltyMaker // ignore: cast_nullable_to_non_nullable
              as String?,
      uri: freezed == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TokenSimpleDto implements _TokenSimpleDto {
  const _$_TokenSimpleDto(
      {required this.id,
      required this.network,
      required this.tokenId,
      this.typename,
      this.contract,
      this.createdAt,
      this.creator,
      this.creatorExpanded,
      this.enrichCount,
      this.enrichedAt,
      this.founder,
      this.founderExpanded,
      this.metadata,
      final List<UserDto>? metadataCreatorsExpanded,
      this.order,
      final List<TokenRoyaltyDto>? royalties,
      this.royaltyFraction,
      this.royaltyMaker,
      this.uri})
      : _metadataCreatorsExpanded = metadataCreatorsExpanded,
        _royalties = royalties;

  factory _$_TokenSimpleDto.fromJson(Map<String, dynamic> json) =>
      _$$_TokenSimpleDtoFromJson(json);

  @override
  final String id;
  @override
  final String network;
  @override
  final String tokenId;
  @override
  final String? typename;
  @override
  final String? contract;
  @override
  final String? createdAt;
  @override
  final String? creator;
  @override
  final UserDto? creatorExpanded;
  @override
  final double? enrichCount;
  @override
  final String? enrichedAt;
  @override
  final String? founder;
  @override
  final UserDto? founderExpanded;
  @override
  final TokenMetadataDto? metadata;
  final List<UserDto>? _metadataCreatorsExpanded;
  @override
  List<UserDto>? get metadataCreatorsExpanded {
    final value = _metadataCreatorsExpanded;
    if (value == null) return null;
    if (_metadataCreatorsExpanded is EqualUnmodifiableListView)
      return _metadataCreatorsExpanded;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? order;
  final List<TokenRoyaltyDto>? _royalties;
  @override
  List<TokenRoyaltyDto>? get royalties {
    final value = _royalties;
    if (value == null) return null;
    if (_royalties is EqualUnmodifiableListView) return _royalties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? royaltyFraction;
  @override
  final String? royaltyMaker;
  @override
  final String? uri;

  @override
  String toString() {
    return 'TokenSimpleDto(id: $id, network: $network, tokenId: $tokenId, typename: $typename, contract: $contract, createdAt: $createdAt, creator: $creator, creatorExpanded: $creatorExpanded, enrichCount: $enrichCount, enrichedAt: $enrichedAt, founder: $founder, founderExpanded: $founderExpanded, metadata: $metadata, metadataCreatorsExpanded: $metadataCreatorsExpanded, order: $order, royalties: $royalties, royaltyFraction: $royaltyFraction, royaltyMaker: $royaltyMaker, uri: $uri)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TokenSimpleDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.tokenId, tokenId) || other.tokenId == tokenId) &&
            (identical(other.typename, typename) ||
                other.typename == typename) &&
            (identical(other.contract, contract) ||
                other.contract == contract) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.creatorExpanded, creatorExpanded) ||
                other.creatorExpanded == creatorExpanded) &&
            (identical(other.enrichCount, enrichCount) ||
                other.enrichCount == enrichCount) &&
            (identical(other.enrichedAt, enrichedAt) ||
                other.enrichedAt == enrichedAt) &&
            (identical(other.founder, founder) || other.founder == founder) &&
            (identical(other.founderExpanded, founderExpanded) ||
                other.founderExpanded == founderExpanded) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            const DeepCollectionEquality().equals(
                other._metadataCreatorsExpanded, _metadataCreatorsExpanded) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality()
                .equals(other._royalties, _royalties) &&
            (identical(other.royaltyFraction, royaltyFraction) ||
                other.royaltyFraction == royaltyFraction) &&
            (identical(other.royaltyMaker, royaltyMaker) ||
                other.royaltyMaker == royaltyMaker) &&
            (identical(other.uri, uri) || other.uri == uri));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        network,
        tokenId,
        typename,
        contract,
        createdAt,
        creator,
        creatorExpanded,
        enrichCount,
        enrichedAt,
        founder,
        founderExpanded,
        metadata,
        const DeepCollectionEquality().hash(_metadataCreatorsExpanded),
        order,
        const DeepCollectionEquality().hash(_royalties),
        royaltyFraction,
        royaltyMaker,
        uri
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TokenSimpleDtoCopyWith<_$_TokenSimpleDto> get copyWith =>
      __$$_TokenSimpleDtoCopyWithImpl<_$_TokenSimpleDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokenSimpleDtoToJson(
      this,
    );
  }
}

abstract class _TokenSimpleDto implements TokenSimpleDto {
  const factory _TokenSimpleDto(
      {required final String id,
      required final String network,
      required final String tokenId,
      final String? typename,
      final String? contract,
      final String? createdAt,
      final String? creator,
      final UserDto? creatorExpanded,
      final double? enrichCount,
      final String? enrichedAt,
      final String? founder,
      final UserDto? founderExpanded,
      final TokenMetadataDto? metadata,
      final List<UserDto>? metadataCreatorsExpanded,
      final String? order,
      final List<TokenRoyaltyDto>? royalties,
      final String? royaltyFraction,
      final String? royaltyMaker,
      final String? uri}) = _$_TokenSimpleDto;

  factory _TokenSimpleDto.fromJson(Map<String, dynamic> json) =
      _$_TokenSimpleDto.fromJson;

  @override
  String get id;
  @override
  String get network;
  @override
  String get tokenId;
  @override
  String? get typename;
  @override
  String? get contract;
  @override
  String? get createdAt;
  @override
  String? get creator;
  @override
  UserDto? get creatorExpanded;
  @override
  double? get enrichCount;
  @override
  String? get enrichedAt;
  @override
  String? get founder;
  @override
  UserDto? get founderExpanded;
  @override
  TokenMetadataDto? get metadata;
  @override
  List<UserDto>? get metadataCreatorsExpanded;
  @override
  String? get order;
  @override
  List<TokenRoyaltyDto>? get royalties;
  @override
  String? get royaltyFraction;
  @override
  String? get royaltyMaker;
  @override
  String? get uri;
  @override
  @JsonKey(ignore: true)
  _$$_TokenSimpleDtoCopyWith<_$_TokenSimpleDto> get copyWith =>
      throw _privateConstructorUsedError;
}
