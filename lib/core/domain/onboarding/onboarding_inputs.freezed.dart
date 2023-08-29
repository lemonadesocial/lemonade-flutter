// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_inputs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetProfileInput _$GetProfileInputFromJson(Map<String, dynamic> json) {
  return _GetProfileInput.fromJson(json);
}

/// @nodoc
mixin _$GetProfileInput {
  String? get userId => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetProfileInputCopyWith<GetProfileInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetProfileInputCopyWith<$Res> {
  factory $GetProfileInputCopyWith(
          GetProfileInput value, $Res Function(GetProfileInput) then) =
      _$GetProfileInputCopyWithImpl<$Res, GetProfileInput>;
  @useResult
  $Res call({String? userId, String? username});
}

/// @nodoc
class _$GetProfileInputCopyWithImpl<$Res, $Val extends GetProfileInput>
    implements $GetProfileInputCopyWith<$Res> {
  _$GetProfileInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? username = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetProfileInputCopyWith<$Res>
    implements $GetProfileInputCopyWith<$Res> {
  factory _$$_GetProfileInputCopyWith(
          _$_GetProfileInput value, $Res Function(_$_GetProfileInput) then) =
      __$$_GetProfileInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? userId, String? username});
}

/// @nodoc
class __$$_GetProfileInputCopyWithImpl<$Res>
    extends _$GetProfileInputCopyWithImpl<$Res, _$_GetProfileInput>
    implements _$$_GetProfileInputCopyWith<$Res> {
  __$$_GetProfileInputCopyWithImpl(
      _$_GetProfileInput _value, $Res Function(_$_GetProfileInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? username = freezed,
  }) {
    return _then(_$_GetProfileInput(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetProfileInput implements _GetProfileInput {
  _$_GetProfileInput({this.userId, this.username});

  factory _$_GetProfileInput.fromJson(Map<String, dynamic> json) =>
      _$$_GetProfileInputFromJson(json);

  @override
  final String? userId;
  @override
  final String? username;

  @override
  String toString() {
    return 'GetProfileInput(userId: $userId, username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetProfileInput &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetProfileInputCopyWith<_$_GetProfileInput> get copyWith =>
      __$$_GetProfileInputCopyWithImpl<_$_GetProfileInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetProfileInputToJson(
      this,
    );
  }
}

abstract class _GetProfileInput implements GetProfileInput {
  factory _GetProfileInput({final String? userId, final String? username}) =
      _$_GetProfileInput;

  factory _GetProfileInput.fromJson(Map<String, dynamic> json) =
      _$_GetProfileInput.fromJson;

  @override
  String? get userId;
  @override
  String? get username;
  @override
  @JsonKey(ignore: true)
  _$$_GetProfileInputCopyWith<_$_GetProfileInput> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateUserProfileInput _$UpdateUserProfileInputFromJson(
    Map<String, dynamic> json) {
  return _UpdateUserProfileInput.fromJson(json);
}

/// @nodoc
mixin _$UpdateUserProfileInput {
  String get username => throw _privateConstructorUsedError;
  List<String>? get uploadPhoto => throw _privateConstructorUsedError;
  OnboardingGender? get gender => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get shortBio => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateUserProfileInputCopyWith<UpdateUserProfileInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateUserProfileInputCopyWith<$Res> {
  factory $UpdateUserProfileInputCopyWith(UpdateUserProfileInput value,
          $Res Function(UpdateUserProfileInput) then) =
      _$UpdateUserProfileInputCopyWithImpl<$Res, UpdateUserProfileInput>;
  @useResult
  $Res call(
      {String username,
      List<String>? uploadPhoto,
      OnboardingGender? gender,
      String? displayName,
      String? shortBio});
}

/// @nodoc
class _$UpdateUserProfileInputCopyWithImpl<$Res,
        $Val extends UpdateUserProfileInput>
    implements $UpdateUserProfileInputCopyWith<$Res> {
  _$UpdateUserProfileInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? uploadPhoto = freezed,
    Object? gender = freezed,
    Object? displayName = freezed,
    Object? shortBio = freezed,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      uploadPhoto: freezed == uploadPhoto
          ? _value.uploadPhoto
          : uploadPhoto // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as OnboardingGender?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      shortBio: freezed == shortBio
          ? _value.shortBio
          : shortBio // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UpdateUserProfileInputCopyWith<$Res>
    implements $UpdateUserProfileInputCopyWith<$Res> {
  factory _$$_UpdateUserProfileInputCopyWith(_$_UpdateUserProfileInput value,
          $Res Function(_$_UpdateUserProfileInput) then) =
      __$$_UpdateUserProfileInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username,
      List<String>? uploadPhoto,
      OnboardingGender? gender,
      String? displayName,
      String? shortBio});
}

/// @nodoc
class __$$_UpdateUserProfileInputCopyWithImpl<$Res>
    extends _$UpdateUserProfileInputCopyWithImpl<$Res,
        _$_UpdateUserProfileInput>
    implements _$$_UpdateUserProfileInputCopyWith<$Res> {
  __$$_UpdateUserProfileInputCopyWithImpl(_$_UpdateUserProfileInput _value,
      $Res Function(_$_UpdateUserProfileInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? uploadPhoto = freezed,
    Object? gender = freezed,
    Object? displayName = freezed,
    Object? shortBio = freezed,
  }) {
    return _then(_$_UpdateUserProfileInput(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      uploadPhoto: freezed == uploadPhoto
          ? _value._uploadPhoto
          : uploadPhoto // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as OnboardingGender?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      shortBio: freezed == shortBio
          ? _value.shortBio
          : shortBio // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UpdateUserProfileInput implements _UpdateUserProfileInput {
  _$_UpdateUserProfileInput(
      {required this.username,
      final List<String>? uploadPhoto,
      this.gender,
      this.displayName,
      this.shortBio})
      : _uploadPhoto = uploadPhoto;

  factory _$_UpdateUserProfileInput.fromJson(Map<String, dynamic> json) =>
      _$$_UpdateUserProfileInputFromJson(json);

  @override
  final String username;
  final List<String>? _uploadPhoto;
  @override
  List<String>? get uploadPhoto {
    final value = _uploadPhoto;
    if (value == null) return null;
    if (_uploadPhoto is EqualUnmodifiableListView) return _uploadPhoto;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final OnboardingGender? gender;
  @override
  final String? displayName;
  @override
  final String? shortBio;

  @override
  String toString() {
    return 'UpdateUserProfileInput(username: $username, uploadPhoto: $uploadPhoto, gender: $gender, displayName: $displayName, shortBio: $shortBio)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateUserProfileInput &&
            (identical(other.username, username) ||
                other.username == username) &&
            const DeepCollectionEquality()
                .equals(other._uploadPhoto, _uploadPhoto) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.shortBio, shortBio) ||
                other.shortBio == shortBio));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      username,
      const DeepCollectionEquality().hash(_uploadPhoto),
      gender,
      displayName,
      shortBio);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateUserProfileInputCopyWith<_$_UpdateUserProfileInput> get copyWith =>
      __$$_UpdateUserProfileInputCopyWithImpl<_$_UpdateUserProfileInput>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UpdateUserProfileInputToJson(
      this,
    );
  }
}

abstract class _UpdateUserProfileInput implements UpdateUserProfileInput {
  factory _UpdateUserProfileInput(
      {required final String username,
      final List<String>? uploadPhoto,
      final OnboardingGender? gender,
      final String? displayName,
      final String? shortBio}) = _$_UpdateUserProfileInput;

  factory _UpdateUserProfileInput.fromJson(Map<String, dynamic> json) =
      _$_UpdateUserProfileInput.fromJson;

  @override
  String get username;
  @override
  List<String>? get uploadPhoto;
  @override
  OnboardingGender? get gender;
  @override
  String? get displayName;
  @override
  String? get shortBio;
  @override
  @JsonKey(ignore: true)
  _$$_UpdateUserProfileInputCopyWith<_$_UpdateUserProfileInput> get copyWith =>
      throw _privateConstructorUsedError;
}
