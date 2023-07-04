import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/data/user/user_enums.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/payment/payment_enums.dart';

class AuthUser {
  String id;

  AuthUser({
    required this.id,
  });

  factory AuthUser.fromDto(UserDto dto) {
    return AuthUser(id: dto.id!);
  }
}

class User {
  String? id;
  DateTime? createdAt;
  String? displayName;
  String? firstName;
  String? lastName;
  String? imageAvatar;
  List<DbFile>? newPhotosExpanded;
  DateTime? dateOfBirth;
  bool? phoneVerified;
  GoogleUserInfo? googleUserInfo;
  DiscordUserInfo? discordUserInfo;
  ShopifyUserInfo? shopifyUserInfo;
  TwitchUserInfo? twitchUserInfo;
  ZoomUserInfo? zoomUserInfo;
  String? name;
  String? username;
  String? phone;
  String? email;
  String? description;
  bool? active;
  String? cover;
  UserType? type;
  String? industry;
  List<Address>? addresses;
  int? hosted;
  int? attended;
  int? friends;
  int? following;
  int? followers;
  Currency? currency;

  String? jobTitle;
  String? tagline;

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
