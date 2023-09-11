// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poap_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetPoapViewSupplyInput _$GetPoapViewSupplyInputFromJson(
    Map<String, dynamic> json) {
  return _GetPoapViewSupplyInput.fromJson(json);
}

/// @nodoc
mixin _$GetPoapViewSupplyInput {
  String get network => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  dynamic get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetPoapViewSupplyInputCopyWith<GetPoapViewSupplyInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPoapViewSupplyInputCopyWith<$Res> {
  factory $GetPoapViewSupplyInputCopyWith(GetPoapViewSupplyInput value,
          $Res Function(GetPoapViewSupplyInput) then) =
      _$GetPoapViewSupplyInputCopyWithImpl<$Res, GetPoapViewSupplyInput>;
  @useResult
  $Res call({String network, String address, dynamic name});
}

/// @nodoc
class _$GetPoapViewSupplyInputCopyWithImpl<$Res,
        $Val extends GetPoapViewSupplyInput>
    implements $GetPoapViewSupplyInputCopyWith<$Res> {
  _$GetPoapViewSupplyInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? network = null,
    Object? address = null,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetPoapViewSupplyInputCopyWith<$Res>
    implements $GetPoapViewSupplyInputCopyWith<$Res> {
  factory _$$_GetPoapViewSupplyInputCopyWith(_$_GetPoapViewSupplyInput value,
          $Res Function(_$_GetPoapViewSupplyInput) then) =
      __$$_GetPoapViewSupplyInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String network, String address, dynamic name});
}

