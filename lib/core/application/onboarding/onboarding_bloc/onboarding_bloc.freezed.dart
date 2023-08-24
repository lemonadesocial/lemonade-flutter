// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OnboardingState {
  OnboardingStatus get status => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  XFile? get profilePhoto => throw _privateConstructorUsedError;
  OnboardingGender? get gender => throw _privateConstructorUsedError;
  String? get aboutDisplayName => throw _privateConstructorUsedError;
  String? get aboutShortBio => throw _privateConstructorUsedError;
  List<dynamic>? get interestList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OnboardingStateCopyWith<OnboardingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingStateCopyWith<$Res> {
  factory $OnboardingStateCopyWith(
          OnboardingState value, $Res Function(OnboardingState) then) =
      _$OnboardingStateCopyWithImpl<$Res, OnboardingState>;
  @useResult
  $Res call(
      {OnboardingStatus status,
      String? username,
      XFile? profilePhoto,
      OnboardingGender? gender,
      String? aboutDisplayName,
      String? aboutShortBio,
      List<dynamic>? interestList});
}

/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res, $Val extends OnboardingState>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? username = freezed,
    Object? profilePhoto = freezed,
    Object? gender = freezed,
    Object? aboutDisplayName = freezed,
    Object? aboutShortBio = freezed,
    Object? interestList = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OnboardingStatus,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePhoto: freezed == profilePhoto
          ? _value.profilePhoto
          : profilePhoto // ignore: cast_nullable_to_non_nullable
              as XFile?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as OnboardingGender?,
      aboutDisplayName: freezed == aboutDisplayName
          ? _value.aboutDisplayName
          : aboutDisplayName // ignore: cast_nullable_to_non_nullable
              as String?,
      aboutShortBio: freezed == aboutShortBio
          ? _value.aboutShortBio
          : aboutShortBio // ignore: cast_nullable_to_non_nullable
              as String?,
      interestList: freezed == interestList
          ? _value.interestList
          : interestList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OnboardingStateCopyWith<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  factory _$$_OnboardingStateCopyWith(
          _$_OnboardingState value, $Res Function(_$_OnboardingState) then) =
      __$$_OnboardingStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {OnboardingStatus status,
      String? username,
      XFile? profilePhoto,
      OnboardingGender? gender,
      String? aboutDisplayName,
      String? aboutShortBio,
      List<dynamic>? interestList});
}

/// @nodoc
class __$$_OnboardingStateCopyWithImpl<$Res>
    extends _$OnboardingStateCopyWithImpl<$Res, _$_OnboardingState>
    implements _$$_OnboardingStateCopyWith<$Res> {
  __$$_OnboardingStateCopyWithImpl(
      _$_OnboardingState _value, $Res Function(_$_OnboardingState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? username = freezed,
    Object? profilePhoto = freezed,
    Object? gender = freezed,
    Object? aboutDisplayName = freezed,
    Object? aboutShortBio = freezed,
    Object? interestList = freezed,
  }) {
    return _then(_$_OnboardingState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OnboardingStatus,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePhoto: freezed == profilePhoto
          ? _value.profilePhoto
          : profilePhoto // ignore: cast_nullable_to_non_nullable
              as XFile?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as OnboardingGender?,
      aboutDisplayName: freezed == aboutDisplayName
          ? _value.aboutDisplayName
          : aboutDisplayName // ignore: cast_nullable_to_non_nullable
              as String?,
      aboutShortBio: freezed == aboutShortBio
          ? _value.aboutShortBio
          : aboutShortBio // ignore: cast_nullable_to_non_nullable
              as String?,
      interestList: freezed == interestList
          ? _value._interestList
          : interestList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc

class _$_OnboardingState implements _OnboardingState {
  const _$_OnboardingState(
      {this.status = OnboardingStatus.initial,
      this.username,
      this.profilePhoto,
      this.gender,
      this.aboutDisplayName,
      this.aboutShortBio,
      final List<dynamic>? interestList})
      : _interestList = interestList;

  @override
  @JsonKey()
  final OnboardingStatus status;
  @override
  final String? username;
  @override
  final XFile? profilePhoto;
  @override
  final OnboardingGender? gender;
  @override
  final String? aboutDisplayName;
  @override
  final String? aboutShortBio;
  final List<dynamic>? _interestList;
  @override
  List<dynamic>? get interestList {
    final value = _interestList;
    if (value == null) return null;
    if (_interestList is EqualUnmodifiableListView) return _interestList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'OnboardingState(status: $status, username: $username, profilePhoto: $profilePhoto, gender: $gender, aboutDisplayName: $aboutDisplayName, aboutShortBio: $aboutShortBio, interestList: $interestList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OnboardingState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.profilePhoto, profilePhoto) ||
                other.profilePhoto == profilePhoto) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.aboutDisplayName, aboutDisplayName) ||
                other.aboutDisplayName == aboutDisplayName) &&
            (identical(other.aboutShortBio, aboutShortBio) ||
                other.aboutShortBio == aboutShortBio) &&
            const DeepCollectionEquality()
                .equals(other._interestList, _interestList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      username,
      profilePhoto,
      gender,
      aboutDisplayName,
      aboutShortBio,
      const DeepCollectionEquality().hash(_interestList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OnboardingStateCopyWith<_$_OnboardingState> get copyWith =>
      __$$_OnboardingStateCopyWithImpl<_$_OnboardingState>(this, _$identity);
}

abstract class _OnboardingState implements OnboardingState {
  const factory _OnboardingState(
      {final OnboardingStatus status,
      final String? username,
      final XFile? profilePhoto,
      final OnboardingGender? gender,
      final String? aboutDisplayName,
      final String? aboutShortBio,
      final List<dynamic>? interestList}) = _$_OnboardingState;

  @override
  OnboardingStatus get status;
  @override
  String? get username;
  @override
  XFile? get profilePhoto;
  @override
  OnboardingGender? get gender;
  @override
  String? get aboutDisplayName;
  @override
  String? get aboutShortBio;
  @override
  List<dynamic>? get interestList;
  @override
  @JsonKey(ignore: true)
  _$$_OnboardingStateCopyWith<_$_OnboardingState> get copyWith =>
      throw _privateConstructorUsedError;
}
