import 'package:app/core/data/common/dtos/common_dtos.dart';
import 'package:app/core/data/user/user_enums.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_dtos.freezed.dart';
part 'user_dtos.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'created_at', includeIfNull: false) DateTime? createdAt,
    @JsonKey(name: 'user_name', includeIfNull: false) String? userName,
    @JsonKey(name: 'display_name', includeIfNull: false) String? displayName,
    @JsonKey(name: 'first_name', includeIfNull: false) String? firstName,
    @JsonKey(name: 'last_name', includeIfNull: false) String? lastName,
    @JsonKey(name: 'image_avatar', includeIfNull: false) String? imageAvatar,
    @JsonKey(name: 'new_photos_expanded', includeIfNull: false)
    List<DbFileDto>? newPhotosExpanded,
    @JsonKey(name: 'date_of_birth', includeIfNull: false) DateTime? dateOfBirth,
    @JsonKey(name: 'phone_verified', includeIfNull: false) bool? phoneVerified,
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
    @JsonKey(name: 'handle_twitter') String? handleTwitter,
    @JsonKey(name: 'handle_instagram') String? handleInstagram,
    @JsonKey(name: 'handle_facebook') String? handleFacebook,
    @JsonKey(name: 'handle_linkedin') String? handleLinkedin,
    List<String>? wallets,
    @JsonKey(name: 'wallet_custodial') String? walletCustodial,
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
    @JsonKey(name: 'job_title') String? jobTitle,
    String? tagline,
    Currency? currency,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

@freezed
class DiscordUserInfoDto with _$DiscordUserInfoDto {
  const factory DiscordUserInfoDto({
    String? username,
  }) = _DiscordUserInfoDto;

  factory DiscordUserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$DiscordUserInfoDtoFromJson(json);
}

@freezed
class ShopifyUserInfoDto with _$ShopifyUserInfoDto {
  const factory ShopifyUserInfoDto({
    @JsonKey(name: 'shop_name', includeIfNull: false) String? shopName,
  }) = _ShopifyUserInfoDto;

  factory ShopifyUserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$ShopifyUserInfoDtoFromJson(json);
}

@freezed
class GoogleUserInfoDto with _$GoogleUserInfoDto {
  const factory GoogleUserInfoDto({
    String? id,
    String? name,
    String? email,
    @JsonKey(name: 'family_age', includeIfNull: false) String? familyName,
    String? gender,
    @JsonKey(name: 'given_name', includeIfNull: false) String? givenName,
    String? hd,
    String? link,
    String? locale,
    String? picture,
    @JsonKey(name: 'verified_email', includeIfNull: false)
    String? verifiedEmail,
  }) = _GoogleUserInfoDto;

  factory GoogleUserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$GoogleUserInfoDtoFromJson(json);
}

@freezed
class TwitchUserInfoDto with _$TwitchUserInfoDto {
  const factory TwitchUserInfoDto({
    String? id,
    @JsonKey(name: 'display_name', includeIfNull: false) String? displayName,
    @JsonKey(name: 'logo_url', includeIfNull: false) String? logoUrl,
    String? name,
  }) = _TwitchUserInfoDto;

  factory TwitchUserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$TwitchUserInfoDtoFromJson(json);
}

@freezed
class ZoomUserInfoDto with _$ZoomUserInfoDto {
  const factory ZoomUserInfoDto({
    String? id,
    @JsonKey(name: 'first_name', includeIfNull: false) String? firstName,
    @JsonKey(name: 'last_name', includeIfNull: false) String? lastName,
    String? email,
  }) = _ZoomUserInfoDto;

  factory ZoomUserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$ZoomUserInfoDtoFromJson(json);
}
