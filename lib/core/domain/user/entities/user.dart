import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/collaborator/entities/user_expertise/user_expertise.dart';
import 'package:app/core/domain/user/entities/user_farcaster_info.dart';
import 'package:app/core/domain/user/entities/user_service_offer.dart';
import 'package:app/core/domain/user/entities/user_icebreaker.dart';
import 'package:app/core/data/user/user_enums.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

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

@freezed
class User with _$User {
  User._();

  @JsonSerializable(explicitToJson: true)
  factory User({
    required String userId,
    DateTime? createdAt,
    String? displayName,
    String? firstName,
    String? lastName,
    String? imageAvatar,
    List<DbFile>? newPhotosExpanded,
    DateTime? dateOfBirth,
    bool? phoneVerified,
    GoogleUserInfo? googleUserInfo,
    DiscordUserInfo? discordUserInfo,
    ShopifyUserInfo? shopifyUserInfo,
    TwitchUserInfo? twitchUserInfo,
    ZoomUserInfo? zoomUserInfo,
    String? name,
    String? username,
    String? phone,
    String? email,
    String? pronoun,
    String? description,
    bool? active,
    String? cover,
    UserType? type,
    List<Address>? addresses,
    double? hosted,
    double? attended,
    int? friends,
    int? following,
    int? followers,
    String? currency,
    String? jobTitle,
    String? companyName,
    String? tagline,
    String? industry,
    String? educationTitle,
    String? ethnicity,
    String? newGender,
    String? handleTwitter,
    String? handleInstagram,
    String? handleFacebook,
    String? handleLinkedin,
    String? handleGithub,
    String? handleMirror,
    String? handleFarcaster,
    String? handleLens,
    String? calendlyUrl,
    List<String>? wallets,
    String? walletCustodial,
    List<String>? notificationFilterList,
    List<User>? blockedList,
    bool? termsAcceptedAdult,
    bool? termsAcceptedConditions,
    String? matrixLocalpart,
    List<String>? serviceOffers,
    List<String>? expertise,
    List<Event>? eventsExpanded,
    List<UserServiceOffer>? serviceOffersExpanded,
    List<UserExpertise>? expertiseExpanded,
    List<UserIcebreaker>? icebreakers,
    UserFarcasterInfo? farcasterUserInfo,
    String? locationLine,
    double? age,
    int? questPoints,
  }) = _User;

  factory User.fromDto(UserDto dto) {
    return User(
        userId: dto.id ?? '',
        createdAt: dto.createdAt,
        displayName: dto.displayName,
        firstName: dto.firstName,
        lastName: dto.lastName,
        imageAvatar: dto.imageAvatar,
        newPhotosExpanded: (dto.newPhotosExpanded ?? [])
            .where((item) => item != null)
            .map(
              (item) => DbFile.fromDto(item!),
            )
            .toList(),
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
        pronoun: dto.pronoun,
        description: dto.description,
        active: dto.active,
        cover: dto.cover,
        type: dto.type,
        industry: dto.industry,
        addresses: dto.addresses?.map(Address.fromDto).toList(),
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
        handleGithub: dto.handleGithub,
        handleMirror: dto.handleMirror,
        handleFarcaster: dto.handleFarcaster,
        handleLens: dto.handleLens,
        calendlyUrl: dto.calendlyUrl,
        wallets: dto.wallets,
        walletCustodial: dto.walletCustodial,
        newGender: dto.newGender,
        companyName: dto.companyName,
        educationTitle: dto.educationTitle,
        ethnicity: dto.ethnicity,
        notificationFilterList:
            dto.notificationFilter.map((e) => e.type).toList(),
        blockedList: dto.blockedExpanded.map((e) => User.fromDto(e)).toList(),
        termsAcceptedAdult: dto.termsAcceptedAdult,
        termsAcceptedConditions: dto.termsAcceptedConditions,
        matrixLocalpart: dto.matrixLocalpart,
        serviceOffers: dto.serviceOffers,
        expertise: dto.expertise,
        eventsExpanded: List.from(dto.eventsExpanded ?? [])
            .map(
              (item) => Event.fromDto(item),
            )
            .toList(),
        expertiseExpanded: List.from(dto.expertiseExpanded ?? [])
            .map(
              (item) => UserExpertise.fromDto(item),
            )
            .toList(),
        serviceOffersExpanded: List.from(dto.serviceOffersExpanded ?? [])
            .map(
              (item) => UserServiceOffer.fromDto(item),
            )
            .toList(),
        icebreakers: List.from(dto.icebreakers ?? [])
            .map(
              (item) => UserIcebreaker.fromDto(item),
            )
            .toList(),
        farcasterUserInfo: dto.farcasterUserInfo != null
            ? UserFarcasterInfo.fromDto(dto.farcasterUserInfo!)
            : null,
        age: dto.age,
        locationLine: dto.locationLine,
        questPoints: dto.questPoints);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class DiscordUserInfo with _$DiscordUserInfo {
  DiscordUserInfo._();

  factory DiscordUserInfo({
    String? username,
  }) = _DiscordUserInfo;

  factory DiscordUserInfo.fromDto(DiscordUserInfoDto dto) =>
      DiscordUserInfo(username: dto.username);

  factory DiscordUserInfo.fromJson(Map<String, dynamic> json) =>
      _$DiscordUserInfoFromJson(json);
}

@freezed
class ShopifyUserInfo with _$ShopifyUserInfo {
  ShopifyUserInfo._();

  factory ShopifyUserInfo({
    String? shopName,
  }) = _ShopifyUserInfo;

  factory ShopifyUserInfo.fromDto(ShopifyUserInfoDto dto) =>
      ShopifyUserInfo(shopName: dto.shopName);

  factory ShopifyUserInfo.fromJson(Map<String, dynamic> json) =>
      _$ShopifyUserInfoFromJson(json);
}

@freezed
class GoogleUserInfo with _$GoogleUserInfo {
  GoogleUserInfo._();

  factory GoogleUserInfo({
    String? id,
    String? name,
    String? email,
    String? familyName,
    String? gender,
    String? givenName,
    String? hd,
    String? link,
    String? locale,
    String? picture,
    String? verifiedEmail,
  }) = _GoogleUserInfo;

  factory GoogleUserInfo.fromDto(GoogleUserInfoDto dto) => GoogleUserInfo(
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

  factory GoogleUserInfo.fromJson(Map<String, dynamic> json) =>
      _$GoogleUserInfoFromJson(json);
}

@freezed
class TwitchUserInfo with _$TwitchUserInfo {
  TwitchUserInfo._();

  factory TwitchUserInfo({
    String? id,
    String? displayName,
    String? logoUrl,
    String? name,
  }) = _TwitchUserInfo;

  factory TwitchUserInfo.fromDto(TwitchUserInfoDto dto) => TwitchUserInfo(
        id: dto.id,
        displayName: dto.displayName,
        logoUrl: dto.logoUrl,
        name: dto.name,
      );

  factory TwitchUserInfo.fromJson(Map<String, dynamic> json) =>
      _$TwitchUserInfoFromJson(json);
}

@freezed
class ZoomUserInfo with _$ZoomUserInfo {
  ZoomUserInfo._();

  factory ZoomUserInfo({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
  }) = _ZoomUserInfo;

  factory ZoomUserInfo.fromDto(ZoomUserInfoDto dto) => ZoomUserInfo(
        id: dto.id,
        firstName: dto.firstName,
        lastName: dto.lastName,
        email: dto.email,
      );

  factory ZoomUserInfo.fromJson(Map<String, dynamic> json) =>
      _$ZoomUserInfoFromJson(json);
}
