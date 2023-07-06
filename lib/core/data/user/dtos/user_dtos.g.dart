// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserDto _$$_UserDtoFromJson(Map<String, dynamic> json) => _$_UserDto(
      id: json['_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      userName: json['user_name'] as String?,
      displayName: json['display_name'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      imageAvatar: json['image_avatar'] as String?,
      newPhotosExpanded: (json['new_photos_expanded'] as List<dynamic>?)
          ?.map((e) => DbFileDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      phoneVerified: json['phone_verified'] as bool?,
      googleUserInfo: json['google_user_info'] == null
          ? null
          : GoogleUserInfoDto.fromJson(
              json['google_user_info'] as Map<String, dynamic>),
      discordUserInfo: json['discord_user_info'] == null
          ? null
          : DiscordUserInfoDto.fromJson(
              json['discord_user_info'] as Map<String, dynamic>),
      shopifyUserInfo: json['shopify_user_info'] == null
          ? null
          : ShopifyUserInfoDto.fromJson(
              json['shopify_user_info'] as Map<String, dynamic>),
      twitchUserInfo: json['twitch_user_info'] == null
          ? null
          : TwitchUserInfoDto.fromJson(
              json['twitch_user_info'] as Map<String, dynamic>),
      zoomUserInfo: json['zoom_user_info'] == null
          ? null
          : ZoomUserInfoDto.fromJson(
              json['zoom_user_info'] as Map<String, dynamic>),
      handleTwitter: json['handle_twitter'] as String?,
      handleInstagram: json['handle_instagram'] as String?,
      handleFacebook: json['handle_facebook'] as String?,
      handleLinkedin: json['handle_linkedin'] as String?,
      wallets:
          (json['wallets'] as List<dynamic>?)?.map((e) => e as String).toList(),
      walletCustodial: json['wallet_custodial'] as String?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      description: json['description'] as String?,
      active: json['active'] as bool?,
      cover: json['cover'] as String?,
      type: $enumDecodeNullable(_$UserTypeEnumMap, json['type']),
      industry: json['industry'] as String?,
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => AddressDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      hosted: json['hosted'] as int?,
      attended: json['attended'] as int?,
      friends: json['friends'] as int?,
      following: json['following'] as int?,
      followers: json['followers'] as int?,
      jobTitle: json['job_title'] as String?,
      tagline: json['tagline'] as String?,
      currency: $enumDecodeNullable(_$CurrencyEnumMap, json['currency']),
    );

Map<String, dynamic> _$$_UserDtoToJson(_$_UserDto instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('user_name', instance.userName);
  writeNotNull('display_name', instance.displayName);
  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('image_avatar', instance.imageAvatar);
  writeNotNull('new_photos_expanded', instance.newPhotosExpanded);
  writeNotNull('date_of_birth', instance.dateOfBirth?.toIso8601String());
  writeNotNull('phone_verified', instance.phoneVerified);
  writeNotNull('google_user_info', instance.googleUserInfo);
  writeNotNull('discord_user_info', instance.discordUserInfo);
  writeNotNull('shopify_user_info', instance.shopifyUserInfo);
  writeNotNull('twitch_user_info', instance.twitchUserInfo);
  writeNotNull('zoom_user_info', instance.zoomUserInfo);
  val['handle_twitter'] = instance.handleTwitter;
  val['handle_instagram'] = instance.handleInstagram;
  val['handle_facebook'] = instance.handleFacebook;
  val['handle_linkedin'] = instance.handleLinkedin;
  val['wallets'] = instance.wallets;
  val['wallet_custodial'] = instance.walletCustodial;
  val['name'] = instance.name;
  val['username'] = instance.username;
  val['phone'] = instance.phone;
  val['email'] = instance.email;
  val['description'] = instance.description;
  val['active'] = instance.active;
  val['cover'] = instance.cover;
  val['type'] = _$UserTypeEnumMap[instance.type];
  val['industry'] = instance.industry;
  val['addresses'] = instance.addresses;
  val['hosted'] = instance.hosted;
  val['attended'] = instance.attended;
  val['friends'] = instance.friends;
  val['following'] = instance.following;
  val['followers'] = instance.followers;
  val['job_title'] = instance.jobTitle;
  val['tagline'] = instance.tagline;
  val['currency'] = _$CurrencyEnumMap[instance.currency];
  return val;
}

const _$UserTypeEnumMap = {
  UserType.guest: 'guest',
  UserType.admin: 'admin',
};

const _$CurrencyEnumMap = {
  Currency.AUD: 'AUD',
  Currency.CAD: 'CAD',
  Currency.EUR: 'EUR',
  Currency.GBP: 'GBP',
  Currency.INR: 'INR',
  Currency.USD: 'USD',
};

_$_DiscordUserInfoDto _$$_DiscordUserInfoDtoFromJson(
        Map<String, dynamic> json) =>
    _$_DiscordUserInfoDto(
      username: json['username'] as String?,
    );

Map<String, dynamic> _$$_DiscordUserInfoDtoToJson(
        _$_DiscordUserInfoDto instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

_$_ShopifyUserInfoDto _$$_ShopifyUserInfoDtoFromJson(
        Map<String, dynamic> json) =>
    _$_ShopifyUserInfoDto(
      shopName: json['shop_name'] as String?,
    );

Map<String, dynamic> _$$_ShopifyUserInfoDtoToJson(
    _$_ShopifyUserInfoDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('shop_name', instance.shopName);
  return val;
}

_$_GoogleUserInfoDto _$$_GoogleUserInfoDtoFromJson(Map<String, dynamic> json) =>
    _$_GoogleUserInfoDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      familyName: json['family_age'] as String?,
      gender: json['gender'] as String?,
      givenName: json['given_name'] as String?,
      hd: json['hd'] as String?,
      link: json['link'] as String?,
      locale: json['locale'] as String?,
      picture: json['picture'] as String?,
      verifiedEmail: json['verified_email'] as String?,
    );

Map<String, dynamic> _$$_GoogleUserInfoDtoToJson(
    _$_GoogleUserInfoDto instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('family_age', instance.familyName);
  val['gender'] = instance.gender;
  writeNotNull('given_name', instance.givenName);
  val['hd'] = instance.hd;
  val['link'] = instance.link;
  val['locale'] = instance.locale;
  val['picture'] = instance.picture;
  writeNotNull('verified_email', instance.verifiedEmail);
  return val;
}

_$_TwitchUserInfoDto _$$_TwitchUserInfoDtoFromJson(Map<String, dynamic> json) =>
    _$_TwitchUserInfoDto(
      id: json['id'] as String?,
      displayName: json['display_name'] as String?,
      logoUrl: json['logo_url'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$_TwitchUserInfoDtoToJson(
    _$_TwitchUserInfoDto instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('display_name', instance.displayName);
  writeNotNull('logo_url', instance.logoUrl);
  val['name'] = instance.name;
  return val;
}

_$_ZoomUserInfoDto _$$_ZoomUserInfoDtoFromJson(Map<String, dynamic> json) =>
    _$_ZoomUserInfoDto(
      id: json['id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$_ZoomUserInfoDtoToJson(_$_ZoomUserInfoDto instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  val['email'] = instance.email;
  return val;
}
