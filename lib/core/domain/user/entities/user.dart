import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/data/user/user_enums.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/payment/payment_enums.dart';

class AuthUser {
  String id;
  String? imageAvatar;
  String? displayName;
  String? username;

  AuthUser({
    required this.id,
    this.imageAvatar,
    this.displayName,
    this.username,
  });

  factory AuthUser.fromDto(UserDto dto) {
    return AuthUser(
      id: dto.id!,
      imageAvatar: dto.imageAvatar,
      displayName: dto.displayName,
      username: dto.username
    );
  }
}

class User {
  final String? id;
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
  final String? industry;
  final List<Address>? addresses;
  final int? hosted;
  final int? attended;
  final int? friends;
  final int? following;
  final int? followers;
  final Currency? currency;

  final String? jobTitle;
  final String? tagline;

  final String? handleTwitter;
  final String? handleInstagram;
  final String? handleFacebook;
  final String? handleLinkedin;

  final List<String>? wallets;
  final String? walletCustodial;

  User({
    this.id,
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
  });

  factory User.fromDto(UserDto dto) {
    return User(
      id: dto.id,
      createdAt: dto.createdAt,
      displayName: dto.displayName,
      firstName: dto.firstName,
      lastName: dto.lastName,
      imageAvatar: dto.imageAvatar,
      newPhotosExpanded: dto.newPhotosExpanded != null
          ? dto.newPhotosExpanded!.map((dbFile) => DbFile.fromDto(dbFile)).toList()
          : null,
      dateOfBirth: dto.dateOfBirth,
      phoneVerified: dto.phoneVerified,
      googleUserInfo: dto.googleUserInfo != null ? GoogleUserInfo.fromDto(dto.googleUserInfo!) : null,
      discordUserInfo: dto.discordUserInfo != null ? DiscordUserInfo.fromDto(dto.discordUserInfo!) : null,
      shopifyUserInfo: dto.shopifyUserInfo != null ? ShopifyUserInfo.fromDto(dto.shopifyUserInfo!) : null,
      twitchUserInfo: dto.twitchUserInfo != null ? TwitchUserInfo.fromDto(dto.twitchUserInfo!) : null,
      zoomUserInfo: dto.zoomUserInfo != null ? ZoomUserInfo.fromDto(dto.zoomUserInfo!) : null,
      name: dto.name,
      username: dto.username,
      phone: dto.phone,
      email: dto.email,
      description: dto.description,
      active: dto.active,
      cover: dto.cover,
      type: dto.type,
      industry: dto.industry,
      addresses: dto.addresses != null ? dto.addresses!.map((address) => Address.fromDto(address)).toList() : null,
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
    );
  }
}

class DiscordUserInfo {
  final String? username;

  DiscordUserInfo({this.username});

  static DiscordUserInfo fromDto(DiscordUserInfoDto dto) {
    return DiscordUserInfo(username: dto.username);
  }
}

class ShopifyUserInfo {
  final String? shopName;

  ShopifyUserInfo({this.shopName});

  static ShopifyUserInfo fromDto(ShopifyUserInfoDto dto) {
    return ShopifyUserInfo(shopName: dto.shopName);
  }
}

class GoogleUserInfo {
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
  final String? id;
  final String? displayName;
  final String? logoUrl;
  final String? name;

  TwitchUserInfo({this.id, this.displayName, this.logoUrl, this.name});

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
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;

  ZoomUserInfo({this.id, this.firstName, this.lastName, this.email});

  static ZoomUserInfo fromDto(ZoomUserInfoDto dto) {
    return ZoomUserInfo(
      id: dto.id,
      firstName: dto.firstName,
      lastName: dto.lastName,
      email: dto.email,
    );
  }
}