/// @nodoc
class __$$_GetPoapViewSupplyInputCopyWithImpl<$Res>
    extends _$GetPoapViewSupplyInputCopyWithImpl<$Res,
        _$_GetPoapViewSupplyInput>
    implements _$$_GetPoapViewSupplyInputCopyWith<$Res> {
  __$$_GetPoapViewSupplyInputCopyWithImpl(_$_GetPoapViewSupplyInput _value,
      $Res Function(_$_GetPoapViewSupplyInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? network = null,
    Object? address = null,
    Object? name = freezed,
  }) {
    return _then(_$_GetPoapViewSupplyInput(
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name ? _value.name! : name,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetPoapViewSupplyInput implements _GetPoapViewSupplyInput {
  _$_GetPoapViewSupplyInput(
      {required this.network, required this.address, this.name = 'supply'});

  factory _$_GetPoapViewSupplyInput.fromJson(Map<String, dynamic> json) =>
      _$$_GetPoapViewSupplyInputFromJson(json);

  @override
  final String network;
  @override
  final String address;
  @override
  @JsonKey()
  final dynamic name;

  @override
  String toString() {
    return 'GetPoapViewSupplyInput(network: $network, address: $address, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetPoapViewSupplyInput &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, network, address, const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetPoapViewSupplyInputCopyWith<_$_GetPoapViewSupplyInput> get copyWith =>
      __$$_GetPoapViewSupplyInputCopyWithImpl<_$_GetPoapViewSupplyInput>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetPoapViewSupplyInputToJson(
      this,
    );
  }
}

abstract class _GetPoapViewSupplyInput implements GetPoapViewSupplyInput {
  factory _GetPoapViewSupplyInput(
      {required final String network,
      required final String address,
      final dynamic name}) = _$_GetPoapViewSupplyInput;

  factory _GetPoapViewSupplyInput.fromJson(Map<String, dynamic> json) =
      _$_GetPoapViewSupplyInput.fromJson;

  @override
  String get network;
  @override
  String get address;
  @override
  dynamic get name;
  @override
  @JsonKey(ignore: true)
  _$$_GetPoapViewSupplyInputCopyWith<_$_GetPoapViewSupplyInput> get copyWith =>
      throw _privateConstructorUsedError;
}

CheckHasClaimedPoapViewInput _$CheckHasClaimedPoapViewInputFromJson(
    Map<String, dynamic> json) {
  return _CheckHasClaimedPoapViewInput.fromJson(json);
}

/// @nodoc
mixin _$CheckHasClaimedPoapViewInput {
  String get network => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  dynamic get name => throw _privateConstructorUsedError;

  /// user wallet address,
  List<List<String>> get args => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckHasClaimedPoapViewInputCopyWith<CheckHasClaimedPoapViewInput>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckHasClaimedPoapViewInputCopyWith<$Res> {
  factory $CheckHasClaimedPoapViewInputCopyWith(
          CheckHasClaimedPoapViewInput value,
          $Res Function(CheckHasClaimedPoapViewInput) then) =
      _$CheckHasClaimedPoapViewInputCopyWithImpl<$Res,
          CheckHasClaimedPoapViewInput>;
  @useResult
  $Res call(
      {String network, String address, dynamic name, List<List<String>> args});
}

/// @nodoc
class _$CheckHasClaimedPoapViewInputCopyWithImpl<$Res,
        $Val extends CheckHasClaimedPoapViewInput>
    implements $CheckHasClaimedPoapViewInputCopyWith<$Res> {
  _$CheckHasClaimedPoapViewInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? network = null,
    Object? address = null,
    Object? name = freezed,
    Object? args = null,
  }) {
    return _then(_value.copyWith(
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as dynamic,
      args: null == args
          ? _value.args
          : args // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CheckHasClaimedPoapViewInputCopyWith<$Res>
    implements $CheckHasClaimedPoapViewInputCopyWith<$Res> {
  factory _$$_CheckHasClaimedPoapViewInputCopyWith(
          _$_CheckHasClaimedPoapViewInput value,
          $Res Function(_$_CheckHasClaimedPoapViewInput) then) =
      __$$_CheckHasClaimedPoapViewInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String network, String address, dynamic name, List<List<String>> args});
}

/// @nodoc
class __$$_CheckHasClaimedPoapViewInputCopyWithImpl<$Res>
    extends _$CheckHasClaimedPoapViewInputCopyWithImpl<$Res,
        _$_CheckHasClaimedPoapViewInput>
    implements _$$_CheckHasClaimedPoapViewInputCopyWith<$Res> {
  __$$_CheckHasClaimedPoapViewInputCopyWithImpl(
      _$_CheckHasClaimedPoapViewInput _value,
      $Res Function(_$_CheckHasClaimedPoapViewInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? network = null,
    Object? address = null,
    Object? name = freezed,
    Object? args = null,
  }) {
    return _then(_$_CheckHasClaimedPoapViewInput(
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name ? _value.name! : name,
      args: null == args
          ? _value._args
          : args // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CheckHasClaimedPoapViewInput implements _CheckHasClaimedPoapViewInput {
  _$_CheckHasClaimedPoapViewInput(
      {required this.network,
      required this.address,
      this.name = 'hasClaimed',
      required final List<List<String>> args})
      : _args = args;

  factory _$_CheckHasClaimedPoapViewInput.fromJson(Map<String, dynamic> json) =>
      _$$_CheckHasClaimedPoapViewInputFromJson(json);

  @override
  final String network;
  @override
  final String address;
  @override
  @JsonKey()
  final dynamic name;

  /// user wallet address,
  final List<List<String>> _args;

  /// user wallet address,
  @override
  List<List<String>> get args {
    if (_args is EqualUnmodifiableListView) return _args;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_args);
  }

  @override
  String toString() {
    return 'CheckHasClaimedPoapViewInput(network: $network, address: $address, name: $name, args: $args)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CheckHasClaimedPoapViewInput &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other._args, _args));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      network,
      address,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(_args));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CheckHasClaimedPoapViewInputCopyWith<_$_CheckHasClaimedPoapViewInput>
      get copyWith => __$$_CheckHasClaimedPoapViewInputCopyWithImpl<
          _$_CheckHasClaimedPoapViewInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CheckHasClaimedPoapViewInputToJson(
      this,
    );
  }
}

abstract class _CheckHasClaimedPoapViewInput
    implements CheckHasClaimedPoapViewInput {
  factory _CheckHasClaimedPoapViewInput(
          {required final String network,
          required final String address,
          final dynamic name,
          required final List<List<String>> args}) =
      _$_CheckHasClaimedPoapViewInput;

  factory _CheckHasClaimedPoapViewInput.fromJson(Map<String, dynamic> json) =
      _$_CheckHasClaimedPoapViewInput.fromJson;

  @override
  String get network;
  @override
  String get address;
  @override
  dynamic get name;
  @override

  /// user wallet address,
  List<List<String>> get args;
  @override
  @JsonKey(ignore: true)
  _$$_CheckHasClaimedPoapViewInputCopyWith<_$_CheckHasClaimedPoapViewInput>
      get copyWith => throw _privateConstructorUsedError;
}

ClaimInput _$ClaimInputFromJson(Map<String, dynamic> json) {
  return _ClaimInput.fromJson(json);
}

/// @nodoc
mixin _$ClaimInput {
  String get network => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  ClaimArgsInput? get input => throw _privateConstructorUsedError;
  String? get to => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClaimInputCopyWith<ClaimInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaimInputCopyWith<$Res> {
  factory $ClaimInputCopyWith(
          ClaimInput value, $Res Function(ClaimInput) then) =
      _$ClaimInputCopyWithImpl<$Res, ClaimInput>;
  @useResult
  $Res call(
      {String network, String address, ClaimArgsInput? input, String? to});

  $ClaimArgsInputCopyWith<$Res>? get input;
}

/// @nodoc
class _$ClaimInputCopyWithImpl<$Res, $Val extends ClaimInput>
    implements $ClaimInputCopyWith<$Res> {
  _$ClaimInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? network = null,
    Object? address = null,
    Object? input = freezed,
    Object? to = freezed,
  }) {
    return _then(_value.copyWith(
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      input: freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as ClaimArgsInput?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClaimArgsInputCopyWith<$Res>? get input {
    if (_value.input == null) {
      return null;
    }

    return $ClaimArgsInputCopyWith<$Res>(_value.input!, (value) {
      return _then(_value.copyWith(input: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ClaimInputCopyWith<$Res>
    implements $ClaimInputCopyWith<$Res> {
  factory _$$_ClaimInputCopyWith(
          _$_ClaimInput value, $Res Function(_$_ClaimInput) then) =
      __$$_ClaimInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String network, String address, ClaimArgsInput? input, String? to});

  @override
  $ClaimArgsInputCopyWith<$Res>? get input;
}

/// @nodoc
class __$$_ClaimInputCopyWithImpl<$Res>
    extends _$ClaimInputCopyWithImpl<$Res, _$_ClaimInput>
    implements _$$_ClaimInputCopyWith<$Res> {
  __$$_ClaimInputCopyWithImpl(
      _$_ClaimInput _value, $Res Function(_$_ClaimInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? network = null,
    Object? address = null,
    Object? input = freezed,
    Object? to = freezed,
  }) {
    return _then(_$_ClaimInput(
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      input: freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as ClaimArgsInput?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class _$_ClaimInput implements _ClaimInput {
  _$_ClaimInput(
      {required this.network, required this.address, this.input, this.to});

  factory _$_ClaimInput.fromJson(Map<String, dynamic> json) =>
      _$$_ClaimInputFromJson(json);

  @override
  final String network;
  @override
  final String address;
  @override
  final ClaimArgsInput? input;
  @override
  final String? to;

  @override
  String toString() {
    return 'ClaimInput(network: $network, address: $address, input: $input, to: $to)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClaimInput &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.input, input) || other.input == input) &&
            (identical(other.to, to) || other.to == to));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, network, address, input, to);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClaimInputCopyWith<_$_ClaimInput> get copyWith =>
      __$$_ClaimInputCopyWithImpl<_$_ClaimInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClaimInputToJson(
      this,
    );
  }
}

abstract class _ClaimInput implements ClaimInput {
  factory _ClaimInput(
      {required final String network,
      required final String address,
      final ClaimArgsInput? input,
      final String? to}) = _$_ClaimInput;

  factory _ClaimInput.fromJson(Map<String, dynamic> json) =
      _$_ClaimInput.fromJson;

  @override
  String get network;
  @override
  String get address;
  @override
  ClaimArgsInput? get input;
  @override
  String? get to;
  @override
  @JsonKey(ignore: true)
  _$$_ClaimInputCopyWith<_$_ClaimInput> get copyWith =>
      throw _privateConstructorUsedError;
}

ClaimArgsInput _$ClaimArgsInputFromJson(Map<String, dynamic> json) {
  return _ClaimArgsInput.fromJson(json);
}

/// @nodoc
mixin _$ClaimArgsInput {
  String? get claimer => throw _privateConstructorUsedError;
  String? get tokenURI => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClaimArgsInputCopyWith<ClaimArgsInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaimArgsInputCopyWith<$Res> {
  factory $ClaimArgsInputCopyWith(
          ClaimArgsInput value, $Res Function(ClaimArgsInput) then) =
      _$ClaimArgsInputCopyWithImpl<$Res, ClaimArgsInput>;
  @useResult
  $Res call({String? claimer, String? tokenURI});
}

/// @nodoc
class _$ClaimArgsInputCopyWithImpl<$Res, $Val extends ClaimArgsInput>
    implements $ClaimArgsInputCopyWith<$Res> {
  _$ClaimArgsInputCopyWithImpl(this._value, this._then);

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
abstract class _$$_ClaimArgsInputCopyWith<$Res>
    implements $ClaimArgsInputCopyWith<$Res> {
  factory _$$_ClaimArgsInputCopyWith(
          _$_ClaimArgsInput value, $Res Function(_$_ClaimArgsInput) then) =
      __$$_ClaimArgsInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? claimer, String? tokenURI});
}

/// @nodoc
class __$$_ClaimArgsInputCopyWithImpl<$Res>
    extends _$ClaimArgsInputCopyWithImpl<$Res, _$_ClaimArgsInput>
    implements _$$_ClaimArgsInputCopyWith<$Res> {
  __$$_ClaimArgsInputCopyWithImpl(
      _$_ClaimArgsInput _value, $Res Function(_$_ClaimArgsInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claimer = freezed,
    Object? tokenURI = freezed,
  }) {
    return _then(_$_ClaimArgsInput(
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
class _$_ClaimArgsInput implements _ClaimArgsInput {
  const _$_ClaimArgsInput({this.claimer, this.tokenURI});

  factory _$_ClaimArgsInput.fromJson(Map<String, dynamic> json) =>
      _$$_ClaimArgsInputFromJson(json);

  @override
  final String? claimer;
  @override
  final String? tokenURI;

  @override
  String toString() {
    return 'ClaimArgsInput(claimer: $claimer, tokenURI: $tokenURI)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClaimArgsInput &&
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
  _$$_ClaimArgsInputCopyWith<_$_ClaimArgsInput> get copyWith =>
      __$$_ClaimArgsInputCopyWithImpl<_$_ClaimArgsInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClaimArgsInputToJson(
      this,
    );
  }
}

abstract class _ClaimArgsInput implements ClaimArgsInput {
  const factory _ClaimArgsInput(
      {final String? claimer, final String? tokenURI}) = _$_ClaimArgsInput;

  factory _ClaimArgsInput.fromJson(Map<String, dynamic> json) =
      _$_ClaimArgsInput.fromJson;

  @override
  String? get claimer;
  @override
  String? get tokenURI;
  @override
  @JsonKey(ignore: true)
  _$$_ClaimArgsInputCopyWith<_$_ClaimArgsInput> get copyWith =>
      throw _privateConstructorUsedError;
}

TransferInput _$TransferInputFromJson(Map<String, dynamic> json) {
  return _TransferInput.fromJson(json);
}

/// @nodoc
mixin _$TransferInput {
  String get network => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  ClaimArgsInput? get input => throw _privateConstructorUsedError;
  String? get to => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferInputCopyWith<TransferInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferInputCopyWith<$Res> {
  factory $TransferInputCopyWith(
          TransferInput value, $Res Function(TransferInput) then) =
      _$TransferInputCopyWithImpl<$Res, TransferInput>;
  @useResult
  $Res call(
      {String network, String address, ClaimArgsInput? input, String? to});

  $ClaimArgsInputCopyWith<$Res>? get input;
}

/// @nodoc
class _$TransferInputCopyWithImpl<$Res, $Val extends TransferInput>
    implements $TransferInputCopyWith<$Res> {
  _$TransferInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? network = null,
    Object? address = null,
    Object? input = freezed,
    Object? to = freezed,
  }) {
    return _then(_value.copyWith(
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      input: freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as ClaimArgsInput?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClaimArgsInputCopyWith<$Res>? get input {
    if (_value.input == null) {
      return null;
    }

    return $ClaimArgsInputCopyWith<$Res>(_value.input!, (value) {
      return _then(_value.copyWith(input: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TransferInputCopyWith<$Res>
    implements $TransferInputCopyWith<$Res> {
  factory _$$_TransferInputCopyWith(
          _$_TransferInput value, $Res Function(_$_TransferInput) then) =
      __$$_TransferInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String network, String address, ClaimArgsInput? input, String? to});

  @override
  $ClaimArgsInputCopyWith<$Res>? get input;
}

/// @nodoc
class __$$_TransferInputCopyWithImpl<$Res>
    extends _$TransferInputCopyWithImpl<$Res, _$_TransferInput>
    implements _$$_TransferInputCopyWith<$Res> {
  __$$_TransferInputCopyWithImpl(
      _$_TransferInput _value, $Res Function(_$_TransferInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? network = null,
    Object? address = null,
    Object? input = freezed,
    Object? to = freezed,
  }) {
    return _then(_$_TransferInput(
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      input: freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as ClaimArgsInput?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class _$_TransferInput implements _TransferInput {
  _$_TransferInput(
      {required this.network, required this.address, this.input, this.to});

  factory _$_TransferInput.fromJson(Map<String, dynamic> json) =>
      _$$_TransferInputFromJson(json);

  @override
  final String network;
  @override
  final String address;
  @override
  final ClaimArgsInput? input;
  @override
  final String? to;

  @override
  String toString() {
    return 'TransferInput(network: $network, address: $address, input: $input, to: $to)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransferInput &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.input, input) || other.input == input) &&
            (identical(other.to, to) || other.to == to));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, network, address, input, to);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransferInputCopyWith<_$_TransferInput> get copyWith =>
      __$$_TransferInputCopyWithImpl<_$_TransferInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransferInputToJson(
      this,
    );
  }
}

abstract class _TransferInput implements TransferInput {
  factory _TransferInput(
      {required final String network,
      required final String address,
      final ClaimArgsInput? input,
      final String? to}) = _$_TransferInput;

  factory _TransferInput.fromJson(Map<String, dynamic> json) =
      _$_TransferInput.fromJson;

  @override
  String get network;
  @override
  String get address;
  @override
  ClaimArgsInput? get input;
  @override
  String? get to;
  @override
  @JsonKey(ignore: true)
  _$$_TransferInputCopyWith<_$_TransferInput> get copyWith =>
      throw _privateConstructorUsedError;
}

TransferArgsInput _$TransferArgsInputFromJson(Map<String, dynamic> json) {
  return _TransferArgsInput.fromJson(json);
}

/// @nodoc
mixin _$TransferArgsInput {
  String? get claimer => throw _privateConstructorUsedError;
  String? get tokenURI => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferArgsInputCopyWith<TransferArgsInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferArgsInputCopyWith<$Res> {
  factory $TransferArgsInputCopyWith(
          TransferArgsInput value, $Res Function(TransferArgsInput) then) =
      _$TransferArgsInputCopyWithImpl<$Res, TransferArgsInput>;
  @useResult
  $Res call({String? claimer, String? tokenURI});
}

/// @nodoc
class _$TransferArgsInputCopyWithImpl<$Res, $Val extends TransferArgsInput>
    implements $TransferArgsInputCopyWith<$Res> {
  _$TransferArgsInputCopyWithImpl(this._value, this._then);

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
abstract class _$$_TransferArgsInputCopyWith<$Res>
    implements $TransferArgsInputCopyWith<$Res> {
  factory _$$_TransferArgsInputCopyWith(_$_TransferArgsInput value,
          $Res Function(_$_TransferArgsInput) then) =
      __$$_TransferArgsInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? claimer, String? tokenURI});
}

/// @nodoc
class __$$_TransferArgsInputCopyWithImpl<$Res>
    extends _$TransferArgsInputCopyWithImpl<$Res, _$_TransferArgsInput>
    implements _$$_TransferArgsInputCopyWith<$Res> {
  __$$_TransferArgsInputCopyWithImpl(
      _$_TransferArgsInput _value, $Res Function(_$_TransferArgsInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claimer = freezed,
    Object? tokenURI = freezed,
  }) {
    return _then(_$_TransferArgsInput(
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
class _$_TransferArgsInput implements _TransferArgsInput {
  const _$_TransferArgsInput({this.claimer, this.tokenURI});

  factory _$_TransferArgsInput.fromJson(Map<String, dynamic> json) =>
      _$$_TransferArgsInputFromJson(json);

  @override
  final String? claimer;
  @override
  final String? tokenURI;

  @override
  String toString() {
    return 'TransferArgsInput(claimer: $claimer, tokenURI: $tokenURI)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransferArgsInput &&
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
  _$$_TransferArgsInputCopyWith<_$_TransferArgsInput> get copyWith =>
      __$$_TransferArgsInputCopyWithImpl<_$_TransferArgsInput>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransferArgsInputToJson(
      this,
    );
  }
}

abstract class _TransferArgsInput implements TransferArgsInput {
  const factory _TransferArgsInput(
      {final String? claimer, final String? tokenURI}) = _$_TransferArgsInput;

  factory _TransferArgsInput.fromJson(Map<String, dynamic> json) =
      _$_TransferArgsInput.fromJson;

  @override
  String? get claimer;
  @override
  String? get tokenURI;
  @override
  @JsonKey(ignore: true)
  _$$_TransferArgsInputCopyWith<_$_TransferArgsInput> get copyWith =>
      throw _privateConstructorUsedError;
}

GetPoapPolicyInput _$GetPoapPolicyInputFromJson(Map<String, dynamic> json) {
  return _GetPoapPolicyInput.fromJson(json);
}

/// @nodoc
mixin _$GetPoapPolicyInput {
  String get network => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get target => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetPoapPolicyInputCopyWith<GetPoapPolicyInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPoapPolicyInputCopyWith<$Res> {
  factory $GetPoapPolicyInputCopyWith(
          GetPoapPolicyInput value, $Res Function(GetPoapPolicyInput) then) =
      _$GetPoapPolicyInputCopyWithImpl<$Res, GetPoapPolicyInput>;
  @useResult
  $Res call(
      {String network,
      String address,
      @JsonKey(includeIfNull: false) String? target});
}

/// @nodoc
class _$GetPoapPolicyInputCopyWithImpl<$Res, $Val extends GetPoapPolicyInput>
    implements $GetPoapPolicyInputCopyWith<$Res> {
  _$GetPoapPolicyInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? network = null,
    Object? address = null,
    Object? target = freezed,
  }) {
    return _then(_value.copyWith(
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      target: freezed == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetPoapPolicyInputCopyWith<$Res>
    implements $GetPoapPolicyInputCopyWith<$Res> {
  factory _$$_GetPoapPolicyInputCopyWith(_$_GetPoapPolicyInput value,
          $Res Function(_$_GetPoapPolicyInput) then) =
      __$$_GetPoapPolicyInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String network,
      String address,
      @JsonKey(includeIfNull: false) String? target});
}

/// @nodoc
class __$$_GetPoapPolicyInputCopyWithImpl<$Res>
    extends _$GetPoapPolicyInputCopyWithImpl<$Res, _$_GetPoapPolicyInput>
    implements _$$_GetPoapPolicyInputCopyWith<$Res> {
  __$$_GetPoapPolicyInputCopyWithImpl(
      _$_GetPoapPolicyInput _value, $Res Function(_$_GetPoapPolicyInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? network = null,
    Object? address = null,
    Object? target = freezed,
  }) {
    return _then(_$_GetPoapPolicyInput(
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      target: freezed == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetPoapPolicyInput implements _GetPoapPolicyInput {
  const _$_GetPoapPolicyInput(
      {required this.network,
      required this.address,
      @JsonKey(includeIfNull: false) this.target});

  factory _$_GetPoapPolicyInput.fromJson(Map<String, dynamic> json) =>
      _$$_GetPoapPolicyInputFromJson(json);

  @override
  final String network;
  @override
  final String address;
  @override
  @JsonKey(includeIfNull: false)
  final String? target;

  @override
  String toString() {
    return 'GetPoapPolicyInput(network: $network, address: $address, target: $target)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetPoapPolicyInput &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.target, target) || other.target == target));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, network, address, target);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetPoapPolicyInputCopyWith<_$_GetPoapPolicyInput> get copyWith =>
      __$$_GetPoapPolicyInputCopyWithImpl<_$_GetPoapPolicyInput>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetPoapPolicyInputToJson(
      this,
    );
  }
}

abstract class _GetPoapPolicyInput implements GetPoapPolicyInput {
  const factory _GetPoapPolicyInput(
          {required final String network,
          required final String address,
          @JsonKey(includeIfNull: false) final String? target}) =
      _$_GetPoapPolicyInput;

  factory _GetPoapPolicyInput.fromJson(Map<String, dynamic> json) =
      _$_GetPoapPolicyInput.fromJson;

  @override
  String get network;
  @override
  String get address;
  @override
  @JsonKey(includeIfNull: false)
  String? get target;
  @override
  @JsonKey(ignore: true)
  _$$_GetPoapPolicyInputCopyWith<_$_GetPoapPolicyInput> get copyWith =>
      throw _privateConstructorUsedError;
}
