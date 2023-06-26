// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserDto _$UserDtoFromJson(Map<String, dynamic> json) {
  return _UserDto.fromJson(json);
}

/// @nodoc
mixin _$UserDto {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', includeIfNull: false)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name', includeIfNull: false)
  String? get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name', includeIfNull: false)
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name', includeIfNull: false)
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_avatar', includeIfNull: false)
  String? get imageAvatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_photos_expanded', includeIfNull: false)
  List<DbFileDto>? get newPhotosExpanded => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_of_birth', includeIfNull: false)
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_verified', includeIfNull: false)
  bool? get phoneVerified => throw _privateConstructorUsedError;
  @JsonKey(name: 'google_user_info', includeIfNull: false)
  GoogleUserInfoDto? get googleUserInfo => throw _privateConstructorUsedError;
  @JsonKey(name: 'discord_user_info', includeIfNull: false)
  DiscordUserInfoDto? get discordUserInfo => throw _privateConstructorUsedError;
  @JsonKey(name: 'shopify_user_info', includeIfNull: false)
  ShopifyUserInfoDto? get shopifyUserInfo => throw _privateConstructorUsedError;
  @JsonKey(name: 'twitch_user_info', includeIfNull: false)
  TwitchUserInfoDto? get twitchUserInfo => throw _privateConstructorUsedError;
  @JsonKey(name: 'zoom_user_info', includeIfNull: false)
  ZoomUserInfoDto? get zoomUserInfo => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool? get active => throw _privateConstructorUsedError;
  String? get cover => throw _privateConstructorUsedError;
  UserType? get type => throw _privateConstructorUsedError;
  String? get industry => throw _privateConstructorUsedError;
  List<AddressDto>? get addresses => throw _privateConstructorUsedError;
  int? get hosted => throw _privateConstructorUsedError;
  int? get attended => throw _privateConstructorUsedError;
  int? get friends => throw _privateConstructorUsedError;
  int? get following => throw _privateConstructorUsedError;
  int? get followers => throw _privateConstructorUsedError;
  Currency? get currency => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDtoCopyWith<UserDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDtoCopyWith<$Res> {
  factory $UserDtoCopyWith(UserDto value, $Res Function(UserDto) then) =
      _$UserDtoCopyWithImpl<$Res, UserDto>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id')
          String? id,
      @JsonKey(name: 'created_at', includeIfNull: false)
          DateTime? createdAt,
      @JsonKey(name: 'display_name', includeIfNull: false)
          String? displayName,
      @JsonKey(name: 'first_name', includeIfNull: false)
          String? firstName,
      @JsonKey(name: 'last_name', includeIfNull: false)
          String? lastName,
      @JsonKey(name: 'image_avatar', includeIfNull: false)
          String? imageAvatar,
      @JsonKey(name: 'new_photos_expanded', includeIfNull: false)
          List<DbFileDto>? newPhotosExpanded,
      @JsonKey(name: 'date_of_birth', includeIfNull: false)
          DateTime? dateOfBirth,
      @JsonKey(name: 'phone_verified', includeIfNull: false)
          bool? phoneVerified,
      @JsonKey(name: 'google_user_info', includeIfNull: false)
          GoogleUserInfoDto? googleUserInfo,
      @JsonKey(name: 'discord_user_info', includeIfNull: false)
          DiscordUserInfoDto? discordUserInfo,
      @JsonKey(name: 'shopify_user_info', includeIfNull: false)
          ShopifyUserInfoDto? shopifyUserInfo,
      @JsonKey(name: 'twitch_user_info', includeIfNull: false)
          TwitchUserInfoDto? twitchUserInfo,
      @JsonKey(name: 'zoom_user_info', includeIfNull: false)
          ZoomUserInfoDto? zoomUserInfo,
      String? name,
      String? username,
      String? phone,
      String? email,
      String? description,
      bool? active,
      String? cover,
      UserType? type,
      String? industry,
      List<AddressDto>? addresses,
      int? hosted,
      int? attended,
      int? friends,
      int? following,
      int? followers,
      Currency? currency});

  $GoogleUserInfoDtoCopyWith<$Res>? get googleUserInfo;
  $DiscordUserInfoDtoCopyWith<$Res>? get discordUserInfo;
  $ShopifyUserInfoDtoCopyWith<$Res>? get shopifyUserInfo;
  $TwitchUserInfoDtoCopyWith<$Res>? get twitchUserInfo;
  $ZoomUserInfoDtoCopyWith<$Res>? get zoomUserInfo;
}

