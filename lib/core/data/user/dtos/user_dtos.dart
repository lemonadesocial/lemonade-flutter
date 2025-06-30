import 'package:app/core/data/common/dtos/common_dtos.dart';
import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/data/payment/dtos/stripe_connected_account_dto/stripe_connected_account_dto.dart';
import 'package:app/core/data/user/dtos/user_expertise_dto/user_expertise_dto.dart';
import 'package:app/core/data/user/dtos/user_farcaster_info_dto/user_farcaster_info_dto.dart';
import 'package:app/core/data/user/dtos/user_service_offer_dto/user_service_offer_dto.dart';
import 'package:app/core/data/user/dtos/user_icebreaker_dto/user_icebreaker_dto.dart';
import 'package:app/core/data/user/user_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dtos.freezed.dart';
part 'user_dtos.g.dart';

@freezed
class UserDto with _$UserDto {
  @JsonSerializable(explicitToJson: true)
  const factory UserDto({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'created_at', includeIfNull: false) DateTime? createdAt,
    @JsonKey(name: 'display_name', includeIfNull: false) String? displayName,
    @JsonKey(name: 'first_name', includeIfNull: false) String? firstName,
    @JsonKey(name: 'last_name', includeIfNull: false) String? lastName,
    @JsonKey(name: 'image_avatar', includeIfNull: false) String? imageAvatar,
    @JsonKey(name: 'new_photos_expanded', includeIfNull: false)
    List<DbFileDto?>? newPhotosExpanded,
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
    @JsonKey(name: 'handle_github') String? handleGithub,
    @JsonKey(name: 'handle_mirror') String? handleMirror,
    @JsonKey(name: 'handle_farcaster') String? handleFarcaster,
    @JsonKey(name: 'handle_lens') String? handleLens,
    @JsonKey(name: 'calendly_url') String? calendlyUrl,
    String? website,
    List<String>? wallets,
    @JsonKey(name: 'wallet_custodial') String? walletCustodial,
    String? name,
    String? username,
    String? phone,
    String? email,
    String? pronoun,
    String? description,
    bool? active,
    String? cover,
    UserType? type,
    String? industry,
    List<AddressDto>? addresses,
    double? hosted,
    double? attended,
    int? friends,
    int? following,
    int? followers,
    @JsonKey(name: 'job_title') String? jobTitle,
    String? tagline,
    String? currency,
    @JsonKey(name: 'new_gender') String? newGender,
    String? ethnicity,
    @JsonKey(name: 'company_name') String? companyName,
    @JsonKey(name: 'education_title') String? educationTitle,
    @Default([])
    @JsonKey(name: 'notification_filters')
    List<NotificationFilterDto> notificationFilter,
    @Default([]) List<String> blocked,
    @Default([])
    @JsonKey(name: 'blocked_expanded')
    List<UserDto> blockedExpanded,
    @JsonKey(name: 'terms_accepted_adult') bool? termsAcceptedAdult,
    @JsonKey(name: 'terms_accepted_conditions') bool? termsAcceptedConditions,
    @JsonKey(name: 'matrix_localpart') String? matrixLocalpart,
    @JsonKey(name: 'service_offers') List<String>? serviceOffers,
    @JsonKey(name: 'expertise') List<String>? expertise,
    @JsonKey(name: 'events_expanded') List<EventDto>? eventsExpanded,
    @JsonKey(name: 'service_offers_expanded')
    List<UserServiceOfferDto>? serviceOffersExpanded,
    @JsonKey(name: 'expertise_expanded')
    List<UserExpertiseDto>? expertiseExpanded,
    List<UserIcebreakerDto>? icebreakers,
    @JsonKey(name: 'farcaster_user_info')
    UserFarcasterInfoDto? farcasterUserInfo,
    double? age,
    @JsonKey(name: 'location_line') String? locationLine,
    @JsonKey(name: 'quest_points') int? questPoints,
    @JsonKey(name: 'stripe_connected_account')
    StripeConnectedAccountDto? stripeConnectedAccount,
    @JsonKey(name: 'wallets_new') Map<String, List<String>?>? walletsNew,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

@freezed
class DiscordUserInfoDto with _$DiscordUserInfoDto {
  @JsonSerializable(explicitToJson: true)
  const factory DiscordUserInfoDto({
    String? username,
  }) = _DiscordUserInfoDto;

  factory DiscordUserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$DiscordUserInfoDtoFromJson(json);
}

@freezed
class ShopifyUserInfoDto with _$ShopifyUserInfoDto {
  @JsonSerializable(explicitToJson: true)
  const factory ShopifyUserInfoDto({
    @JsonKey(name: 'shop_name', includeIfNull: false) String? shopName,
  }) = _ShopifyUserInfoDto;

  factory ShopifyUserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$ShopifyUserInfoDtoFromJson(json);
}

@freezed
class GoogleUserInfoDto with _$GoogleUserInfoDto {
  @JsonSerializable(explicitToJson: true)
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
  @JsonSerializable(explicitToJson: true)
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

@freezed
class NotificationFilterDto with _$NotificationFilterDto {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory NotificationFilterDto({
    required String type,
    String? refType,
    String? refId,
  }) = _NotificationFilterDto;

  factory NotificationFilterDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationFilterDtoFromJson(json);
}
