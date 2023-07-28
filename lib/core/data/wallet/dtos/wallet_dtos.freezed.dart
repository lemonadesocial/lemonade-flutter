// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserWalletRequestDto _$UserWalletRequestDtoFromJson(Map<String, dynamic> json) {
  return _UserWalletRequestDto.fromJson(json);
}

/// @nodoc
mixin _$UserWalletRequestDto {
  String get message => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserWalletRequestDtoCopyWith<UserWalletRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserWalletRequestDtoCopyWith<$Res> {
  factory $UserWalletRequestDtoCopyWith(UserWalletRequestDto value,
          $Res Function(UserWalletRequestDto) then) =
      _$UserWalletRequestDtoCopyWithImpl<$Res, UserWalletRequestDto>;
  @useResult
  $Res call({String message, String token});
}

/// @nodoc
class _$UserWalletRequestDtoCopyWithImpl<$Res,
        $Val extends UserWalletRequestDto>
    implements $UserWalletRequestDtoCopyWith<$Res> {
  _$UserWalletRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserWalletRequestDtoCopyWith<$Res>
    implements $UserWalletRequestDtoCopyWith<$Res> {
  factory _$$_UserWalletRequestDtoCopyWith(_$_UserWalletRequestDto value,
          $Res Function(_$_UserWalletRequestDto) then) =
      __$$_UserWalletRequestDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String token});
}

/// @nodoc
class __$$_UserWalletRequestDtoCopyWithImpl<$Res>
    extends _$UserWalletRequestDtoCopyWithImpl<$Res, _$_UserWalletRequestDto>
    implements _$$_UserWalletRequestDtoCopyWith<$Res> {
  __$$_UserWalletRequestDtoCopyWithImpl(_$_UserWalletRequestDto _value,
      $Res Function(_$_UserWalletRequestDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? token = null,
  }) {
    return _then(_$_UserWalletRequestDto(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserWalletRequestDto implements _UserWalletRequestDto {
  const _$_UserWalletRequestDto({required this.message, required this.token});

  factory _$_UserWalletRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_UserWalletRequestDtoFromJson(json);

  @override
  final String message;
  @override
  final String token;

  @override
  String toString() {
    return 'UserWalletRequestDto(message: $message, token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserWalletRequestDto &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserWalletRequestDtoCopyWith<_$_UserWalletRequestDto> get copyWith =>
      __$$_UserWalletRequestDtoCopyWithImpl<_$_UserWalletRequestDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserWalletRequestDtoToJson(
      this,
    );
  }
}

abstract class _UserWalletRequestDto implements UserWalletRequestDto {
  const factory _UserWalletRequestDto(
      {required final String message,
      required final String token}) = _$_UserWalletRequestDto;

  factory _UserWalletRequestDto.fromJson(Map<String, dynamic> json) =
      _$_UserWalletRequestDto.fromJson;

  @override
  String get message;
  @override
  String get token;
  @override
  @JsonKey(ignore: true)
  _$$_UserWalletRequestDtoCopyWith<_$_UserWalletRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}
