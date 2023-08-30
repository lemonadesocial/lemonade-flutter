// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_inputs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetProfileInput _$$_GetProfileInputFromJson(Map<String, dynamic> json) =>
    _$_GetProfileInput(
      id: json['id'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$$_GetProfileInputToJson(_$_GetProfileInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
    };

_$_UpdateUserProfileInput _$$_UpdateUserProfileInputFromJson(
        Map<String, dynamic> json) =>
    _$_UpdateUserProfileInput(
      username: json['username'] as String,
      uploadPhoto: (json['uploadPhoto'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      gender: $enumDecodeNullable(_$OnboardingGenderEnumMap, json['gender']),
      displayName: json['displayName'] as String?,
      shortBio: json['shortBio'] as String?,
    );

Map<String, dynamic> _$$_UpdateUserProfileInputToJson(
        _$_UpdateUserProfileInput instance) =>
    <String, dynamic>{
      'username': instance.username,
      'uploadPhoto': instance.uploadPhoto,
      'gender': _$OnboardingGenderEnumMap[instance.gender],
      'displayName': instance.displayName,
      'shortBio': instance.shortBio,
    };

const _$OnboardingGenderEnumMap = {
  OnboardingGender.he: 'he',
  OnboardingGender.she: 'she',
  OnboardingGender.they: 'they',
};