/// @nodoc
class _$UserDtoCopyWithImpl<$Res, $Val extends UserDto>
    implements $UserDtoCopyWith<$Res> {
  _$UserDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? displayName = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? imageAvatar = freezed,
    Object? newPhotosExpanded = freezed,
    Object? dateOfBirth = freezed,
    Object? phoneVerified = freezed,
    Object? googleUserInfo = freezed,
    Object? discordUserInfo = freezed,
    Object? shopifyUserInfo = freezed,
    Object? twitchUserInfo = freezed,
    Object? zoomUserInfo = freezed,
    Object? name = freezed,
    Object? username = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? description = freezed,
    Object? active = freezed,
    Object? cover = freezed,
    Object? type = freezed,
    Object? industry = freezed,
    Object? addresses = freezed,
    Object? hosted = freezed,
    Object? attended = freezed,
    Object? friends = freezed,
    Object? following = freezed,
    Object? followers = freezed,
    Object? currency = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageAvatar: freezed == imageAvatar
          ? _value.imageAvatar
          : imageAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      newPhotosExpanded: freezed == newPhotosExpanded
          ? _value.newPhotosExpanded
          : newPhotosExpanded // ignore: cast_nullable_to_non_nullable
              as List<DbFileDto>?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      phoneVerified: freezed == phoneVerified
          ? _value.phoneVerified
          : phoneVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      googleUserInfo: freezed == googleUserInfo
          ? _value.googleUserInfo
          : googleUserInfo // ignore: cast_nullable_to_non_nullable
              as GoogleUserInfoDto?,
      discordUserInfo: freezed == discordUserInfo
          ? _value.discordUserInfo
          : discordUserInfo // ignore: cast_nullable_to_non_nullable
              as DiscordUserInfoDto?,
      shopifyUserInfo: freezed == shopifyUserInfo
          ? _value.shopifyUserInfo
          : shopifyUserInfo // ignore: cast_nullable_to_non_nullable
              as ShopifyUserInfoDto?,
      twitchUserInfo: freezed == twitchUserInfo
          ? _value.twitchUserInfo
          : twitchUserInfo // ignore: cast_nullable_to_non_nullable
              as TwitchUserInfoDto?,
      zoomUserInfo: freezed == zoomUserInfo
          ? _value.zoomUserInfo
          : zoomUserInfo // ignore: cast_nullable_to_non_nullable
              as ZoomUserInfoDto?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType?,
      industry: freezed == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String?,
      addresses: freezed == addresses
          ? _value.addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<AddressDto>?,
      hosted: freezed == hosted
          ? _value.hosted
          : hosted // ignore: cast_nullable_to_non_nullable
              as int?,
      attended: freezed == attended
          ? _value.attended
          : attended // ignore: cast_nullable_to_non_nullable
              as int?,
      friends: freezed == friends
          ? _value.friends
          : friends // ignore: cast_nullable_to_non_nullable
              as int?,
      following: freezed == following
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as int?,
      followers: freezed == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as int?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GoogleUserInfoDtoCopyWith<$Res>? get googleUserInfo {
    if (_value.googleUserInfo == null) {
      return null;
    }

    return $GoogleUserInfoDtoCopyWith<$Res>(_value.googleUserInfo!, (value) {
      return _then(_value.copyWith(googleUserInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DiscordUserInfoDtoCopyWith<$Res>? get discordUserInfo {
    if (_value.discordUserInfo == null) {
      return null;
    }

    return $DiscordUserInfoDtoCopyWith<$Res>(_value.discordUserInfo!, (value) {
      return _then(_value.copyWith(discordUserInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ShopifyUserInfoDtoCopyWith<$Res>? get shopifyUserInfo {
    if (_value.shopifyUserInfo == null) {
      return null;
    }

    return $ShopifyUserInfoDtoCopyWith<$Res>(_value.shopifyUserInfo!, (value) {
      return _then(_value.copyWith(shopifyUserInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TwitchUserInfoDtoCopyWith<$Res>? get twitchUserInfo {
    if (_value.twitchUserInfo == null) {
      return null;
    }

    return $TwitchUserInfoDtoCopyWith<$Res>(_value.twitchUserInfo!, (value) {
      return _then(_value.copyWith(twitchUserInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ZoomUserInfoDtoCopyWith<$Res>? get zoomUserInfo {
    if (_value.zoomUserInfo == null) {
      return null;
    }

    return $ZoomUserInfoDtoCopyWith<$Res>(_value.zoomUserInfo!, (value) {
      return _then(_value.copyWith(zoomUserInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserDtoCopyWith<$Res> implements $UserDtoCopyWith<$Res> {
  factory _$$_UserDtoCopyWith(
          _$_UserDto value, $Res Function(_$_UserDto) then) =
      __$$_UserDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id')
          String? id,
      @JsonKey(name: 'created_at', includeIfNull: false)
          DateTime? createdAt,
      @JsonKey(name: 'display_name', includeIfNull: false)
          String? displayName,
      @JsonKey(name: 'first_name', includeIfNull: false)
          String? firstName,
      @JsonKey(name: 'last_name', includeIfNull: false)
          String? lastName,
      @JsonKey(name: 'image_avatar', includeIfNull: false)
          String? imageAvatar,
      @JsonKey(name: 'new_photos_expanded', includeIfNull: false)
          List<DbFileDto>? newPhotosExpanded,
      @JsonKey(name: 'date_of_birth', includeIfNull: false)
          DateTime? dateOfBirth,
      @JsonKey(name: 'phone_verified', includeIfNull: false)
          bool? phoneVerified,
      @JsonKey(name: 'google_user_info', includeIfNull: false)
          GoogleUserInfoDto? googleUserInfo,
      @JsonKey(name: 'discord_user_info', includeIfNull: false)
          DiscordUserInfoDto? discordUserInfo,
      @JsonKey(name: 'shopify_user_info', includeIfNull: false)
          ShopifyUserInfoDto? shopifyUserInfo,
      @JsonKey(name: 'twitch_user_info', includeIfNull: false)
          TwitchUserInfoDto? twitchUserInfo,
      @JsonKey(name: 'zoom_user_info', includeIfNull: false)
          ZoomUserInfoDto? zoomUserInfo,
      String? name,
      String? username,
      String? phone,
      String? email,
      String? description,
      bool? active,
      String? cover,
      UserType? type,
      String? industry,
      List<AddressDto>? addresses,
      int? hosted,
      int? attended,
      int? friends,
      int? following,
      int? followers,
      Currency? currency});

  @override
  $GoogleUserInfoDtoCopyWith<$Res>? get googleUserInfo;
  @override
  $DiscordUserInfoDtoCopyWith<$Res>? get discordUserInfo;
  @override
  $ShopifyUserInfoDtoCopyWith<$Res>? get shopifyUserInfo;
  @override
  $TwitchUserInfoDtoCopyWith<$Res>? get twitchUserInfo;
  @override
  $ZoomUserInfoDtoCopyWith<$Res>? get zoomUserInfo;
}

/// @nodoc
class __$$_UserDtoCopyWithImpl<$Res>
    extends _$UserDtoCopyWithImpl<$Res, _$_UserDto>
    implements _$$_UserDtoCopyWith<$Res> {
  __$$_UserDtoCopyWithImpl(_$_UserDto _value, $Res Function(_$_UserDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? displayName = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? imageAvatar = freezed,
    Object? newPhotosExpanded = freezed,
    Object? dateOfBirth = freezed,
    Object? phoneVerified = freezed,
    Object? googleUserInfo = freezed,
    Object? discordUserInfo = freezed,
    Object? shopifyUserInfo = freezed,
    Object? twitchUserInfo = freezed,
    Object? zoomUserInfo = freezed,
    Object? name = freezed,
    Object? username = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? description = freezed,
    Object? active = freezed,
    Object? cover = freezed,
    Object? type = freezed,
    Object? industry = freezed,
    Object? addresses = freezed,
    Object? hosted = freezed,
    Object? attended = freezed,
    Object? friends = freezed,
    Object? following = freezed,
    Object? followers = freezed,
    Object? currency = freezed,
  }) {
    return _then(_$_UserDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageAvatar: freezed == imageAvatar
          ? _value.imageAvatar
          : imageAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      newPhotosExpanded: freezed == newPhotosExpanded
          ? _value._newPhotosExpanded
          : newPhotosExpanded // ignore: cast_nullable_to_non_nullable
              as List<DbFileDto>?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      phoneVerified: freezed == phoneVerified
          ? _value.phoneVerified
          : phoneVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      googleUserInfo: freezed == googleUserInfo
          ? _value.googleUserInfo
          : googleUserInfo // ignore: cast_nullable_to_non_nullable
              as GoogleUserInfoDto?,
      discordUserInfo: freezed == discordUserInfo
          ? _value.discordUserInfo
          : discordUserInfo // ignore: cast_nullable_to_non_nullable
              as DiscordUserInfoDto?,
      shopifyUserInfo: freezed == shopifyUserInfo
          ? _value.shopifyUserInfo
          : shopifyUserInfo // ignore: cast_nullable_to_non_nullable
              as ShopifyUserInfoDto?,
      twitchUserInfo: freezed == twitchUserInfo
          ? _value.twitchUserInfo
          : twitchUserInfo // ignore: cast_nullable_to_non_nullable
              as TwitchUserInfoDto?,
      zoomUserInfo: freezed == zoomUserInfo
          ? _value.zoomUserInfo
          : zoomUserInfo // ignore: cast_nullable_to_non_nullable
              as ZoomUserInfoDto?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType?,
      industry: freezed == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String?,
      addresses: freezed == addresses
          ? _value._addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<AddressDto>?,
      hosted: freezed == hosted
          ? _value.hosted
          : hosted // ignore: cast_nullable_to_non_nullable
              as int?,
      attended: freezed == attended
          ? _value.attended
          : attended // ignore: cast_nullable_to_non_nullable
              as int?,
      friends: freezed == friends
          ? _value.friends
          : friends // ignore: cast_nullable_to_non_nullable
              as int?,
      following: freezed == following
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as int?,
      followers: freezed == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as int?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserDto implements _UserDto {
  const _$_UserDto(
      {@JsonKey(name: '_id')
          this.id,
      @JsonKey(name: 'created_at', includeIfNull: false)
          this.createdAt,
      @JsonKey(name: 'display_name', includeIfNull: false)
          this.displayName,
      @JsonKey(name: 'first_name', includeIfNull: false)
          this.firstName,
      @JsonKey(name: 'last_name', includeIfNull: false)
          this.lastName,
      @JsonKey(name: 'image_avatar', includeIfNull: false)
          this.imageAvatar,
      @JsonKey(name: 'new_photos_expanded', includeIfNull: false)
          final List<DbFileDto>? newPhotosExpanded,
      @JsonKey(name: 'date_of_birth', includeIfNull: false)
          this.dateOfBirth,
      @JsonKey(name: 'phone_verified', includeIfNull: false)
          this.phoneVerified,
      @JsonKey(name: 'google_user_info', includeIfNull: false)
          this.googleUserInfo,
      @JsonKey(name: 'discord_user_info', includeIfNull: false)
          this.discordUserInfo,
      @JsonKey(name: 'shopify_user_info', includeIfNull: false)
          this.shopifyUserInfo,
      @JsonKey(name: 'twitch_user_info', includeIfNull: false)
          this.twitchUserInfo,
      @JsonKey(name: 'zoom_user_info', includeIfNull: false)
          this.zoomUserInfo,
      this.name,
      this.username,
      this.phone,
      this.email,
      this.description,
      this.active,
      this.cover,
      this.type,
      this.industry,
      final List<AddressDto>? addresses,
      this.hosted,
      this.attended,
      this.friends,
      this.following,
      this.followers,
      this.currency})
      : _newPhotosExpanded = newPhotosExpanded,
        _addresses = addresses;

  factory _$_UserDto.fromJson(Map<String, dynamic> json) =>
      _$$_UserDtoFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'display_name', includeIfNull: false)
  final String? displayName;
  @override
  @JsonKey(name: 'first_name', includeIfNull: false)
  final String? firstName;
  @override
  @JsonKey(name: 'last_name', includeIfNull: false)
  final String? lastName;
  @override
  @JsonKey(name: 'image_avatar', includeIfNull: false)
  final String? imageAvatar;
  final List<DbFileDto>? _newPhotosExpanded;
  @override
  @JsonKey(name: 'new_photos_expanded', includeIfNull: false)
  List<DbFileDto>? get newPhotosExpanded {
    final value = _newPhotosExpanded;
    if (value == null) return null;
    if (_newPhotosExpanded is EqualUnmodifiableListView)
      return _newPhotosExpanded;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'date_of_birth', includeIfNull: false)
  final DateTime? dateOfBirth;
  @override
  @JsonKey(name: 'phone_verified', includeIfNull: false)
  final bool? phoneVerified;
  @override
  @JsonKey(name: 'google_user_info', includeIfNull: false)
  final GoogleUserInfoDto? googleUserInfo;
  @override
  @JsonKey(name: 'discord_user_info', includeIfNull: false)
  final DiscordUserInfoDto? discordUserInfo;
  @override
  @JsonKey(name: 'shopify_user_info', includeIfNull: false)
  final ShopifyUserInfoDto? shopifyUserInfo;
  @override
  @JsonKey(name: 'twitch_user_info', includeIfNull: false)
  final TwitchUserInfoDto? twitchUserInfo;
  @override
  @JsonKey(name: 'zoom_user_info', includeIfNull: false)
  final ZoomUserInfoDto? zoomUserInfo;
  @override
  final String? name;
  @override
  final String? username;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? description;
  @override
  final bool? active;
  @override
  final String? cover;
  @override
  final UserType? type;
  @override
  final String? industry;
  final List<AddressDto>? _addresses;
  @override
  List<AddressDto>? get addresses {
    final value = _addresses;
    if (value == null) return null;
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? hosted;
  @override
  final int? attended;
  @override
  final int? friends;
  @override
  final int? following;
  @override
  final int? followers;
  @override
  final Currency? currency;

  @override
  String toString() {
    return 'UserDto(id: $id, createdAt: $createdAt, displayName: $displayName, firstName: $firstName, lastName: $lastName, imageAvatar: $imageAvatar, newPhotosExpanded: $newPhotosExpanded, dateOfBirth: $dateOfBirth, phoneVerified: $phoneVerified, googleUserInfo: $googleUserInfo, discordUserInfo: $discordUserInfo, shopifyUserInfo: $shopifyUserInfo, twitchUserInfo: $twitchUserInfo, zoomUserInfo: $zoomUserInfo, name: $name, username: $username, phone: $phone, email: $email, description: $description, active: $active, cover: $cover, type: $type, industry: $industry, addresses: $addresses, hosted: $hosted, attended: $attended, friends: $friends, following: $following, followers: $followers, currency: $currency)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.imageAvatar, imageAvatar) ||
                other.imageAvatar == imageAvatar) &&
            const DeepCollectionEquality()
                .equals(other._newPhotosExpanded, _newPhotosExpanded) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.phoneVerified, phoneVerified) ||
                other.phoneVerified == phoneVerified) &&
            (identical(other.googleUserInfo, googleUserInfo) ||
                other.googleUserInfo == googleUserInfo) &&
            (identical(other.discordUserInfo, discordUserInfo) ||
                other.discordUserInfo == discordUserInfo) &&
            (identical(other.shopifyUserInfo, shopifyUserInfo) ||
                other.shopifyUserInfo == shopifyUserInfo) &&
            (identical(other.twitchUserInfo, twitchUserInfo) ||
                other.twitchUserInfo == twitchUserInfo) &&
            (identical(other.zoomUserInfo, zoomUserInfo) ||
                other.zoomUserInfo == zoomUserInfo) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.industry, industry) ||
                other.industry == industry) &&
            const DeepCollectionEquality()
                .equals(other._addresses, _addresses) &&
            (identical(other.hosted, hosted) || other.hosted == hosted) &&
            (identical(other.attended, attended) ||
                other.attended == attended) &&
            (identical(other.friends, friends) || other.friends == friends) &&
            (identical(other.following, following) ||
                other.following == following) &&
            (identical(other.followers, followers) ||
                other.followers == followers) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        createdAt,
        displayName,
        firstName,
        lastName,
        imageAvatar,
        const DeepCollectionEquality().hash(_newPhotosExpanded),
        dateOfBirth,
        phoneVerified,
        googleUserInfo,
        discordUserInfo,
        shopifyUserInfo,
        twitchUserInfo,
        zoomUserInfo,
        name,
        username,
        phone,
        email,
        description,
        active,
        cover,
        type,
        industry,
        const DeepCollectionEquality().hash(_addresses),
        hosted,
        attended,
        friends,
        following,
        followers,
        currency
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserDtoCopyWith<_$_UserDto> get copyWith =>
      __$$_UserDtoCopyWithImpl<_$_UserDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserDtoToJson(
      this,
    );
  }
}

abstract class _UserDto implements UserDto {
  const factory _UserDto(
      {@JsonKey(name: '_id')
          final String? id,
      @JsonKey(name: 'created_at', includeIfNull: false)
          final DateTime? createdAt,
      @JsonKey(name: 'display_name', includeIfNull: false)
          final String? displayName,
      @JsonKey(name: 'first_name', includeIfNull: false)
          final String? firstName,
      @JsonKey(name: 'last_name', includeIfNull: false)
          final String? lastName,
      @JsonKey(name: 'image_avatar', includeIfNull: false)
          final String? imageAvatar,
      @JsonKey(name: 'new_photos_expanded', includeIfNull: false)
          final List<DbFileDto>? newPhotosExpanded,
      @JsonKey(name: 'date_of_birth', includeIfNull: false)
          final DateTime? dateOfBirth,
      @JsonKey(name: 'phone_verified', includeIfNull: false)
          final bool? phoneVerified,
      @JsonKey(name: 'google_user_info', includeIfNull: false)
          final GoogleUserInfoDto? googleUserInfo,
      @JsonKey(name: 'discord_user_info', includeIfNull: false)
          final DiscordUserInfoDto? discordUserInfo,
      @JsonKey(name: 'shopify_user_info', includeIfNull: false)
          final ShopifyUserInfoDto? shopifyUserInfo,
      @JsonKey(name: 'twitch_user_info', includeIfNull: false)
          final TwitchUserInfoDto? twitchUserInfo,
      @JsonKey(name: 'zoom_user_info', includeIfNull: false)
          final ZoomUserInfoDto? zoomUserInfo,
      final String? name,
      final String? username,
      final String? phone,
      final String? email,
      final String? description,
      final bool? active,
      final String? cover,
      final UserType? type,
      final String? industry,
      final List<AddressDto>? addresses,
      final int? hosted,
      final int? attended,
      final int? friends,
      final int? following,
      final int? followers,
      final Currency? currency}) = _$_UserDto;

  factory _UserDto.fromJson(Map<String, dynamic> json) = _$_UserDto.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'created_at', includeIfNull: false)
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'display_name', includeIfNull: false)
  String? get displayName;
  @override
  @JsonKey(name: 'first_name', includeIfNull: false)
  String? get firstName;
  @override
  @JsonKey(name: 'last_name', includeIfNull: false)
  String? get lastName;
  @override
  @JsonKey(name: 'image_avatar', includeIfNull: false)
  String? get imageAvatar;
  @override
  @JsonKey(name: 'new_photos_expanded', includeIfNull: false)
  List<DbFileDto>? get newPhotosExpanded;
  @override
  @JsonKey(name: 'date_of_birth', includeIfNull: false)
  DateTime? get dateOfBirth;
  @override
  @JsonKey(name: 'phone_verified', includeIfNull: false)
  bool? get phoneVerified;
  @override
  @JsonKey(name: 'google_user_info', includeIfNull: false)
  GoogleUserInfoDto? get googleUserInfo;
  @override
  @JsonKey(name: 'discord_user_info', includeIfNull: false)
  DiscordUserInfoDto? get discordUserInfo;
  @override
  @JsonKey(name: 'shopify_user_info', includeIfNull: false)
  ShopifyUserInfoDto? get shopifyUserInfo;
  @override
  @JsonKey(name: 'twitch_user_info', includeIfNull: false)
  TwitchUserInfoDto? get twitchUserInfo;
  @override
  @JsonKey(name: 'zoom_user_info', includeIfNull: false)
  ZoomUserInfoDto? get zoomUserInfo;
  @override
  String? get name;
  @override
  String? get username;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  String? get description;
  @override
  bool? get active;
  @override
  String? get cover;
  @override
  UserType? get type;
  @override
  String? get industry;
  @override
  List<AddressDto>? get addresses;
  @override
  int? get hosted;
  @override
  int? get attended;
  @override
  int? get friends;
  @override
  int? get following;
  @override
  int? get followers;
  @override
  Currency? get currency;
  @override
  @JsonKey(ignore: true)
  _$$_UserDtoCopyWith<_$_UserDto> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscordUserInfoDto _$DiscordUserInfoDtoFromJson(Map<String, dynamic> json) {
  return _DiscordUserInfoDto.fromJson(json);
}

/// @nodoc
mixin _$DiscordUserInfoDto {
  String? get username => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiscordUserInfoDtoCopyWith<DiscordUserInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscordUserInfoDtoCopyWith<$Res> {
  factory $DiscordUserInfoDtoCopyWith(
          DiscordUserInfoDto value, $Res Function(DiscordUserInfoDto) then) =
      _$DiscordUserInfoDtoCopyWithImpl<$Res, DiscordUserInfoDto>;
  @useResult
  $Res call({String? username});
}

/// @nodoc
class _$DiscordUserInfoDtoCopyWithImpl<$Res, $Val extends DiscordUserInfoDto>
    implements $DiscordUserInfoDtoCopyWith<$Res> {
  _$DiscordUserInfoDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
  }) {
    return _then(_value.copyWith(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DiscordUserInfoDtoCopyWith<$Res>
    implements $DiscordUserInfoDtoCopyWith<$Res> {
  factory _$$_DiscordUserInfoDtoCopyWith(_$_DiscordUserInfoDto value,
          $Res Function(_$_DiscordUserInfoDto) then) =
      __$$_DiscordUserInfoDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? username});
}

/// @nodoc
class __$$_DiscordUserInfoDtoCopyWithImpl<$Res>
    extends _$DiscordUserInfoDtoCopyWithImpl<$Res, _$_DiscordUserInfoDto>
    implements _$$_DiscordUserInfoDtoCopyWith<$Res> {
  __$$_DiscordUserInfoDtoCopyWithImpl(
      _$_DiscordUserInfoDto _value, $Res Function(_$_DiscordUserInfoDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
  }) {
    return _then(_$_DiscordUserInfoDto(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DiscordUserInfoDto implements _DiscordUserInfoDto {
  const _$_DiscordUserInfoDto({this.username});

  factory _$_DiscordUserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$$_DiscordUserInfoDtoFromJson(json);

  @override
  final String? username;

  @override
  String toString() {
    return 'DiscordUserInfoDto(username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DiscordUserInfoDto &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DiscordUserInfoDtoCopyWith<_$_DiscordUserInfoDto> get copyWith =>
      __$$_DiscordUserInfoDtoCopyWithImpl<_$_DiscordUserInfoDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DiscordUserInfoDtoToJson(
      this,
    );
  }
}

abstract class _DiscordUserInfoDto implements DiscordUserInfoDto {
  const factory _DiscordUserInfoDto({final String? username}) =
      _$_DiscordUserInfoDto;

  factory _DiscordUserInfoDto.fromJson(Map<String, dynamic> json) =
      _$_DiscordUserInfoDto.fromJson;

  @override
  String? get username;
  @override
  @JsonKey(ignore: true)
  _$$_DiscordUserInfoDtoCopyWith<_$_DiscordUserInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

ShopifyUserInfoDto _$ShopifyUserInfoDtoFromJson(Map<String, dynamic> json) {
  return _ShopifyUserInfoDto.fromJson(json);
}

/// @nodoc
mixin _$ShopifyUserInfoDto {
  @JsonKey(name: 'shop_name', includeIfNull: false)
  String? get shopName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShopifyUserInfoDtoCopyWith<ShopifyUserInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopifyUserInfoDtoCopyWith<$Res> {
  factory $ShopifyUserInfoDtoCopyWith(
          ShopifyUserInfoDto value, $Res Function(ShopifyUserInfoDto) then) =
      _$ShopifyUserInfoDtoCopyWithImpl<$Res, ShopifyUserInfoDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'shop_name', includeIfNull: false) String? shopName});
}

/// @nodoc
class _$ShopifyUserInfoDtoCopyWithImpl<$Res, $Val extends ShopifyUserInfoDto>
    implements $ShopifyUserInfoDtoCopyWith<$Res> {
  _$ShopifyUserInfoDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shopName = freezed,
  }) {
    return _then(_value.copyWith(
      shopName: freezed == shopName
          ? _value.shopName
          : shopName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ShopifyUserInfoDtoCopyWith<$Res>
    implements $ShopifyUserInfoDtoCopyWith<$Res> {
  factory _$$_ShopifyUserInfoDtoCopyWith(_$_ShopifyUserInfoDto value,
          $Res Function(_$_ShopifyUserInfoDto) then) =
      __$$_ShopifyUserInfoDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'shop_name', includeIfNull: false) String? shopName});
}

/// @nodoc
class __$$_ShopifyUserInfoDtoCopyWithImpl<$Res>
    extends _$ShopifyUserInfoDtoCopyWithImpl<$Res, _$_ShopifyUserInfoDto>
    implements _$$_ShopifyUserInfoDtoCopyWith<$Res> {
  __$$_ShopifyUserInfoDtoCopyWithImpl(
      _$_ShopifyUserInfoDto _value, $Res Function(_$_ShopifyUserInfoDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shopName = freezed,
  }) {
    return _then(_$_ShopifyUserInfoDto(
      shopName: freezed == shopName
          ? _value.shopName
          : shopName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShopifyUserInfoDto implements _ShopifyUserInfoDto {
  const _$_ShopifyUserInfoDto(
      {@JsonKey(name: 'shop_name', includeIfNull: false) this.shopName});

  factory _$_ShopifyUserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$$_ShopifyUserInfoDtoFromJson(json);

  @override
  @JsonKey(name: 'shop_name', includeIfNull: false)
  final String? shopName;

  @override
  String toString() {
    return 'ShopifyUserInfoDto(shopName: $shopName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShopifyUserInfoDto &&
            (identical(other.shopName, shopName) ||
                other.shopName == shopName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, shopName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShopifyUserInfoDtoCopyWith<_$_ShopifyUserInfoDto> get copyWith =>
      __$$_ShopifyUserInfoDtoCopyWithImpl<_$_ShopifyUserInfoDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShopifyUserInfoDtoToJson(
      this,
    );
  }
}

abstract class _ShopifyUserInfoDto implements ShopifyUserInfoDto {
  const factory _ShopifyUserInfoDto(
      {@JsonKey(name: 'shop_name', includeIfNull: false)
          final String? shopName}) = _$_ShopifyUserInfoDto;

  factory _ShopifyUserInfoDto.fromJson(Map<String, dynamic> json) =
      _$_ShopifyUserInfoDto.fromJson;

  @override
  @JsonKey(name: 'shop_name', includeIfNull: false)
  String? get shopName;
  @override
  @JsonKey(ignore: true)
  _$$_ShopifyUserInfoDtoCopyWith<_$_ShopifyUserInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

GoogleUserInfoDto _$GoogleUserInfoDtoFromJson(Map<String, dynamic> json) {
  return _GoogleUserInfoDto.fromJson(json);
}

/// @nodoc
mixin _$GoogleUserInfoDto {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'family_age', includeIfNull: false)
  String? get familyName => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'given_name', includeIfNull: false)
  String? get givenName => throw _privateConstructorUsedError;
  String? get hd => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;
  String? get locale => throw _privateConstructorUsedError;
  String? get picture => throw _privateConstructorUsedError;
  @JsonKey(name: 'verified_email', includeIfNull: false)
  String? get verifiedEmail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoogleUserInfoDtoCopyWith<GoogleUserInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoogleUserInfoDtoCopyWith<$Res> {
  factory $GoogleUserInfoDtoCopyWith(
          GoogleUserInfoDto value, $Res Function(GoogleUserInfoDto) then) =
      _$GoogleUserInfoDtoCopyWithImpl<$Res, GoogleUserInfoDto>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? email,
      @JsonKey(name: 'family_age', includeIfNull: false)
          String? familyName,
      String? gender,
      @JsonKey(name: 'given_name', includeIfNull: false)
          String? givenName,
      String? hd,
      String? link,
      String? locale,
      String? picture,
      @JsonKey(name: 'verified_email', includeIfNull: false)
          String? verifiedEmail});
}

/// @nodoc
class _$GoogleUserInfoDtoCopyWithImpl<$Res, $Val extends GoogleUserInfoDto>
    implements $GoogleUserInfoDtoCopyWith<$Res> {
  _$GoogleUserInfoDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? familyName = freezed,
    Object? gender = freezed,
    Object? givenName = freezed,
    Object? hd = freezed,
    Object? link = freezed,
    Object? locale = freezed,
    Object? picture = freezed,
    Object? verifiedEmail = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      familyName: freezed == familyName
          ? _value.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      givenName: freezed == givenName
          ? _value.givenName
          : givenName // ignore: cast_nullable_to_non_nullable
              as String?,
      hd: freezed == hd
          ? _value.hd
          : hd // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String?,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      verifiedEmail: freezed == verifiedEmail
          ? _value.verifiedEmail
          : verifiedEmail // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GoogleUserInfoDtoCopyWith<$Res>
    implements $GoogleUserInfoDtoCopyWith<$Res> {
  factory _$$_GoogleUserInfoDtoCopyWith(_$_GoogleUserInfoDto value,
          $Res Function(_$_GoogleUserInfoDto) then) =
      __$$_GoogleUserInfoDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? email,
      @JsonKey(name: 'family_age', includeIfNull: false)
          String? familyName,
      String? gender,
      @JsonKey(name: 'given_name', includeIfNull: false)
          String? givenName,
      String? hd,
      String? link,
      String? locale,
      String? picture,
      @JsonKey(name: 'verified_email', includeIfNull: false)
          String? verifiedEmail});
}

/// @nodoc
class __$$_GoogleUserInfoDtoCopyWithImpl<$Res>
    extends _$GoogleUserInfoDtoCopyWithImpl<$Res, _$_GoogleUserInfoDto>
    implements _$$_GoogleUserInfoDtoCopyWith<$Res> {
  __$$_GoogleUserInfoDtoCopyWithImpl(
      _$_GoogleUserInfoDto _value, $Res Function(_$_GoogleUserInfoDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? familyName = freezed,
    Object? gender = freezed,
    Object? givenName = freezed,
    Object? hd = freezed,
    Object? link = freezed,
    Object? locale = freezed,
    Object? picture = freezed,
    Object? verifiedEmail = freezed,
  }) {
    return _then(_$_GoogleUserInfoDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      familyName: freezed == familyName
          ? _value.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      givenName: freezed == givenName
          ? _value.givenName
          : givenName // ignore: cast_nullable_to_non_nullable
              as String?,
      hd: freezed == hd
          ? _value.hd
          : hd // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String?,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      verifiedEmail: freezed == verifiedEmail
          ? _value.verifiedEmail
          : verifiedEmail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GoogleUserInfoDto implements _GoogleUserInfoDto {
  const _$_GoogleUserInfoDto(
      {this.id,
      this.name,
      this.email,
      @JsonKey(name: 'family_age', includeIfNull: false)
          this.familyName,
      this.gender,
      @JsonKey(name: 'given_name', includeIfNull: false)
          this.givenName,
      this.hd,
      this.link,
      this.locale,
      this.picture,
      @JsonKey(name: 'verified_email', includeIfNull: false)
          this.verifiedEmail});

  factory _$_GoogleUserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$$_GoogleUserInfoDtoFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? email;
  @override
  @JsonKey(name: 'family_age', includeIfNull: false)
  final String? familyName;
  @override
  final String? gender;
  @override
  @JsonKey(name: 'given_name', includeIfNull: false)
  final String? givenName;
  @override
  final String? hd;
  @override
  final String? link;
  @override
  final String? locale;
  @override
  final String? picture;
  @override
  @JsonKey(name: 'verified_email', includeIfNull: false)
  final String? verifiedEmail;

  @override
  String toString() {
    return 'GoogleUserInfoDto(id: $id, name: $name, email: $email, familyName: $familyName, gender: $gender, givenName: $givenName, hd: $hd, link: $link, locale: $locale, picture: $picture, verifiedEmail: $verifiedEmail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GoogleUserInfoDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.familyName, familyName) ||
                other.familyName == familyName) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.givenName, givenName) ||
                other.givenName == givenName) &&
            (identical(other.hd, hd) || other.hd == hd) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.picture, picture) || other.picture == picture) &&
            (identical(other.verifiedEmail, verifiedEmail) ||
                other.verifiedEmail == verifiedEmail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, familyName,
      gender, givenName, hd, link, locale, picture, verifiedEmail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GoogleUserInfoDtoCopyWith<_$_GoogleUserInfoDto> get copyWith =>
      __$$_GoogleUserInfoDtoCopyWithImpl<_$_GoogleUserInfoDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GoogleUserInfoDtoToJson(
      this,
    );
  }
}

abstract class _GoogleUserInfoDto implements GoogleUserInfoDto {
  const factory _GoogleUserInfoDto(
      {final String? id,
      final String? name,
      final String? email,
      @JsonKey(name: 'family_age', includeIfNull: false)
          final String? familyName,
      final String? gender,
      @JsonKey(name: 'given_name', includeIfNull: false)
          final String? givenName,
      final String? hd,
      final String? link,
      final String? locale,
      final String? picture,
      @JsonKey(name: 'verified_email', includeIfNull: false)
          final String? verifiedEmail}) = _$_GoogleUserInfoDto;

  factory _GoogleUserInfoDto.fromJson(Map<String, dynamic> json) =
      _$_GoogleUserInfoDto.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get email;
  @override
  @JsonKey(name: 'family_age', includeIfNull: false)
  String? get familyName;
  @override
  String? get gender;
  @override
  @JsonKey(name: 'given_name', includeIfNull: false)
  String? get givenName;
  @override
  String? get hd;
  @override
  String? get link;
  @override
  String? get locale;
  @override
  String? get picture;
  @override
  @JsonKey(name: 'verified_email', includeIfNull: false)
  String? get verifiedEmail;
  @override
  @JsonKey(ignore: true)
  _$$_GoogleUserInfoDtoCopyWith<_$_GoogleUserInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

TwitchUserInfoDto _$TwitchUserInfoDtoFromJson(Map<String, dynamic> json) {
  return _TwitchUserInfoDto.fromJson(json);
}

/// @nodoc
mixin _$TwitchUserInfoDto {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name', includeIfNull: false)
  String? get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: 'logo_url', includeIfNull: false)
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TwitchUserInfoDtoCopyWith<TwitchUserInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TwitchUserInfoDtoCopyWith<$Res> {
  factory $TwitchUserInfoDtoCopyWith(
          TwitchUserInfoDto value, $Res Function(TwitchUserInfoDto) then) =
      _$TwitchUserInfoDtoCopyWithImpl<$Res, TwitchUserInfoDto>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'display_name', includeIfNull: false) String? displayName,
      @JsonKey(name: 'logo_url', includeIfNull: false) String? logoUrl,
      String? name});
}

/// @nodoc
class _$TwitchUserInfoDtoCopyWithImpl<$Res, $Val extends TwitchUserInfoDto>
    implements $TwitchUserInfoDtoCopyWith<$Res> {
  _$TwitchUserInfoDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? displayName = freezed,
    Object? logoUrl = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TwitchUserInfoDtoCopyWith<$Res>
    implements $TwitchUserInfoDtoCopyWith<$Res> {
  factory _$$_TwitchUserInfoDtoCopyWith(_$_TwitchUserInfoDto value,
          $Res Function(_$_TwitchUserInfoDto) then) =
      __$$_TwitchUserInfoDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'display_name', includeIfNull: false) String? displayName,
      @JsonKey(name: 'logo_url', includeIfNull: false) String? logoUrl,
      String? name});
}

/// @nodoc
class __$$_TwitchUserInfoDtoCopyWithImpl<$Res>
    extends _$TwitchUserInfoDtoCopyWithImpl<$Res, _$_TwitchUserInfoDto>
    implements _$$_TwitchUserInfoDtoCopyWith<$Res> {
  __$$_TwitchUserInfoDtoCopyWithImpl(
      _$_TwitchUserInfoDto _value, $Res Function(_$_TwitchUserInfoDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? displayName = freezed,
    Object? logoUrl = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_TwitchUserInfoDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TwitchUserInfoDto implements _TwitchUserInfoDto {
  const _$_TwitchUserInfoDto(
      {this.id,
      @JsonKey(name: 'display_name', includeIfNull: false) this.displayName,
      @JsonKey(name: 'logo_url', includeIfNull: false) this.logoUrl,
      this.name});

  factory _$_TwitchUserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$$_TwitchUserInfoDtoFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'display_name', includeIfNull: false)
  final String? displayName;
  @override
  @JsonKey(name: 'logo_url', includeIfNull: false)
  final String? logoUrl;
  @override
  final String? name;

  @override
  String toString() {
    return 'TwitchUserInfoDto(id: $id, displayName: $displayName, logoUrl: $logoUrl, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TwitchUserInfoDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, displayName, logoUrl, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TwitchUserInfoDtoCopyWith<_$_TwitchUserInfoDto> get copyWith =>
      __$$_TwitchUserInfoDtoCopyWithImpl<_$_TwitchUserInfoDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TwitchUserInfoDtoToJson(
      this,
    );
  }
}

abstract class _TwitchUserInfoDto implements TwitchUserInfoDto {
  const factory _TwitchUserInfoDto(
      {final String? id,
      @JsonKey(name: 'display_name', includeIfNull: false)
          final String? displayName,
      @JsonKey(name: 'logo_url', includeIfNull: false)
          final String? logoUrl,
      final String? name}) = _$_TwitchUserInfoDto;

  factory _TwitchUserInfoDto.fromJson(Map<String, dynamic> json) =
      _$_TwitchUserInfoDto.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'display_name', includeIfNull: false)
  String? get displayName;
  @override
  @JsonKey(name: 'logo_url', includeIfNull: false)
  String? get logoUrl;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_TwitchUserInfoDtoCopyWith<_$_TwitchUserInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

ZoomUserInfoDto _$ZoomUserInfoDtoFromJson(Map<String, dynamic> json) {
  return _ZoomUserInfoDto.fromJson(json);
}

/// @nodoc
mixin _$ZoomUserInfoDto {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name', includeIfNull: false)
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name', includeIfNull: false)
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ZoomUserInfoDtoCopyWith<ZoomUserInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ZoomUserInfoDtoCopyWith<$Res> {
  factory $ZoomUserInfoDtoCopyWith(
          ZoomUserInfoDto value, $Res Function(ZoomUserInfoDto) then) =
      _$ZoomUserInfoDtoCopyWithImpl<$Res, ZoomUserInfoDto>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'first_name', includeIfNull: false) String? firstName,
      @JsonKey(name: 'last_name', includeIfNull: false) String? lastName,
      String? email});
}

/// @nodoc
class _$ZoomUserInfoDtoCopyWithImpl<$Res, $Val extends ZoomUserInfoDto>
    implements $ZoomUserInfoDtoCopyWith<$Res> {
  _$ZoomUserInfoDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ZoomUserInfoDtoCopyWith<$Res>
    implements $ZoomUserInfoDtoCopyWith<$Res> {
  factory _$$_ZoomUserInfoDtoCopyWith(
          _$_ZoomUserInfoDto value, $Res Function(_$_ZoomUserInfoDto) then) =
      __$$_ZoomUserInfoDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'first_name', includeIfNull: false) String? firstName,
      @JsonKey(name: 'last_name', includeIfNull: false) String? lastName,
      String? email});
}

/// @nodoc
class __$$_ZoomUserInfoDtoCopyWithImpl<$Res>
    extends _$ZoomUserInfoDtoCopyWithImpl<$Res, _$_ZoomUserInfoDto>
    implements _$$_ZoomUserInfoDtoCopyWith<$Res> {
  __$$_ZoomUserInfoDtoCopyWithImpl(
      _$_ZoomUserInfoDto _value, $Res Function(_$_ZoomUserInfoDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
  }) {
    return _then(_$_ZoomUserInfoDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ZoomUserInfoDto implements _ZoomUserInfoDto {
  const _$_ZoomUserInfoDto(
      {this.id,
      @JsonKey(name: 'first_name', includeIfNull: false) this.firstName,
      @JsonKey(name: 'last_name', includeIfNull: false) this.lastName,
      this.email});

  factory _$_ZoomUserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$$_ZoomUserInfoDtoFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'first_name', includeIfNull: false)
  final String? firstName;
  @override
  @JsonKey(name: 'last_name', includeIfNull: false)
  final String? lastName;
  @override
  final String? email;

  @override
  String toString() {
    return 'ZoomUserInfoDto(id: $id, firstName: $firstName, lastName: $lastName, email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ZoomUserInfoDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, firstName, lastName, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ZoomUserInfoDtoCopyWith<_$_ZoomUserInfoDto> get copyWith =>
      __$$_ZoomUserInfoDtoCopyWithImpl<_$_ZoomUserInfoDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ZoomUserInfoDtoToJson(
      this,
    );
  }
}

abstract class _ZoomUserInfoDto implements ZoomUserInfoDto {
  const factory _ZoomUserInfoDto(
      {final String? id,
      @JsonKey(name: 'first_name', includeIfNull: false)
          final String? firstName,
      @JsonKey(name: 'last_name', includeIfNull: false)
          final String? lastName,
      final String? email}) = _$_ZoomUserInfoDto;

  factory _ZoomUserInfoDto.fromJson(Map<String, dynamic> json) =
      _$_ZoomUserInfoDto.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'first_name', includeIfNull: false)
  String? get firstName;
  @override
  @JsonKey(name: 'last_name', includeIfNull: false)
  String? get lastName;
  @override
  String? get email;
  @override
  @JsonKey(ignore: true)
  _$$_ZoomUserInfoDtoCopyWith<_$_ZoomUserInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}
