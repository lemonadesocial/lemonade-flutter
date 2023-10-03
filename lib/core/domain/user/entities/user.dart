import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/data/user/user_enums.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/payment/payment_enums.dart';

class AuthUser {
  AuthUser({
    required this.id,
    this.imageAvatar,
    this.displayName,
    this.username,
    this.wallets,
    this.walletCustodial,
  });

  factory AuthUser.fromDto(UserDto dto) {
    return AuthUser(
      id: dto.id!,
      imageAvatar: dto.imageAvatar,
      displayName: dto.displayName,
      username: dto.username,
      wallets: dto.wallets,
      walletCustodial: dto.walletCustodial,
    );
  }

  String id;
  String? imageAvatar;
  String? displayName;
  String? username;
  List<String>? wallets;
  String? walletCustodial;
}

class User {
  const User({
    required this.userId,
    this.createdAt,
    this.displayName,
    this.firstName,
    this.lastName,
    this.imageAvatar,
    this.newPhotosExpanded,
    this.dateOfBirth,
    this.phoneVerified,
    this.googleUserInfo,
    this.discordUserInfo,
    this.shopifyUserInfo,
    this.twitchUserInfo,
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
    this.addresses,
    this.hosted,
    this.attended,
    this.friends,
    this.following,
    this.followers,
    this.currency,
    this.jobTitle,
    this.tagline,
    this.handleTwitter,
    this.handleInstagram,
    this.handleFacebook,
    this.handleLinkedin,
    this.wallets,
    this.walletCustodial,
    this.gender,
    this.ethnicity,
    this.education,
    this.companyName,
    this.notificationFilterList,
  });

  factory User.fromDto(UserDto dto) {
    return User(
      userId: dto.id ?? '',
      createdAt: dto.createdAt,
      displayName: dto.displayName,
      firstName: dto.firstName,
      lastName: dto.lastName,
      imageAvatar: dto.imageAvatar,
      newPhotosExpanded: dto.newPhotosExpanded != null
          ? dto.newPhotosExpanded!.map(DbFile.fromDto).toList()
          : null,
      dateOfBirth: dto.dateOfBirth,
      phoneVerified: dto.phoneVerified,
      googleUserInfo: dto.googleUserInfo != null
          ? GoogleUserInfo.fromDto(dto.googleUserInfo!)
          : null,
      discordUserInfo: dto.discordUserInfo != null
          ? DiscordUserInfo.fromDto(dto.discordUserInfo!)
          : null,
      shopifyUserInfo: dto.shopifyUserInfo != null
          ? ShopifyUserInfo.fromDto(dto.shopifyUserInfo!)
          : null,
      twitchUserInfo: dto.twitchUserInfo != null
          ? TwitchUserInfo.fromDto(dto.twitchUserInfo!)
          : null,
      zoomUserInfo: dto.zoomUserInfo != null
          ? ZoomUserInfo.fromDto(dto.zoomUserInfo!)
          : null,
      name: dto.name,
      username: dto.username,
      phone: dto.phone,
      email: dto.email,
      description: dto.description,
      active: dto.active,
      cover: dto.cover,
      type: dto.type,
      industry: dto.industry,
      addresses: dto.addresses != null
          ? dto.addresses!.map(Address.fromDto).toList()
          : null,
      hosted: dto.hosted,
      attended: dto.attended,
      friends: dto.friends,
      following: dto.following,
      followers: dto.followers,
      currency: dto.currency,
      jobTitle: dto.jobTitle,
      tagline: dto.tagline,
      handleTwitter: dto.handleTwitter,
      handleInstagram: dto.handleInstagram,
      handleFacebook: dto.handleFacebook,
      handleLinkedin: dto.handleLinkedin,
      wallets: dto.wallets,
      walletCustodial: dto.walletCustodial,
      gender: dto.newGender,
      companyName: dto.companyName,
      education: dto.educationTitle,
      ethnicity: dto.ethnicity,
      notificationFilterList:
          dto.notificationFilter.map((e) => e.type).toList(),
    );
  }

  final String userId;
  final DateTime? createdAt;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final String? imageAvatar;
  final List<DbFile>? newPhotosExpanded;
  final DateTime? dateOfBirth;
  final bool? phoneVerified;
  final GoogleUserInfo? googleUserInfo;
  final DiscordUserInfo? discordUserInfo;
  final ShopifyUserInfo? shopifyUserInfo;
  final TwitchUserInfo? twitchUserInfo;
  final ZoomUserInfo? zoomUserInfo;
  final String? name;
  final String? username;
  final String? phone;
  final String? email;
  final String? description;
  final bool? active;
  final String? cover;
  final UserType? type;
  final List<Address>? addresses;
  final int? hosted;
  final int? attended;
  final int? friends;
  final int? following;
  final int? followers;
  final Currency? currency;

  final String? jobTitle;
  final String? companyName;
  final String? tagline;

  final String? industry;
  final String? education;
  final String? ethnicity;
  final String? gender;

  final String? handleTwitter;
  final String? handleInstagram;
  final String? handleFacebook;
  final String? handleLinkedin;

  final List<String>? wallets;
  final String? walletCustodial;
  final List<String>? notificationFilterList;
}

class DiscordUserInfo {
  DiscordUserInfo({this.username});

  final String? username;

  static DiscordUserInfo fromDto(DiscordUserInfoDto dto) {
    return DiscordUserInfo(username: dto.username);
  }
}

class ShopifyUserInfo {
  ShopifyUserInfo({this.shopName});

  final String? shopName;

  static ShopifyUserInfo fromDto(ShopifyUserInfoDto dto) {
    return ShopifyUserInfo(shopName: dto.shopName);
  }
}

class GoogleUserInfo {
  GoogleUserInfo({
    this.id,
    this.name,
    this.email,
    this.familyName,
    this.gender,
    this.givenName,
    this.hd,
    this.link,
    this.locale,
    this.picture,
    this.verifiedEmail,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? familyName;
  final String? gender;
  final String? givenName;
  final String? hd;
  final String? link;
  final String? locale;
  final String? picture;
  final String? verifiedEmail;

  static GoogleUserInfo fromDto(GoogleUserInfoDto dto) {
    return GoogleUserInfo(
      id: dto.id,
      name: dto.name,
      email: dto.email,
      familyName: dto.familyName,
      gender: dto.gender,
      givenName: dto.givenName,
      hd: dto.hd,
      link: dto.link,
      locale: dto.locale,
      picture: dto.picture,
      verifiedEmail: dto.verifiedEmail,
    );
  }
}

class TwitchUserInfo {
  TwitchUserInfo({this.id, this.displayName, this.logoUrl, this.name});

  final String? id;
  final String? displayName;
  final String? logoUrl;
  final String? name;

  static TwitchUserInfo fromDto(TwitchUserInfoDto dto) {
    return TwitchUserInfo(
      id: dto.id,
      displayName: dto.displayName,
      logoUrl: dto.logoUrl,
      name: dto.name,
    );
  }
}

class ZoomUserInfo {
  ZoomUserInfo({this.id, this.firstName, this.lastName, this.email});

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;

  static ZoomUserInfo fromDto(ZoomUserInfoDto dto) {
    return ZoomUserInfo(
      id: dto.id,
      firstName: dto.firstName,
      lastName: dto.lastName,
      email: dto.email,
    );
  }
}
