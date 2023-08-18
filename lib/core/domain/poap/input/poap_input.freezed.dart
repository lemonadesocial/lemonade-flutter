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
