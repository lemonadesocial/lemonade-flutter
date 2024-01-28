import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'app_models.freezed.dart';
part 'app_models.g.dart';

@Freezed(
  copyWith: true,
  equal: true,
)
class AcceptEventTermsInput with _$AcceptEventTermsInput {
  const AcceptEventTermsInput._();

  const factory AcceptEventTermsInput({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'email_permission') bool? emailPermission,
  }) = _AcceptEventTermsInput;

  factory AcceptEventTermsInput.fromJson(Map<String, dynamic> json) =>
      _$AcceptEventTermsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class AcceptUserDiscoveryResponse with _$AcceptUserDiscoveryResponse {
  const AcceptUserDiscoveryResponse._();

  const factory AcceptUserDiscoveryResponse({
    UserDiscoverySwipeState? state,
    User? user,
  }) = _AcceptUserDiscoveryResponse;

  factory AcceptUserDiscoveryResponse.fromJson(Map<String, dynamic> json) =>
      _$AcceptUserDiscoveryResponseFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class AccessPass with _$AccessPass {
  const AccessPass._();

  const factory AccessPass({
    required String base,
    @JsonKey(name: 'card_description') required String cardDescription,
    @JsonKey(name: 'card_image_url') required String cardImageUrl,
    @JsonKey(name: 'card_logo_url') required String cardLogoUrl,
    bool? checkin,
    required String contract,
    @JsonKey(name: 'dialog_background_url') required String dialogBackgroundUrl,
    @JsonKey(name: 'dialog_description') required String dialogDescription,
    @JsonKey(name: 'dialog_title') required String dialogTitle,
    @JsonKey(name: 'discord_url') String? discordUrl,
    required String frame,
    @JsonKey(name: 'gallery_logo_url') required String galleryLogoUrl,
    @JsonKey(name: 'info_url') required String infoUrl,
    @JsonKey(name: 'instagram_url') String? instagramUrl,
    @JsonKey(name: 'logo_url') required String logoUrl,
    @JsonKey(name: 'metadata_creators') required List<String> metadataCreators,
    @JsonKey(name: 'metadata_description') required String metadataDescription,
    @JsonKey(name: 'metadata_name') required String metadataName,
    required String name,
    required String network,
    @JsonKey(name: 'twitter_url') String? twitterUrl,
    @JsonKey(name: 'unlocked_description') String? unlockedDescription,
  }) = _AccessPass;

  factory AccessPass.fromJson(Map<String, dynamic> json) =>
      _$AccessPassFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class AccessPassInput with _$AccessPassInput {
  const AccessPassInput._();

  const factory AccessPassInput({
    required String base,
    @JsonKey(name: 'card_description') required String cardDescription,
    @JsonKey(name: 'card_image_url') required String cardImageUrl,
    @JsonKey(name: 'card_logo_url') required String cardLogoUrl,
    bool? checkin,
    required String contract,
    @JsonKey(name: 'dialog_background_url') required String dialogBackgroundUrl,
    @JsonKey(name: 'dialog_description') required String dialogDescription,
    @JsonKey(name: 'dialog_title') required String dialogTitle,
    @JsonKey(name: 'discord_url') String? discordUrl,
    required String frame,
    @JsonKey(name: 'gallery_logo_url') required String galleryLogoUrl,
    @JsonKey(name: 'info_url') required String infoUrl,
    @JsonKey(name: 'instagram_url') String? instagramUrl,
    @JsonKey(name: 'logo_url') required String logoUrl,
    @JsonKey(name: 'metadata_creators') required List<String> metadataCreators,
    @JsonKey(name: 'metadata_description') required String metadataDescription,
    @JsonKey(name: 'metadata_name') required String metadataName,
    required String name,
    required String network,
    @JsonKey(name: 'twitter_url') String? twitterUrl,
    @JsonKey(name: 'unlocked_description') String? unlockedDescription,
  }) = _AccessPassInput;

  factory AccessPassInput.fromJson(Map<String, dynamic> json) =>
      _$AccessPassInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class AccountInfo with _$AccountInfo {
  const AccountInfo._();

  const factory AccountInfo.digitalAccount({
    @JsonKey(name: 'account_id') required String accountId,
    required List<String> currencies,
    @JsonKey(name: 'currency_map') Map<String, dynamic>? currencyMap,
  }) = DigitalAccount;

  const factory AccountInfo.ethereumAccount({
    required String address,
    required List<String> currencies,
    @JsonKey(name: 'currency_map') Map<String, dynamic>? currencyMap,
    required List<String> networks,
  }) = EthereumAccount;

  const factory AccountInfo.safeAccount({
    required String address,
    required List<String> currencies,
    @JsonKey(name: 'currency_map') Map<String, dynamic>? currencyMap,
    @JsonKey(name: 'gelato_task_id') String? gelatoTaskId,
    required String network,
    required List<String> owners,
    bool? pending,
    required double threshold,
  }) = SafeAccount;

  const factory AccountInfo.stripeAccount({
    @JsonKey(name: 'account_id') required String accountId,
    required List<String> currencies,
    @JsonKey(name: 'currency_map') Map<String, dynamic>? currencyMap,
    @JsonKey(name: 'publishable_key') required String publishableKey,
  }) = StripeAccount;

  factory AccountInfo.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Address with _$Address {
  const Address._();

  const factory Address({
    @JsonKey(name: '_id') String? id,
    String? city,
    String? country,
    double? latitude,
    double? longitude,
    String? phone,
    String? postal,
    @JsonKey(name: 'recipient_name') String? recipientName,
    String? region,
    String? street_1,
    String? street_2,
    String? title,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class AddressInput with _$AddressInput {
  const AddressInput._();

  const factory AddressInput({
    @JsonKey(name: '_id') String? id,
    String? city,
    String? country,
    double? latitude,
    double? longitude,
    String? phone,
    String? postal,
    @JsonKey(name: 'recipient_name') String? recipientName,
    String? region,
    String? street_1,
    String? street_2,
    String? title,
  }) = _AddressInput;

  factory AddressInput.fromJson(Map<String, dynamic> json) =>
      _$AddressInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class ApproveUserJoinRequestsInput with _$ApproveUserJoinRequestsInput {
  const ApproveUserJoinRequestsInput._();

  const factory ApproveUserJoinRequestsInput({
    required String event,
    required List<String> requests,
  }) = _ApproveUserJoinRequestsInput;

  factory ApproveUserJoinRequestsInput.fromJson(Map<String, dynamic> json) =>
      _$ApproveUserJoinRequestsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class AssignTicketsInput with _$AssignTicketsInput {
  const AssignTicketsInput._();

  const factory AssignTicketsInput({
    required List<TicketAssignee> assignees,
    required String event,
  }) = _AssignTicketsInput;

  factory AssignTicketsInput.fromJson(Map<String, dynamic> json) =>
      _$AssignTicketsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Badge with _$Badge {
  const Badge._();

  const factory Badge({
    @JsonKey(name: '_id') required String id,
    String? city,
    bool? claimable,
    required String contract,
    String? country,

    /// Distance in meters
    double? distance,
    required String list,
    @JsonKey(name: 'list_expanded') BadgeList? listExpanded,
    required String network,
  }) = _Badge;

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class BadgeCity with _$BadgeCity {
  const BadgeCity._();

  const factory BadgeCity({
    required String city,
    required String country,
  }) = _BadgeCity;

  factory BadgeCity.fromJson(Map<String, dynamic> json) =>
      _$BadgeCityFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class BadgeList with _$BadgeList {
  const BadgeList._();

  const factory BadgeList({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'image_url') String? imageUrl,
    required String title,
    required String user,
    @JsonKey(name: 'user_expanded') User? userExpanded,
  }) = _BadgeList;

  factory BadgeList.fromJson(Map<String, dynamic> json) =>
      _$BadgeListFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class BillingInfo with _$BillingInfo {
  const BillingInfo._();

  const factory BillingInfo({
    @JsonKey(name: '_id') String? id,
    String? city,
    String? country,
    String? email,
    String? firstname,
    String? lastname,
    double? latitude,
    double? longitude,
    String? phone,
    String? postal,
    @JsonKey(name: 'recipient_name') String? recipientName,
    String? region,
    String? street_1,
    String? street_2,
    String? title,
  }) = _BillingInfo;

  factory BillingInfo.fromJson(Map<String, dynamic> json) =>
      _$BillingInfoFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class BillingInfoInput with _$BillingInfoInput {
  const BillingInfoInput._();

  const factory BillingInfoInput({
    @JsonKey(name: '_id') String? id,
    String? city,
    String? country,
    String? email,
    String? firstname,
    String? lastname,
    double? latitude,
    double? longitude,
    String? phone,
    String? postal,
    @JsonKey(name: 'recipient_name') String? recipientName,
    String? region,
    String? street_1,
    String? street_2,
    String? title,
  }) = _BillingInfoInput;

  factory BillingInfoInput.fromJson(Map<String, dynamic> json) =>
      _$BillingInfoInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Broadcast with _$Broadcast {
  const Broadcast._();

  const factory Broadcast({
    @JsonKey(name: '_id') String? id,
    required bool active,
    @JsonKey(name: 'deactivation_code') String? deactivationCode,
    @JsonKey(name: 'deactivation_message') String? deactivationMessage,
    String? description,
    required bool eligible,
    @JsonKey(name: 'end_time') DateTime? endTime,
    @JsonKey(name: 'life_cycle_status')
    required BroadcastLifeCycleStatus lifeCycleStatus,
    @JsonKey(name: 'meta_data') BroadcastMetaData? metaData,
    double? position,
    @JsonKey(name: 'processed_by_job') bool? processedByJob,
    required BroadcastProvider provider,
    @JsonKey(name: 'provider_id') required String providerId,
    @JsonKey(name: 'recording_status')
    required BroadcastRecordingStatus recordingStatus,
    List<String>? rooms,
    @JsonKey(name: 'scheduled_end_time') DateTime? scheduledEndTime,
    @JsonKey(name: 'scheduled_start_time') DateTime? scheduledStartTime,
    @JsonKey(name: 'start_time') DateTime? startTime,
    String? thumbnail,
    required String title,
    required String user,
    @JsonKey(name: 'user_expanded') User? userExpanded,
  }) = _Broadcast;

  factory Broadcast.fromJson(Map<String, dynamic> json) =>
      _$BroadcastFromJson(json);
}

enum BroadcastLifeCycleStatus {
  complete,
  created,
  live,
  liveStarting,
  ready,
  revoked,
  testStarting,
  testing,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class BroadcastMetaData with _$BroadcastMetaData {
  const BroadcastMetaData._();

  const factory BroadcastMetaData({
    String? boundStreamId,
    DateTime? boundStreamStamp,
    bool? enableAutoStop,
    String? password,
    @JsonKey(name: 'static_thumbnail') String? staticThumbnail,
    String? title,
    String? user,
    String? video,
  }) = _BroadcastMetaData;

  factory BroadcastMetaData.fromJson(Map<String, dynamic> json) =>
      _$BroadcastMetaDataFromJson(json);
}

enum BroadcastProvider {
  embed,
  local,
  twitch,
  video,
  youtube,
  zoom,
}

enum BroadcastRecordingStatus {
  notRecording,
  recorded,
  recording,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class BroadcastRoom with _$BroadcastRoom {
  const BroadcastRoom._();

  const factory BroadcastRoom({
    @JsonKey(name: '_id') String? id,
    String? description,
    @JsonKey(name: 'event_payment_ticket_types')
    List<String>? eventPaymentTicketTypes,
    @JsonKey(name: 'iframe_src') String? iframeSrc,
    List<String>? photos,
    @JsonKey(name: 'photos_expanded') List<File?>? photosExpanded,
    double? position,
    String? title,
  }) = _BroadcastRoom;

  factory BroadcastRoom.fromJson(Map<String, dynamic> json) =>
      _$BroadcastRoomFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class BroadcastRoomInput with _$BroadcastRoomInput {
  const BroadcastRoomInput._();

  const factory BroadcastRoomInput({
    @JsonKey(name: '_id') String? id,
    String? description,
    @JsonKey(name: 'event_payment_ticket_types')
    List<String>? eventPaymentTicketTypes,
    @JsonKey(name: 'iframe_src') String? iframeSrc,
    List<String>? photos,
    double? position,
    String? title,
  }) = _BroadcastRoomInput;

  factory BroadcastRoomInput.fromJson(Map<String, dynamic> json) =>
      _$BroadcastRoomInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class BuyTicketsInput with _$BuyTicketsInput {
  const BuyTicketsInput._();

  const factory BuyTicketsInput({
    @JsonKey(name: 'account_id') required String accountId,
    @JsonKey(name: 'billing_info') BillingInfoInput? billingInfo,
    required String currency,
    String? discount,
    required String event,
    required List<PurchasableItem> items,
    String? network,
    required String total,
    @JsonKey(name: 'transfer_params') Map<String, dynamic>? transferParams,
  }) = _BuyTicketsInput;

  factory BuyTicketsInput.fromJson(Map<String, dynamic> json) =>
      _$BuyTicketsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class BuyTicketsResponse with _$BuyTicketsResponse {
  const BuyTicketsResponse._();

  const factory BuyTicketsResponse({
    @JsonKey(name: 'event_join_request') EventJoinRequest? eventJoinRequest,
    NewPayment? payment,
  }) = _BuyTicketsResponse;

  factory BuyTicketsResponse.fromJson(Map<String, dynamic> json) =>
      _$BuyTicketsResponseFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class CalculateTicketsPricingInput with _$CalculateTicketsPricingInput {
  const CalculateTicketsPricingInput._();

  const factory CalculateTicketsPricingInput({
    required String currency,
    String? discount,
    required String event,
    required List<PurchasableItem> items,
    String? network,
  }) = _CalculateTicketsPricingInput;

  factory CalculateTicketsPricingInput.fromJson(Map<String, dynamic> json) =>
      _$CalculateTicketsPricingInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Chain with _$Chain {
  const Chain._();

  const factory Chain({
    bool? active,
    @JsonKey(name: 'chain_id') required String chainId,
    @JsonKey(name: 'logo_url') String? logoUrl,
    required String name,
    @JsonKey(name: 'rpc_url') required String rpcUrl,
    List<Token>? tokens,
  }) = _Chain;

  factory Chain.fromJson(Map<String, dynamic> json) => _$ChainFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Comment with _$Comment {
  const Comment._();

  const factory Comment({
    @JsonKey(name: '_id') required String id,
    String? comment,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required String post,
    required String text,
    required String user,
    @JsonKey(name: 'user_expanded') User? userExpanded,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class CommentInput with _$CommentInput {
  const CommentInput._();

  const factory CommentInput({
    String? comment,
    required String post,
    required String text,
  }) = _CommentInput;

  factory CommentInput.fromJson(Map<String, dynamic> json) =>
      _$CommentInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class CreateBadgeInput with _$CreateBadgeInput {
  const CreateBadgeInput._();

  const factory CreateBadgeInput({
    required String contract,
    required String list,
    required String network,
  }) = _CreateBadgeInput;

  factory CreateBadgeInput.fromJson(Map<String, dynamic> json) =>
      _$CreateBadgeInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class CreateBadgeListInput with _$CreateBadgeListInput {
  const CreateBadgeListInput._();

  const factory CreateBadgeListInput({
    @JsonKey(name: 'image_url') String? imageUrl,
    required String title,
  }) = _CreateBadgeListInput;

  factory CreateBadgeListInput.fromJson(Map<String, dynamic> json) =>
      _$CreateBadgeListInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class CreateEventBroadcastInput with _$CreateEventBroadcastInput {
  const CreateEventBroadcastInput._();

  const factory CreateEventBroadcastInput({
    String? description,
    double? position,
    required BroadcastProvider provider,
    @JsonKey(name: 'provider_id') required String providerId,
    List<String>? rooms,
    @JsonKey(name: 'scheduled_end_time') DateTime? scheduledEndTime,
    @JsonKey(name: 'scheduled_start_time') DateTime? scheduledStartTime,
    String? thumbnail,
    required String title,
  }) = _CreateEventBroadcastInput;

  factory CreateEventBroadcastInput.fromJson(Map<String, dynamic> json) =>
      _$CreateEventBroadcastInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class CreateEventFromEventbriteInput with _$CreateEventFromEventbriteInput {
  const CreateEventFromEventbriteInput._();

  const factory CreateEventFromEventbriteInput({
    String? description,
    DateTime? end,
    DateTime? start,
    String? title,
  }) = _CreateEventFromEventbriteInput;

  factory CreateEventFromEventbriteInput.fromJson(Map<String, dynamic> json) =>
      _$CreateEventFromEventbriteInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class CreateEventQuestionsInput with _$CreateEventQuestionsInput {
  const CreateEventQuestionsInput._();

  const factory CreateEventQuestionsInput({
    required String event,
    required String question,
    String? session,
  }) = _CreateEventQuestionsInput;

  factory CreateEventQuestionsInput.fromJson(Map<String, dynamic> json) =>
      _$CreateEventQuestionsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class CreateNewPaymentAccountInput with _$CreateNewPaymentAccountInput {
  const CreateNewPaymentAccountInput._();

  const factory CreateNewPaymentAccountInput({
    @JsonKey(name: 'account_info') Map<String, dynamic>? accountInfo,
    NewPaymentProvider? provider,
    String? title,
    required PaymentAccountType type,
  }) = _CreateNewPaymentAccountInput;

  factory CreateNewPaymentAccountInput.fromJson(Map<String, dynamic> json) =>
      _$CreateNewPaymentAccountInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class CreateSiteInput with _$CreateSiteInput {
  const CreateSiteInput._();

  const factory CreateSiteInput({
    @JsonKey(name: 'access_pass') AccessPassInput? accessPass,
    @JsonKey(name: 'ai_config') String? aiConfig,
    required String client,
    required String description,
    String? event,
    @JsonKey(name: 'favicon_url') String? faviconUrl,
    @JsonKey(name: 'footer_scripts') List<SiteFooterScriptInput>? footerScripts,
    @JsonKey(name: 'header_links') List<SiteHeaderLinkInput>? headerLinks,
    @JsonKey(name: 'header_metas') List<SiteHeaderMetaInput>? headerMetas,
    List<String>? hostnames,
    @JsonKey(name: 'logo_mobile_url') String? logoMobileUrl,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'onboarding_steps')
    List<SiteOnboardingStepInput>? onboardingSteps,
    List<String>? owners,
    List<String>? partners,
    @JsonKey(name: 'privacy_url') String? privacyUrl,
    @JsonKey(name: 'share_url') Map<String, dynamic>? shareUrl,
    Map<String, dynamic>? text,
    @JsonKey(name: 'theme_data') Map<String, dynamic>? themeData,
    @JsonKey(name: 'theme_type') String? themeType,
    required String title,
    Map<String, dynamic>? visibility,
  }) = _CreateSiteInput;

  factory CreateSiteInput.fromJson(Map<String, dynamic> json) =>
      _$CreateSiteInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class CreateStripeOnrampSessionInput with _$CreateStripeOnrampSessionInput {
  const CreateStripeOnrampSessionInput._();

  const factory CreateStripeOnrampSessionInput({
    @JsonKey(name: 'destination_amount') double? destinationAmount,
    @JsonKey(name: 'destination_currency') String? destinationCurrency,
    @JsonKey(name: 'destination_network') String? destinationNetwork,
    @JsonKey(name: 'source_currency') String? sourceCurrency,
    @JsonKey(name: 'wallet_address') String? walletAddress,
  }) = _CreateStripeOnrampSessionInput;

  factory CreateStripeOnrampSessionInput.fromJson(Map<String, dynamic> json) =>
      _$CreateStripeOnrampSessionInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class CreateUserFriendshipInput with _$CreateUserFriendshipInput {
  const CreateUserFriendshipInput._();

  const factory CreateUserFriendshipInput({
    UserFriendshipType? type,
    required String user,
  }) = _CreateUserFriendshipInput;

  factory CreateUserFriendshipInput.fromJson(Map<String, dynamic> json) =>
      _$CreateUserFriendshipInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class DecideEventCohostRequestInput with _$DecideEventCohostRequestInput {
  const DecideEventCohostRequestInput._();

  const factory DecideEventCohostRequestInput({
    required bool decision,
    required String event,
  }) = _DecideEventCohostRequestInput;

  factory DecideEventCohostRequestInput.fromJson(Map<String, dynamic> json) =>
      _$DecideEventCohostRequestInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class DecideRoomAccessRequestInput with _$DecideRoomAccessRequestInput {
  const DecideRoomAccessRequestInput._();

  const factory DecideRoomAccessRequestInput({
    @JsonKey(name: '_id') required String id,
    required bool decision,
    required String user,
  }) = _DecideRoomAccessRequestInput;

  factory DecideRoomAccessRequestInput.fromJson(Map<String, dynamic> json) =>
      _$DecideRoomAccessRequestInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class DecideRoomStageRequestInput with _$DecideRoomStageRequestInput {
  const DecideRoomStageRequestInput._();

  const factory DecideRoomStageRequestInput({
    @JsonKey(name: '_id') required String id,
    required bool decision,
    required String user,
  }) = _DecideRoomStageRequestInput;

  factory DecideRoomStageRequestInput.fromJson(Map<String, dynamic> json) =>
      _$DecideRoomStageRequestInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class DeclineUserJoinRequestsInput with _$DeclineUserJoinRequestsInput {
  const DeclineUserJoinRequestsInput._();

  const factory DeclineUserJoinRequestsInput({
    required String event,
    required List<String> requests,
  }) = _DeclineUserJoinRequestsInput;

  factory DeclineUserJoinRequestsInput.fromJson(Map<String, dynamic> json) =>
      _$DeclineUserJoinRequestsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class DeleteUserFriendshipInput with _$DeleteUserFriendshipInput {
  const DeleteUserFriendshipInput._();

  const factory DeleteUserFriendshipInput({
    required String user,
  }) = _DeleteUserFriendshipInput;

  factory DeleteUserFriendshipInput.fromJson(Map<String, dynamic> json) =>
      _$DeleteUserFriendshipInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class DeliveryOption with _$DeliveryOption {
  const DeliveryOption._();

  const factory DeliveryOption({
    @JsonKey(name: '_id') required String id,
    List<String>? cities,
    required double cost,
    List<String>? countries,
    String? description,
    @JsonKey(name: 'fulfillment_address') String? fulfillmentAddress,
    String? group,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'pickup_addresses') List<String>? pickupAddresses,
    Map<String, dynamic>? polygon,
    @JsonKey(name: 'postal_ranges')
    List<DeliveryOptionPostalRange>? postalRanges,
    List<String>? postals,
    List<String>? regions,
    @JsonKey(name: 'search_range') double? searchRange,
    required String title,
    required DeliveryOptionType type,
    @JsonKey(name: 'waive_type') DeliveryOptionWaiveType? waiveType,
    @JsonKey(name: 'waive_value_threshold') double? waiveValueThreshold,
  }) = _DeliveryOption;

  factory DeliveryOption.fromJson(Map<String, dynamic> json) =>
      _$DeliveryOptionFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class DeliveryOptionInput with _$DeliveryOptionInput {
  const DeliveryOptionInput._();

  const factory DeliveryOptionInput({
    @JsonKey(name: '_id') required String id,
    List<String>? cities,
    required double cost,
    List<String>? countries,
    String? description,
    @JsonKey(name: 'fulfillment_address') String? fulfillmentAddress,
    String? group,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'pickup_addresses') List<String>? pickupAddresses,
    Map<String, dynamic>? polygon,
    @JsonKey(name: 'postal_ranges')
    List<DeliveryOptionPostalRangeInput>? postalRanges,
    List<String>? postals,
    List<String>? regions,
    @JsonKey(name: 'search_range') double? searchRange,
    required String title,
    required DeliveryOptionType type,
    @JsonKey(name: 'waive_type') DeliveryOptionWaiveType? waiveType,
    @JsonKey(name: 'waive_value_threshold') double? waiveValueThreshold,
  }) = _DeliveryOptionInput;

  factory DeliveryOptionInput.fromJson(Map<String, dynamic> json) =>
      _$DeliveryOptionInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class DeliveryOptionPostalRange with _$DeliveryOptionPostalRange {
  const DeliveryOptionPostalRange._();

  const factory DeliveryOptionPostalRange({
    @JsonKey(name: '_id') required String id,
    required double max,
    required double min,
    required String pattern,
  }) = _DeliveryOptionPostalRange;

  factory DeliveryOptionPostalRange.fromJson(Map<String, dynamic> json) =>
      _$DeliveryOptionPostalRangeFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class DeliveryOptionPostalRangeInput with _$DeliveryOptionPostalRangeInput {
  const DeliveryOptionPostalRangeInput._();

  const factory DeliveryOptionPostalRangeInput({
    @JsonKey(name: '_id') required String id,
    required double max,
    required double min,
    required String pattern,
  }) = _DeliveryOptionPostalRangeInput;

  factory DeliveryOptionPostalRangeInput.fromJson(Map<String, dynamic> json) =>
      _$DeliveryOptionPostalRangeInputFromJson(json);
}

enum DeliveryOptionType {
  city,
  country,
  @JsonKey(name: 'geo_zone')
  geoZone,
  postal,
  region,
  worldwide,
}

enum DeliveryOptionWaiveType {
  any,
  product,
  store,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class DigitalAccount with _$DigitalAccount {
  const DigitalAccount._();

  const factory DigitalAccount({
    @JsonKey(name: 'account_id') required String accountId,
    required List<String> currencies,
    @JsonKey(name: 'currency_map') Map<String, dynamic>? currencyMap,
  }) = _DigitalAccount;

  factory DigitalAccount.fromJson(Map<String, dynamic> json) =>
      _$DigitalAccountFromJson(json);
}

enum EasyshipCategory {
  @JsonKey(name: 'accessory_battery')
  accessoryBattery,
  @JsonKey(name: 'accessory_no_battery')
  accessoryNoBattery,
  @JsonKey(name: 'audio_video')
  audioVideo,
  @JsonKey(name: 'books_collectionables')
  booksCollectionables,
  cameras,
  @JsonKey(name: 'computers_laptops')
  computersLaptops,
  documents,
  @JsonKey(name: 'dry_food_supplements')
  dryFoodSupplements,
  fashion,
  gaming,
  @JsonKey(name: 'health_beauty')
  healthBeauty,
  @JsonKey(name: 'home_appliances')
  homeAppliances,
  @JsonKey(name: 'home_decor')
  homeDecor,
  jewelry,
  luggage,
  mobiles,
  @JsonKey(name: 'pet_accessory')
  petAccessory,
  sport,
  tablets,
  toys,
  watches,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EthereumAccount with _$EthereumAccount {
  const EthereumAccount._();

  const factory EthereumAccount({
    required String address,
    required List<String> currencies,
    @JsonKey(name: 'currency_map') Map<String, dynamic>? currencyMap,
    required List<String> networks,
  }) = _EthereumAccount;

  factory EthereumAccount.fromJson(Map<String, dynamic> json) =>
      _$EthereumAccountFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Event with _$Event {
  const Event._();

  const factory Event({
    @JsonKey(name: '_id') String? id,
    List<String>? accepted,
    @JsonKey(name: 'accepted_expanded') List<User?>? acceptedExpanded,
    @JsonKey(name: 'accepted_store_promotion') String? acceptedStorePromotion,
    @JsonKey(name: 'accepted_user_fields_required')
    List<String>? acceptedUserFieldsRequired,
    @JsonKey(name: 'access_pass') AccessPass? accessPass,
    required bool active,
    Address? address,
    @JsonKey(name: 'application_form_url') String? applicationFormUrl,
    bool? approved,
    @JsonKey(name: 'broadcast_rooms') List<BroadcastRoom>? broadcastRooms,
    List<Broadcast>? broadcasts,
    @JsonKey(name: 'button_icon') String? buttonIcon,
    @JsonKey(name: 'button_text') String? buttonText,
    @JsonKey(name: 'button_url') String? buttonUrl,
    List<String>? cohosts,
    @JsonKey(name: 'cohosts_expanded') List<User?>? cohostsExpanded,
    String? comments,
    double? cost,
    String? cover,
    @JsonKey(name: 'cta_button_text') String? ctaButtonText,
    String? currency,
    Map<String, dynamic>? data,
    List<String>? declined,
    @JsonKey(name: 'declined_expanded') List<User?>? declinedExpanded,
    String? description,
    required DateTime end,
    @JsonKey(name: 'event_ticket_types')
    List<EventTicketType>? eventTicketTypes,
    @JsonKey(name: 'eventbrite_enabled') bool? eventbriteEnabled,
    @JsonKey(name: 'eventbrite_event_id') String? eventbriteEventId,
    @JsonKey(name: 'eventbrite_tickets_imported')
    bool? eventbriteTicketsImported,
    List<String>? events,
    @JsonKey(name: 'events_expanded') List<Event?>? eventsExpanded,
    @JsonKey(name: 'frequent_questions')
    List<FrequentQuestion>? frequentQuestions,
    @JsonKey(name: 'guest_limit') double? guestLimit,
    @JsonKey(name: 'guest_limit_per') double? guestLimitPer,
    @JsonKey(name: 'has_terms_accepted') bool? hasTermsAccepted,
    @JsonKey(name: 'hide_chat_action') bool? hideChatAction,
    @JsonKey(name: 'hide_creators') bool? hideCreators,
    @JsonKey(name: 'hide_invite_action') bool? hideInviteAction,
    @JsonKey(name: 'hide_question_box') bool? hideQuestionBox,
    @JsonKey(name: 'hide_rooms_action') bool? hideRoomsAction,
    @JsonKey(name: 'hide_session_guests') bool? hideSessionGuests,
    @JsonKey(name: 'hide_speakers') bool? hideSpeakers,
    @JsonKey(name: 'hide_stories_action') bool? hideStoriesAction,
    bool? highlight,
    required String host,
    @JsonKey(name: 'host_expanded') User? hostExpanded,
    List<String>? invited,
    @JsonKey(name: 'invited_count') double? invitedCount,
    @JsonKey(name: 'invited_expanded') List<User?>? invitedExpanded,
    @JsonKey(name: 'inviter_user_map') Map<String, dynamic>? inviterUserMap,
    List<String>? inviters,
    double? latitude,
    @JsonKey(name: 'layout_sections') List<LayoutSection>? layoutSections,
    Point? location,
    double? longitude,
    @JsonKey(name: 'matrix_event_room_id') String? matrixEventRoomId,
    @JsonKey(name: 'new_new_photos') List<String>? newNewPhotos,
    @JsonKey(name: 'new_new_photos_expanded') List<File?>? newNewPhotosExpanded,
    @JsonKey(name: 'new_photos') List<FileInline>? newPhotos,
    List<EventOffer>? offers,
    @JsonKey(name: 'payment_accounts_expanded')
    List<NewPaymentAccount>? paymentAccountsExpanded,
    @JsonKey(name: 'payment_accounts_new') List<String>? paymentAccountsNew,
    @JsonKey(name: 'payment_donation') bool? paymentDonation,
    @JsonKey(name: 'payment_donation_amount_includes_tickets')
    bool? paymentDonationAmountIncludesTickets,
    @JsonKey(name: 'payment_donation_amount_increment')
    double? paymentDonationAmountIncrement,
    @JsonKey(name: 'payment_donation_message') String? paymentDonationMessage,
    @JsonKey(name: 'payment_donation_target') double? paymentDonationTarget,
    @JsonKey(name: 'payment_enabled') bool? paymentEnabled,
    @JsonKey(name: 'payment_fee') required double paymentFee,
    @JsonKey(name: 'payment_optional') bool? paymentOptional,
    @JsonKey(name: 'payment_ticket_count') double? paymentTicketCount,
    @JsonKey(name: 'payment_ticket_discounts')
    List<EventPaymentTicketDiscount>? paymentTicketDiscounts,
    @JsonKey(name: 'payment_ticket_external_message')
    String? paymentTicketExternalMessage,
    @JsonKey(name: 'payment_ticket_external_url')
    String? paymentTicketExternalUrl,
    @JsonKey(name: 'payment_ticket_purchase_title')
    String? paymentTicketPurchaseTitle,
    @JsonKey(name: 'payment_ticket_unassigned_count')
    double? paymentTicketUnassignedCount,
    List<String>? pending,
    @JsonKey(name: 'pending_expanded') List<User?>? pendingExpanded,
    List<String>? photos,
    bool? private,
    bool? published,
    @JsonKey(name: 'require_approval') bool? requireApproval,
    @JsonKey(name: 'required_profile_fields')
    List<String>? requiredProfileFields,
    @JsonKey(name: 'reward_uses') Map<String, dynamic>? rewardUses,
    List<EventReward>? rewards,
    @JsonKey(name: 'session_guests') Map<String, dynamic>? sessionGuests,
    List<EventSession>? sessions,
    required String shortid,
    required String slug,
    @JsonKey(name: 'speaker_users') List<String>? speakerUsers,
    @JsonKey(name: 'speaker_users_expanded') List<User?>? speakerUsersExpanded,
    required DateTime stamp,
    required DateTime start,
    required EventState state,
    List<String>? stores,
    @JsonKey(name: 'stores_expanded') List<Store?>? storesExpanded,
    List<String>? stories,
    @JsonKey(name: 'stories_eponym') bool? storiesEponym,
    List<String>? tags,
    @JsonKey(name: 'terms_email_permission_text')
    bool? termsEmailPermissionText,
    @JsonKey(name: 'terms_text') String? termsText,
    List<TicketBase>? tickets,
    String? timezone,
    required String title,
    bool? unlisted,
    String? url,
    @JsonKey(name: 'url_go') String? urlGo,
    List<Video>? videos,
    bool? virtual,
    @JsonKey(name: 'welcome_text') String? welcomeText,
    @JsonKey(name: 'welcome_video') Video? welcomeVideo,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventAcceptedExport with _$EventAcceptedExport {
  const EventAcceptedExport._();

  const factory EventAcceptedExport({
    @JsonKey(name: '_id') required String id,
    String? amount,
    @JsonKey(name: 'checkin_date') DateTime? checkinDate,
    String? currency,
    String? email,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    String? name,
    String? phone,
    @JsonKey(name: 'ticket_count') double? ticketCount,
    @JsonKey(name: 'ticket_discount') String? ticketDiscount,
    @JsonKey(name: 'ticket_discount_amount') String? ticketDiscountAmount,
    @JsonKey(name: 'ticket_type') String? ticketType,
    String? username,
  }) = _EventAcceptedExport;

  factory EventAcceptedExport.fromJson(Map<String, dynamic> json) =>
      _$EventAcceptedExportFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventCheckin with _$EventCheckin {
  const EventCheckin._();

  const factory EventCheckin({
    @JsonKey(name: '_id') required String id,
    required bool active,
    required String event,
    required String user,
  }) = _EventCheckin;

  factory EventCheckin.fromJson(Map<String, dynamic> json) =>
      _$EventCheckinFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventCohostRequest with _$EventCohostRequest {
  const EventCohostRequest._();

  const factory EventCohostRequest({
    @JsonKey(name: '_id') required String id,
    required String event,
    required String from,
    @JsonKey(name: 'from_expanded') User? fromExpanded,
    required DateTime stamp,
    required EventCohostRequestState state,
    required String to,
    @JsonKey(name: 'to_expanded') User? toExpanded,
  }) = _EventCohostRequest;

  factory EventCohostRequest.fromJson(Map<String, dynamic> json) =>
      _$EventCohostRequestFromJson(json);
}

enum EventCohostRequestState {
  @JsonKey(name: 'ACCEPTED')
  accepted,
  @JsonKey(name: 'DECLINED')
  declined,
  @JsonKey(name: 'PENDING')
  pending,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventCurrency with _$EventCurrency {
  const EventCurrency._();

  const factory EventCurrency({
    required String currency,
    required double decimals,
    String? network,
  }) = _EventCurrency;

  factory EventCurrency.fromJson(Map<String, dynamic> json) =>
      _$EventCurrencyFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventInput with _$EventInput {
  const EventInput._();

  const factory EventInput({
    @JsonKey(name: 'accepted_store_promotion') String? acceptedStorePromotion,
    @JsonKey(name: 'accepted_user_fields_required')
    List<String>? acceptedUserFieldsRequired,
    @JsonKey(name: 'access_pass') AccessPassInput? accessPass,
    AddressInput? address,
    @JsonKey(name: 'application_form_url') String? applicationFormUrl,
    @JsonKey(name: 'broadcast_rooms') List<BroadcastRoomInput>? broadcastRooms,
    String? comments,
    double? cost,
    String? cover,
    @JsonKey(name: 'cta_button_text') String? ctaButtonText,
    String? currency,
    String? description,
    DateTime? end,
    List<String>? events,
    @JsonKey(name: 'frequent_questions')
    List<FrequentQuestionInput>? frequentQuestions,
    @JsonKey(name: 'guest_limit') double? guestLimit,
    @JsonKey(name: 'guest_limit_per') double? guestLimitPer,
    double? latitude,
    @JsonKey(name: 'layout_sections') List<LayoutSectionInput>? layoutSections,
    double? longitude,
    @JsonKey(name: 'new_new_photos') List<String>? newNewPhotos,
    @JsonKey(name: 'new_photos') List<FileInlineInput>? newPhotos,
    List<EventOfferInput>? offers,
    @JsonKey(name: 'payment_accounts_new') List<String>? paymentAccountsNew,
    @JsonKey(name: 'payment_donation') bool? paymentDonation,
    @JsonKey(name: 'payment_donation_amount_includes_tickets')
    bool? paymentDonationAmountIncludesTickets,
    @JsonKey(name: 'payment_donation_message') String? paymentDonationMessage,
    @JsonKey(name: 'payment_donation_target') double? paymentDonationTarget,
    @JsonKey(name: 'payment_optional') bool? paymentOptional,
    @JsonKey(name: 'payment_ticket_purchase_title')
    String? paymentTicketPurchaseTitle,
    List<String>? photos,
    bool? private,
    bool? published,
    @JsonKey(name: 'require_approval') bool? requireApproval,
    List<EventRewardInput>? rewards,
    List<EventSessionInput>? sessions,
    @JsonKey(name: 'speaker_emails') List<String>? speakerEmails,
    @JsonKey(name: 'speaker_users') List<String>? speakerUsers,
    DateTime? start,
    List<String>? stores,
    List<String>? stories,
    List<String>? tags,
    @JsonKey(name: 'terms_email_permission_text')
    bool? termsEmailPermissionText,
    @JsonKey(name: 'terms_text') String? termsText,
    String? timezone,
    String? title,
    bool? virtual,
    @JsonKey(name: 'welcome_text') String? welcomeText,
    @JsonKey(name: 'welcome_video') VideoInput? welcomeVideo,
  }) = _EventInput;

  factory EventInput.fromJson(Map<String, dynamic> json) =>
      _$EventInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventJoinRequest with _$EventJoinRequest {
  const EventJoinRequest._();

  const factory EventJoinRequest({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'approved_at') DateTime? approvedAt,
    @JsonKey(name: 'approved_by') String? approvedBy,
    @JsonKey(name: 'approved_by_expanded') User? approvedByExpanded,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'declined_at') DateTime? declinedAt,
    @JsonKey(name: 'declined_by') String? declinedBy,
    @JsonKey(name: 'declined_by_expanded') User? declinedByExpanded,
    required String event,
    @JsonKey(name: 'event_expanded') Event? eventExpanded,
    NewPaymentBase? payment,
    @JsonKey(name: 'payment_expanded') NewPayment? paymentExpanded,
    @JsonKey(name: 'ticket_info') required List<TicketInfo> ticketInfo,
    required String user,
    @JsonKey(name: 'user_expanded') User? userExpanded,
  }) = _EventJoinRequest;

  factory EventJoinRequest.fromJson(Map<String, dynamic> json) =>
      _$EventJoinRequestFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventOffer with _$EventOffer {
  const EventOffer._();

  const factory EventOffer({
    @JsonKey(name: '_id') String? id,
    bool? auto,
    @JsonKey(name: 'broadcast_rooms') List<String>? broadcastRooms,
    double? position,
    required OfferProvider provider,
    @JsonKey(name: 'provider_id') required String providerId,
    @JsonKey(name: 'provider_network') required String providerNetwork,
  }) = _EventOffer;

  factory EventOffer.fromJson(Map<String, dynamic> json) =>
      _$EventOfferFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventOfferInput with _$EventOfferInput {
  const EventOfferInput._();

  const factory EventOfferInput({
    @JsonKey(name: '_id') String? id,
    bool? auto,
    @JsonKey(name: 'broadcast_rooms') List<String>? broadcastRooms,
    double? position,
    required OfferProvider provider,
    @JsonKey(name: 'provider_id') required String providerId,
    @JsonKey(name: 'provider_network') required String providerNetwork,
  }) = _EventOfferInput;

  factory EventOfferInput.fromJson(Map<String, dynamic> json) =>
      _$EventOfferInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventPaymentSummary with _$EventPaymentSummary {
  const EventPaymentSummary._();

  const factory EventPaymentSummary({
    required String amount,
    required String currency,
    required double decimals,
    @JsonKey(name: 'pending_transfer_amount')
    required String pendingTransferAmount,
    @JsonKey(name: 'transfer_amount') required String transferAmount,
  }) = _EventPaymentSummary;

  factory EventPaymentSummary.fromJson(Map<String, dynamic> json) =>
      _$EventPaymentSummaryFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventPaymentTicketDiscount with _$EventPaymentTicketDiscount {
  const EventPaymentTicketDiscount._();

  const factory EventPaymentTicketDiscount({
    required bool active,
    required String code,
    required double ratio,
    required DateTime stamp,
    @JsonKey(name: 'ticket_count') double? ticketCount,
    @JsonKey(name: 'ticket_count_map') Map<String, dynamic>? ticketCountMap,
    @JsonKey(name: 'ticket_limit') double? ticketLimit,
    @JsonKey(name: 'ticket_limit_per') double? ticketLimitPer,
    @JsonKey(name: 'ticket_types') List<String>? ticketTypes,
    @JsonKey(name: 'use_count') double? useCount,
    @JsonKey(name: 'use_count_map') Map<String, dynamic>? useCountMap,
    @JsonKey(name: 'use_limit') double? useLimit,
    @JsonKey(name: 'use_limit_per') double? useLimitPer,
    List<String>? users,
    @JsonKey(name: 'users_expanded') List<User?>? usersExpanded,
  }) = _EventPaymentTicketDiscount;

  factory EventPaymentTicketDiscount.fromJson(Map<String, dynamic> json) =>
      _$EventPaymentTicketDiscountFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventPaymentTicketDiscountInput with _$EventPaymentTicketDiscountInput {
  const EventPaymentTicketDiscountInput._();

  const factory EventPaymentTicketDiscountInput({
    required String code,
    required double ratio,
    @JsonKey(name: 'ticket_limit') double? ticketLimit,
    @JsonKey(name: 'ticket_limit_per') double? ticketLimitPer,
    @JsonKey(name: 'ticket_types') List<String>? ticketTypes,
    @JsonKey(name: 'use_limit') double? useLimit,
    @JsonKey(name: 'use_limit_per') double? useLimitPer,
  }) = _EventPaymentTicketDiscountInput;

  factory EventPaymentTicketDiscountInput.fromJson(Map<String, dynamic> json) =>
      _$EventPaymentTicketDiscountInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventQuestion with _$EventQuestion {
  const EventQuestion._();

  const factory EventQuestion({
    @JsonKey(name: '_id') required String id,
    required String event,
    bool? liked,
    required int likes,
    required String question,
    String? session,
    required DateTime stamp,
    required String user,
    @JsonKey(name: 'user_expanded') User? userExpanded,
  }) = _EventQuestion;

  factory EventQuestion.fromJson(Map<String, dynamic> json) =>
      _$EventQuestionFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventReward with _$EventReward {
  const EventReward._();

  const factory EventReward({
    @JsonKey(name: '_id') String? id,
    required bool active,
    @JsonKey(name: 'icon_color') String? iconColor,
    @JsonKey(name: 'icon_url') String? iconUrl,
    double? limit,
    @JsonKey(name: 'limit_per') required double limitPer,
    @JsonKey(name: 'payment_ticket_types') List<String>? paymentTicketTypes,
    required String title,
  }) = _EventReward;

  factory EventReward.fromJson(Map<String, dynamic> json) =>
      _$EventRewardFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventRewardInput with _$EventRewardInput {
  const EventRewardInput._();

  const factory EventRewardInput({
    @JsonKey(name: '_id') String? id,
    required bool active,
    @JsonKey(name: 'icon_color') String? iconColor,
    @JsonKey(name: 'icon_url') String? iconUrl,
    double? limit,
    @JsonKey(name: 'limit_per') required double limitPer,
    @JsonKey(name: 'payment_ticket_types') List<String>? paymentTicketTypes,
    required String title,
  }) = _EventRewardInput;

  factory EventRewardInput.fromJson(Map<String, dynamic> json) =>
      _$EventRewardInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventRewardUse with _$EventRewardUse {
  const EventRewardUse._();

  const factory EventRewardUse({
    @JsonKey(name: '_id') required String id,
    required bool active,
    required String event,
    @JsonKey(name: 'reward_id') required String rewardId,
    @JsonKey(name: 'reward_number') required double rewardNumber,
    required String user,
    @JsonKey(name: 'user_expanded') User? userExpanded,
  }) = _EventRewardUse;

  factory EventRewardUse.fromJson(Map<String, dynamic> json) =>
      _$EventRewardUseFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventRsvp with _$EventRsvp {
  const EventRsvp._();

  const factory EventRsvp({
    EventRsvpMessages? messages,
    EventRsvpPayment? payment,
    required EventRsvpState state,
  }) = _EventRsvp;

  factory EventRsvp.fromJson(Map<String, dynamic> json) =>
      _$EventRsvpFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventRsvpMessages with _$EventRsvpMessages {
  const EventRsvpMessages._();

  const factory EventRsvpMessages({
    required String primary,
    String? secondary,
  }) = _EventRsvpMessages;

  factory EventRsvpMessages.fromJson(Map<String, dynamic> json) =>
      _$EventRsvpMessagesFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventRsvpPayment with _$EventRsvpPayment {
  const EventRsvpPayment._();

  const factory EventRsvpPayment({
    required double amount,
    required String currency,
    required String provider,
  }) = _EventRsvpPayment;

  factory EventRsvpPayment.fromJson(Map<String, dynamic> json) =>
      _$EventRsvpPaymentFromJson(json);
}

enum EventRsvpState {
  accepted,
  declined,
  payment,
  pending,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventSession with _$EventSession {
  const EventSession._();

  const factory EventSession({
    @JsonKey(name: '_id') String? id,
    String? broadcast,
    String? description,
    required DateTime end,
    List<String>? photos,
    @JsonKey(name: 'photos_expanded') List<File?>? photosExpanded,
    @JsonKey(name: 'speaker_users') List<String>? speakerUsers,
    @JsonKey(name: 'speaker_users_expanded') List<User?>? speakerUsersExpanded,
    required DateTime start,
    required String title,
  }) = _EventSession;

  factory EventSession.fromJson(Map<String, dynamic> json) =>
      _$EventSessionFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventSessionInput with _$EventSessionInput {
  const EventSessionInput._();

  const factory EventSessionInput({
    @JsonKey(name: '_id') String? id,
    String? broadcast,
    String? description,
    required DateTime end,
    List<String>? photos,
    @JsonKey(name: 'speaker_users') List<String>? speakerUsers,
    required DateTime start,
    required String title,
  }) = _EventSessionInput;

  factory EventSessionInput.fromJson(Map<String, dynamic> json) =>
      _$EventSessionInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventSessionReservation with _$EventSessionReservation {
  const EventSessionReservation._();

  const factory EventSessionReservation({
    required String event,
    @JsonKey(name: 'payment_ticket_type') String? paymentTicketType,
    required String session,
    required String user,
    @JsonKey(name: 'user_expanded') User? userExpanded,
  }) = _EventSessionReservation;

  factory EventSessionReservation.fromJson(Map<String, dynamic> json) =>
      _$EventSessionReservationFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventSessionReservationInput with _$EventSessionReservationInput {
  const EventSessionReservationInput._();

  const factory EventSessionReservationInput({
    required String event,
    required String session,
  }) = _EventSessionReservationInput;

  factory EventSessionReservationInput.fromJson(Map<String, dynamic> json) =>
      _$EventSessionReservationInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventSessionReservationSummary with _$EventSessionReservationSummary {
  const EventSessionReservationSummary._();

  const factory EventSessionReservationSummary({
    required double count,
    @JsonKey(name: 'payment_ticket_type') String? paymentTicketType,
    required String session,
  }) = _EventSessionReservationSummary;

  factory EventSessionReservationSummary.fromJson(Map<String, dynamic> json) =>
      _$EventSessionReservationSummaryFromJson(json);
}

enum EventState {
  cancelled,
  created,
  ended,
  started,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventStoryInput with _$EventStoryInput {
  const EventStoryInput._();

  const factory EventStoryInput({
    required String event,
    required String file,
  }) = _EventStoryInput;

  factory EventStoryInput.fromJson(Map<String, dynamic> json) =>
      _$EventStoryInputFromJson(json);
}

enum EventTense {
  @JsonKey(name: 'Current')
  current,
  @JsonKey(name: 'Future')
  future,
  @JsonKey(name: 'Past')
  past,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventTicketPrice with _$EventTicketPrice {
  const EventTicketPrice._();

  const factory EventTicketPrice({
    required String cost,
    required String currency,
    @JsonKey(name: 'default') bool? default_,
    String? network,
  }) = _EventTicketPrice;

  factory EventTicketPrice.fromJson(Map<String, dynamic> json) =>
      _$EventTicketPriceFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventTicketPriceInput with _$EventTicketPriceInput {
  const EventTicketPriceInput._();

  const factory EventTicketPriceInput({
    required String cost,
    required String currency,
    @JsonKey(name: 'default') bool? default_,
    String? network,
  }) = _EventTicketPriceInput;

  factory EventTicketPriceInput.fromJson(Map<String, dynamic> json) =>
      _$EventTicketPriceInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventTicketType with _$EventTicketType {
  const EventTicketType._();

  const factory EventTicketType({
    @JsonKey(name: '_id') required String id,
    bool? active,
    @JsonKey(name: 'address_required') bool? addressRequired,
    @JsonKey(name: 'default') bool? default_,
    String? description,
    @JsonKey(name: 'description_line') String? descriptionLine,
    required String event,
    @JsonKey(name: 'external_ids') List<String>? externalIds,
    List<EventOffer>? offers,
    List<String>? photos,
    @JsonKey(name: 'photos_expanded') List<File?>? photosExpanded,
    required List<EventTicketPrice> prices,
    @JsonKey(name: 'ticket_count') double? ticketCount,
    @JsonKey(name: 'ticket_limit') double? ticketLimit,
    @JsonKey(name: 'ticket_limit_per') double? ticketLimitPer,
    required String title,
  }) = _EventTicketType;

  factory EventTicketType.fromJson(Map<String, dynamic> json) =>
      _$EventTicketTypeFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventTicketTypeInput with _$EventTicketTypeInput {
  const EventTicketTypeInput._();

  const factory EventTicketTypeInput({
    bool? active,
    @JsonKey(name: 'address_required') bool? addressRequired,
    @JsonKey(name: 'default') bool? default_,
    String? description,
    @JsonKey(name: 'description_line') String? descriptionLine,
    String? event,
    @JsonKey(name: 'external_ids') List<String>? externalIds,
    List<EventTicketTypeOffersInput>? offers,
    List<String>? photos,
    List<EventTicketPriceInput>? prices,
    @JsonKey(name: 'ticket_limit') double? ticketLimit,
    @JsonKey(name: 'ticket_limit_per') double? ticketLimitPer,
    String? title,
  }) = _EventTicketTypeInput;

  factory EventTicketTypeInput.fromJson(Map<String, dynamic> json) =>
      _$EventTicketTypeInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventTicketTypeOffersInput with _$EventTicketTypeOffersInput {
  const EventTicketTypeOffersInput._();

  const factory EventTicketTypeOffersInput({
    @JsonKey(name: '_id') String? id,
    bool? auto,
    @JsonKey(name: 'broadcast_rooms') List<String>? broadcastRooms,
    double? position,
    OfferProvider? provider,
    @JsonKey(name: 'provider_id') String? providerId,
    @JsonKey(name: 'provider_network') String? providerNetwork,
  }) = _EventTicketTypeOffersInput;

  factory EventTicketTypeOffersInput.fromJson(Map<String, dynamic> json) =>
      _$EventTicketTypeOffersInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class EventbriteEvent with _$EventbriteEvent {
  const EventbriteEvent._();

  const factory EventbriteEvent({
    String? description,
    required DateTime end,
    required String id,
    @JsonKey(name: 'logo_url') String? logoUrl,
    required DateTime stamp,
    required DateTime start,
    required String status,
    required String title,
  }) = _EventbriteEvent;

  factory EventbriteEvent.fromJson(Map<String, dynamic> json) =>
      _$EventbriteEventFromJson(json);
}

enum EventbriteEventOrder {
  @JsonKey(name: 'CREATED_ASC')
  createdAsc,
  @JsonKey(name: 'CREATED_DESC')
  createdDesc,
}

enum EventbriteEventStatus {
  @JsonKey(name: 'CANCELED')
  canceled,
  @JsonKey(name: 'DRAFT')
  draft,
  @JsonKey(name: 'ENDED')
  ended,
  @JsonKey(name: 'LIVE')
  live,
  @JsonKey(name: 'STARTED')
  started,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class FiatCurrency with _$FiatCurrency {
  const FiatCurrency._();

  const factory FiatCurrency({
    required String code,
    required double decimals,
  }) = _FiatCurrency;

  factory FiatCurrency.fromJson(Map<String, dynamic> json) =>
      _$FiatCurrencyFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class File with _$File {
  const File._();

  const factory File({
    @JsonKey(name: '_id') String? id,
    required String bucket,
    String? description,
    required String key,
    bool? liked,
    List<String>? likers,
    required double likes,
    @JsonKey(name: 'link_events_expanded') List<Event?>? linkEventsExpanded,
    @JsonKey(name: 'link_store_products_expanded')
    List<StoreProduct?>? linkStoreProductsExpanded,
    @JsonKey(name: 'link_stores_expanded') List<Store?>? linkStoresExpanded,
    @JsonKey(name: 'link_users_expanded') List<User?>? linkUsersExpanded,
    List<FileLink>? links,
    required String owner,
    @JsonKey(name: 'owner_expanded') User? ownerExpanded,
    required double size,
    required DateTime stamp,
    required FileState state,
    required String type,
    required String url,
  }) = _File;

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class FileInline with _$FileInline {
  const FileInline._();

  const factory FileInline({
    @JsonKey(name: 'fa_file') String? faFile,
    @JsonKey(name: 'fa_index') double? faIndex,
    required String id,
    required String key,
    required String url,
  }) = _FileInline;

  factory FileInline.fromJson(Map<String, dynamic> json) =>
      _$FileInlineFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class FileInlineInput with _$FileInlineInput {
  const FileInlineInput._();

  const factory FileInlineInput({
    @JsonKey(name: 'fa_file') String? faFile,
    @JsonKey(name: 'fa_index') double? faIndex,
    required String id,
    required String key,
    required String url,
  }) = _FileInlineInput;

  factory FileInlineInput.fromJson(Map<String, dynamic> json) =>
      _$FileInlineInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class FileInput with _$FileInput {
  const FileInput._();

  const factory FileInput({
    String? description,
  }) = _FileInput;

  factory FileInput.fromJson(Map<String, dynamic> json) =>
      _$FileInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class FileLink with _$FileLink {
  const FileLink._();

  const factory FileLink({
    required String id,
    required String model,
    required String path,
    required FileLinkType type,
  }) = _FileLink;

  factory FileLink.fromJson(Map<String, dynamic> json) =>
      _$FileLinkFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class FileLinkInput with _$FileLinkInput {
  const FileLinkInput._();

  const factory FileLinkInput({
    required String id,
    required String model,
    String? path,
    FileLinkType? type,
  }) = _FileLinkInput;

  factory FileLinkInput.fromJson(Map<String, dynamic> json) =>
      _$FileLinkInputFromJson(json);
}

enum FileLinkType {
  @JsonKey(name: 'file_inline')
  fileInline,
  @JsonKey(name: 'object_id')
  objectId,
}

enum FileState {
  done,
  error,
  started,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class FilterEventInput with _$FilterEventInput {
  const FilterEventInput._();

  const factory FilterEventInput({
    EventState? eq,
    @JsonKey(name: 'in') List<EventState>? in_,
    List<EventState>? nin,
  }) = _FilterEventInput;

  factory FilterEventInput.fromJson(Map<String, dynamic> json) =>
      _$FilterEventInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class FreeSafeInitInfo with _$FreeSafeInitInfo {
  const FreeSafeInitInfo._();

  const factory FreeSafeInitInfo({
    required int current,
    required int max,
  }) = _FreeSafeInitInfo;

  factory FreeSafeInitInfo.fromJson(Map<String, dynamic> json) =>
      _$FreeSafeInitInfoFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class FrequentQuestion with _$FrequentQuestion {
  const FrequentQuestion._();

  const factory FrequentQuestion({
    @JsonKey(name: '_id') String? id,
    required String answer,
    double? position,
    required String question,
    String? tag,
    required List<FrequentQuestionType> type,
  }) = _FrequentQuestion;

  factory FrequentQuestion.fromJson(Map<String, dynamic> json) =>
      _$FrequentQuestionFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class FrequentQuestionInput with _$FrequentQuestionInput {
  const FrequentQuestionInput._();

  const factory FrequentQuestionInput({
    @JsonKey(name: '_id') String? id,
    required String answer,
    double? position,
    required String question,
    String? tag,
    required List<FrequentQuestionType> type,
  }) = _FrequentQuestionInput;

  factory FrequentQuestionInput.fromJson(Map<String, dynamic> json) =>
      _$FrequentQuestionInputFromJson(json);
}

enum FrequentQuestionType {
  event,
  poap,
  user,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetCommentsArgs with _$GetCommentsArgs {
  const GetCommentsArgs._();

  const factory GetCommentsArgs({
    String? comment,
    required String post,
  }) = _GetCommentsArgs;

  factory GetCommentsArgs.fromJson(Map<String, dynamic> json) =>
      _$GetCommentsArgsFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetEventCheckinsInput with _$GetEventCheckinsInput {
  const GetEventCheckinsInput._();

  const factory GetEventCheckinsInput({
    required String event,
    List<String>? users,
  }) = _GetEventCheckinsInput;

  factory GetEventCheckinsInput.fromJson(Map<String, dynamic> json) =>
      _$GetEventCheckinsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetEventCohostRequestsInput with _$GetEventCohostRequestsInput {
  const GetEventCohostRequestsInput._();

  const factory GetEventCohostRequestsInput({
    required String event,
    EventCohostRequestState? state,
  }) = _GetEventCohostRequestsInput;

  factory GetEventCohostRequestsInput.fromJson(Map<String, dynamic> json) =>
      _$GetEventCohostRequestsInputFromJson(json);
}

enum GetEventQuestionInputSort {
  @JsonKey(name: '_id')
  id,
  likes,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetEventQuestionsInput with _$GetEventQuestionsInput {
  const GetEventQuestionsInput._();

  const factory GetEventQuestionsInput({
    required String event,
    @JsonKey(name: 'id_lt') String? idLt,
    required int limit,
    required GetEventQuestionInputSort sort,
  }) = _GetEventQuestionsInput;

  factory GetEventQuestionsInput.fromJson(Map<String, dynamic> json) =>
      _$GetEventQuestionsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetEventRewardUsesInput with _$GetEventRewardUsesInput {
  const GetEventRewardUsesInput._();

  const factory GetEventRewardUsesInput({
    required String event,
    required String user,
  }) = _GetEventRewardUsesInput;

  factory GetEventRewardUsesInput.fromJson(Map<String, dynamic> json) =>
      _$GetEventRewardUsesInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetEventSessionReservationSummaryInput
    with _$GetEventSessionReservationSummaryInput {
  const GetEventSessionReservationSummaryInput._();

  const factory GetEventSessionReservationSummaryInput({
    required String event,
    String? session,
  }) = _GetEventSessionReservationSummaryInput;

  factory GetEventSessionReservationSummaryInput.fromJson(
          Map<String, dynamic> json) =>
      _$GetEventSessionReservationSummaryInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetEventSessionReservationsInput with _$GetEventSessionReservationsInput {
  const GetEventSessionReservationsInput._();

  const factory GetEventSessionReservationsInput({
    String? event,
  }) = _GetEventSessionReservationsInput;

  factory GetEventSessionReservationsInput.fromJson(
          Map<String, dynamic> json) =>
      _$GetEventSessionReservationsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetEventTicketTypesInput with _$GetEventTicketTypesInput {
  const GetEventTicketTypesInput._();

  const factory GetEventTicketTypesInput({
    String? discount,
    required String event,
  }) = _GetEventTicketTypesInput;

  factory GetEventTicketTypesInput.fromJson(Map<String, dynamic> json) =>
      _$GetEventTicketTypesInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetEventTicketTypesResponse with _$GetEventTicketTypesResponse {
  const GetEventTicketTypesResponse._();

  const factory GetEventTicketTypesResponse({
    TicketDiscount? discount,
    required double limit,
    @JsonKey(name: 'ticket_types')
    required List<PurchasableTicketType> ticketTypes,
  }) = _GetEventTicketTypesResponse;

  factory GetEventTicketTypesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetEventTicketTypesResponseFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetEventbriteEventsInput with _$GetEventbriteEventsInput {
  const GetEventbriteEventsInput._();

  const factory GetEventbriteEventsInput({
    EventbriteEventOrder? order,
    EventbriteEventStatus? status,
  }) = _GetEventbriteEventsInput;

  factory GetEventbriteEventsInput.fromJson(Map<String, dynamic> json) =>
      _$GetEventbriteEventsInputFromJson(json);
}

enum GetEventsState {
  @JsonKey(name: 'ACCEPTED')
  accepted,
  @JsonKey(name: 'DECLINED')
  declined,
  @JsonKey(name: 'INVITED')
  invited,
  @JsonKey(name: 'PENDING')
  pending,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetFrequentQuestionsInput with _$GetFrequentQuestionsInput {
  const GetFrequentQuestionsInput._();

  const factory GetFrequentQuestionsInput({
    required List<FrequentQuestionType> type,
  }) = _GetFrequentQuestionsInput;

  factory GetFrequentQuestionsInput.fromJson(Map<String, dynamic> json) =>
      _$GetFrequentQuestionsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetInitSafeTransactionInput with _$GetInitSafeTransactionInput {
  const GetInitSafeTransactionInput._();

  const factory GetInitSafeTransactionInput({
    required String network,
    required List<String> owners,
    required int threshold,
  }) = _GetInitSafeTransactionInput;

  factory GetInitSafeTransactionInput.fromJson(Map<String, dynamic> json) =>
      _$GetInitSafeTransactionInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetPostsCreatedAtInput with _$GetPostsCreatedAtInput {
  const GetPostsCreatedAtInput._();

  const factory GetPostsCreatedAtInput({
    DateTime? gte,
    DateTime? lte,
  }) = _GetPostsCreatedAtInput;

  factory GetPostsCreatedAtInput.fromJson(Map<String, dynamic> json) =>
      _$GetPostsCreatedAtInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetPostsInput with _$GetPostsInput {
  const GetPostsInput._();

  const factory GetPostsInput({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'created_at') GetPostsCreatedAtInput? createdAt,
    bool? published,
    String? user,
  }) = _GetPostsInput;

  factory GetPostsInput.fromJson(Map<String, dynamic> json) =>
      _$GetPostsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetRoomCredentialsInput with _$GetRoomCredentialsInput {
  const GetRoomCredentialsInput._();

  const factory GetRoomCredentialsInput({
    @JsonKey(name: '_id') required String id,
    String? password,
    required GetRoomCredentialsInputRole role,
  }) = _GetRoomCredentialsInput;

  factory GetRoomCredentialsInput.fromJson(Map<String, dynamic> json) =>
      _$GetRoomCredentialsInputFromJson(json);
}

enum GetRoomCredentialsInputRole {
  @JsonKey(name: 'PUBLISHER')
  publisher,
  @JsonKey(name: 'SUBSCRIBER')
  subscriber,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetRoomsInput with _$GetRoomsInput {
  const GetRoomsInput._();

  const factory GetRoomsInput({
    String? creator,
    String? event,
    required int limit,
    required int skip,
    GetRoomsInputState? state,
  }) = _GetRoomsInput;

  factory GetRoomsInput.fromJson(Map<String, dynamic> json) =>
      _$GetRoomsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetRoomsInputState with _$GetRoomsInputState {
  const GetRoomsInputState._();

  const factory GetRoomsInputState({
    RoomState? eq,
    @JsonKey(name: 'in') List<RoomState>? in_,
    List<RoomState>? nin,
  }) = _GetRoomsInputState;

  factory GetRoomsInputState.fromJson(Map<String, dynamic> json) =>
      _$GetRoomsInputStateFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetUserContactsInput with _$GetUserContactsInput {
  const GetUserContactsInput._();

  const factory GetUserContactsInput({
    @JsonKey(name: 'invited_at_gt') DateTime? invitedAtGt,
    String? search,
    List<String>? tags,
  }) = _GetUserContactsInput;

  factory GetUserContactsInput.fromJson(Map<String, dynamic> json) =>
      _$GetUserContactsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetUserContactsResponse with _$GetUserContactsResponse {
  const GetUserContactsResponse._();

  const factory GetUserContactsResponse({
    Map<String, dynamic>? counts,
    required List<UserContact> items,
    required int total,
  }) = _GetUserContactsResponse;

  factory GetUserContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserContactsResponseFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetUserFollowsInput with _$GetUserFollowsInput {
  const GetUserFollowsInput._();

  const factory GetUserFollowsInput({
    String? followee,
    @JsonKey(name: 'followee_search') String? followeeSearch,
    String? follower,
    @JsonKey(name: 'follower_search') String? followerSearch,
  }) = _GetUserFollowsInput;

  factory GetUserFollowsInput.fromJson(Map<String, dynamic> json) =>
      _$GetUserFollowsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetUserFriendshipsInput with _$GetUserFriendshipsInput {
  const GetUserFriendshipsInput._();

  const factory GetUserFriendshipsInput({
    String? other,
    @JsonKey(name: 'other_search') String? otherSearch,
    @JsonKey(name: 'other_wallets') bool? otherWallets,
    UserFriendshipState? state,
    UserFriendshipType? type,
    String? user,
    String? user1,
    String? user2,
  }) = _GetUserFriendshipsInput;

  factory GetUserFriendshipsInput.fromJson(Map<String, dynamic> json) =>
      _$GetUserFriendshipsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class GetUserFriendshipsResponse with _$GetUserFriendshipsResponse {
  const GetUserFriendshipsResponse._();

  const factory GetUserFriendshipsResponse({
    required List<UserFriendship> items,
    required int total,
  }) = _GetUserFriendshipsResponse;

  factory GetUserFriendshipsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserFriendshipsResponseFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class InviteEventInput with _$InviteEventInput {
  const InviteEventInput._();

  const factory InviteEventInput({
    @JsonKey(name: '_id') required String id,
    List<String>? emails,
    List<String>? phones,
    List<String>? users,
  }) = _InviteEventInput;

  factory InviteEventInput.fromJson(Map<String, dynamic> json) =>
      _$InviteEventInputFromJson(json);
}

enum JoinRequestState {
  approved,
  declined,
  pending,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class LayoutSection with _$LayoutSection {
  const LayoutSection._();

  const factory LayoutSection({
    bool? hidden,
    String? id,
  }) = _LayoutSection;

  factory LayoutSection.fromJson(Map<String, dynamic> json) =>
      _$LayoutSectionFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class LayoutSectionInput with _$LayoutSectionInput {
  const LayoutSectionInput._();

  const factory LayoutSectionInput({
    bool? hidden,
    String? id,
  }) = _LayoutSectionInput;

  factory LayoutSectionInput.fromJson(Map<String, dynamic> json) =>
      _$LayoutSectionInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class ManageEventCohostRequestsInput with _$ManageEventCohostRequestsInput {
  const ManageEventCohostRequestsInput._();

  const factory ManageEventCohostRequestsInput({
    required bool decision,
    required String event,
    required List<String> users,
  }) = _ManageEventCohostRequestsInput;

  factory ManageEventCohostRequestsInput.fromJson(Map<String, dynamic> json) =>
      _$ManageEventCohostRequestsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class ModifyRoomStageInput with _$ModifyRoomStageInput {
  const ModifyRoomStageInput._();

  const factory ModifyRoomStageInput({
    @JsonKey(name: '_id') required String id,
    required bool staged,
    required String user,
  }) = _ModifyRoomStageInput;

  factory ModifyRoomStageInput.fromJson(Map<String, dynamic> json) =>
      _$ModifyRoomStageInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class ModifyRoomStagePayload with _$ModifyRoomStagePayload {
  const ModifyRoomStagePayload._();

  const factory ModifyRoomStagePayload({
    RoomCredentials? credentials,
  }) = _ModifyRoomStagePayload;

  factory ModifyRoomStagePayload.fromJson(Map<String, dynamic> json) =>
      _$ModifyRoomStagePayloadFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class NewPayment with _$NewPayment {
  const NewPayment._();

  const factory NewPayment({
    @JsonKey(name: '_id') required String id,
    required String account,
    @JsonKey(name: 'account_expanded') NewPaymentAccount? accountExpanded,
    required String amount,
    @JsonKey(name: 'billing_info') BillingInfo? billingInfo,
    required String currency,
    @JsonKey(name: 'failure_reason') String? failureReason,
    required Map<String, dynamic> stamps,
    required NewPaymentState state,
    @JsonKey(name: 'transfer_metadata') Map<String, dynamic>? transferMetadata,
    @JsonKey(name: 'transfer_params') Map<String, dynamic>? transferParams,
    required String user,
  }) = _NewPayment;

  factory NewPayment.fromJson(Map<String, dynamic> json) =>
      _$NewPaymentFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class NewPaymentAccount with _$NewPaymentAccount {
  const NewPaymentAccount._();

  const factory NewPaymentAccount({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'account_info') required AccountInfo accountInfo,
    required bool active,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    NewPaymentProvider? provider,
    String? title,
    required PaymentAccountType type,
    required String user,
  }) = _NewPaymentAccount;

  factory NewPaymentAccount.fromJson(Map<String, dynamic> json) =>
      _$NewPaymentAccountFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class NewPaymentBase with _$NewPaymentBase {
  const NewPaymentBase._();

  const factory NewPaymentBase({
    @JsonKey(name: '_id') required String id,
    required String account,
    required String amount,
    @JsonKey(name: 'billing_info') BillingInfo? billingInfo,
    required String currency,
    @JsonKey(name: 'failure_reason') String? failureReason,
    required Map<String, dynamic> stamps,
    required NewPaymentState state,
    @JsonKey(name: 'transfer_metadata') Map<String, dynamic>? transferMetadata,
    @JsonKey(name: 'transfer_params') Map<String, dynamic>? transferParams,
    required String user,
  }) = _NewPaymentBase;

  factory NewPaymentBase.fromJson(Map<String, dynamic> json) =>
      _$NewPaymentBaseFromJson(json);
}

enum NewPaymentProvider {
  safe,
  stripe,
}

enum NewPaymentState {
  created,
  failed,
  initialized,
  succeeded,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Newsfeed with _$Newsfeed {
  const Newsfeed._();

  const factory Newsfeed({
    required double offset,
    required List<Post> posts,
  }) = _Newsfeed;

  factory Newsfeed.fromJson(Map<String, dynamic> json) =>
      _$NewsfeedFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Notification with _$Notification {
  const Notification._();

  const factory Notification({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    Map<String, dynamic>? data,
    String? from,
    @JsonKey(name: 'from_expanded') User? fromExpanded,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'is_seen') bool? isSeen,
    String? message,
    @JsonKey(name: 'ref_event') String? refEvent,
    @JsonKey(name: 'ref_event_expanded') Event? refEventExpanded,
    @JsonKey(name: 'ref_room') String? refRoom,
    @JsonKey(name: 'ref_room_expanded') Room? refRoomExpanded,
    @JsonKey(name: 'ref_store_order') String? refStoreOrder,
    @JsonKey(name: 'ref_store_order_expanded')
    StoreOrder? refStoreOrderExpanded,
    @JsonKey(name: 'ref_user') String? refUser,
    @JsonKey(name: 'ref_user_expanded') User? refUserExpanded,
    String? title,
    required NotificationType type,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}

enum NotificationType {
  @JsonKey(name: 'admin_payment_verification')
  adminPaymentVerification,
  @JsonKey(name: 'chat_message')
  chatMessage,
  @JsonKey(name: 'event_announce')
  eventAnnounce,
  @JsonKey(name: 'event_approve')
  eventApprove,
  @JsonKey(name: 'event_broadcast_created')
  eventBroadcastCreated,
  @JsonKey(name: 'event_broadcast_deactivated')
  eventBroadcastDeactivated,
  @JsonKey(name: 'event_broadcast_deleted')
  eventBroadcastDeleted,
  @JsonKey(name: 'event_broadcast_ended')
  eventBroadcastEnded,
  @JsonKey(name: 'event_broadcast_rescheduled')
  eventBroadcastRescheduled,
  @JsonKey(name: 'event_broadcast_started')
  eventBroadcastStarted,
  @JsonKey(name: 'event_cancellation')
  eventCancellation,
  @JsonKey(name: 'event_chat_announce')
  eventChatAnnounce,
  @JsonKey(name: 'event_cohost_request')
  eventCohostRequest,
  @JsonKey(name: 'event_cohost_request_announce')
  eventCohostRequestAnnounce,
  @JsonKey(name: 'event_donation')
  eventDonation,
  @JsonKey(name: 'event_invite')
  eventInvite,
  @JsonKey(name: 'event_invite_verify_accept_request')
  eventInviteVerifyAcceptRequest,
  @JsonKey(name: 'event_invite_verify_request')
  eventInviteVerifyRequest,
  @JsonKey(name: 'event_request_approved')
  eventRequestApproved,
  @JsonKey(name: 'event_request_created')
  eventRequestCreated,
  @JsonKey(name: 'event_request_declined')
  eventRequestDeclined,
  @JsonKey(name: 'event_unlock_verify_accept_request')
  eventUnlockVerifyAcceptRequest,
  @JsonKey(name: 'event_unlock_verify_request')
  eventUnlockVerifyRequest,
  @JsonKey(name: 'event_update')
  eventUpdate,
  @JsonKey(name: 'payment_assign')
  paymentAssign,
  @JsonKey(name: 'payment_authorized')
  paymentAuthorized,
  @JsonKey(name: 'payment_failed')
  paymentFailed,
  @JsonKey(name: 'payment_refunded')
  paymentRefunded,
  @JsonKey(name: 'payment_succeeded')
  paymentSucceeded,
  @JsonKey(name: 'payments_captured_summary')
  paymentsCapturedSummary,
  @JsonKey(name: 'payments_wired_summary')
  paymentsWiredSummary,
  @JsonKey(name: 'place_reservation_delete')
  placeReservationDelete,
  @JsonKey(name: 'place_reservation_request')
  placeReservationRequest,
  @JsonKey(name: 'place_reservation_request_accept')
  placeReservationRequestAccept,
  @JsonKey(name: 'place_reservation_request_decline')
  placeReservationRequestDecline,
  @JsonKey(name: 'reservation_accept')
  reservationAccept,
  @JsonKey(name: 'reservation_decline')
  reservationDecline,
  @JsonKey(name: 'room_invite')
  roomInvite,
  @JsonKey(name: 'room_started')
  roomStarted,
  @JsonKey(name: 'safe_vault_init_failed')
  safeVaultInitFailed,
  @JsonKey(name: 'safe_vault_init_success')
  safeVaultInitSuccess,
  @JsonKey(name: 'store_order_accepted')
  storeOrderAccepted,
  @JsonKey(name: 'store_order_awaiting_pickup')
  storeOrderAwaitingPickup,
  @JsonKey(name: 'store_order_cancelled')
  storeOrderCancelled,
  @JsonKey(name: 'store_order_declined')
  storeOrderDeclined,
  @JsonKey(name: 'store_order_delivered')
  storeOrderDelivered,
  @JsonKey(name: 'store_order_delivery_confirmed')
  storeOrderDeliveryConfirmed,
  @JsonKey(name: 'store_order_in_transit')
  storeOrderInTransit,
  @JsonKey(name: 'store_order_pending')
  storeOrderPending,
  @JsonKey(name: 'store_order_preparing')
  storeOrderPreparing,
  @JsonKey(name: 'user_contact_signup')
  userContactSignup,
  @JsonKey(name: 'user_discovery_match')
  userDiscoveryMatch,
  @JsonKey(name: 'user_friendship_request')
  userFriendshipRequest,
  @JsonKey(name: 'user_friendship_request_accept')
  userFriendshipRequestAccept,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class NotificationTypeFilterInput with _$NotificationTypeFilterInput {
  const NotificationTypeFilterInput._();

  const factory NotificationTypeFilterInput({
    NotificationType? eq,
    @JsonKey(name: 'in') List<NotificationType>? in_,
    List<NotificationType>? nin,
  }) = _NotificationTypeFilterInput;

  factory NotificationTypeFilterInput.fromJson(Map<String, dynamic> json) =>
      _$NotificationTypeFilterInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Offer with _$Offer {
  const Offer._();

  const factory Offer({
    @JsonKey(name: '_id') String? id,
    String? color,
    double? position,
    required OfferProvider provider,
    @JsonKey(name: 'provider_id') required String providerId,
    @JsonKey(name: 'provider_network') required String providerNetwork,
  }) = _Offer;

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);
}

enum OfferProvider {
  claimable,
  @JsonKey(name: 'festival_heads')
  festivalHeads,
  metaverse,
  order,
  poap,
  token,
}

enum OfferType {
  @JsonKey(name: 'HOME')
  home,
  @JsonKey(name: 'POAP')
  poap,
}

enum PaymentAccountType {
  digital,
  ethereum,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Point with _$Point {
  const Point._();

  const factory Point({
    required List<double> coordinates,
    required String type,
  }) = _Point;

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Post with _$Post {
  const Post._();

  const factory Post({
    @JsonKey(name: '_id') required String id,
    double? comments,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'has_reaction') bool? hasReaction,
    bool? published,
    double? reactions,
    @JsonKey(name: 'ref_event') Event? refEvent,
    @JsonKey(name: 'ref_file') File? refFile,
    @JsonKey(name: 'ref_id') String? refId,
    @JsonKey(name: 'ref_type') PostRefType? refType,
    String? text,
    required String user,
    @JsonKey(name: 'user_expanded') User? userExpanded,
    required PostVisibility visibility,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class PostInput with _$PostInput {
  const PostInput._();

  const factory PostInput({
    @JsonKey(name: 'ref_id') String? refId,
    @JsonKey(name: 'ref_type') PostRefType? refType,
    String? text,
    required PostVisibility visibility,
  }) = _PostInput;

  factory PostInput.fromJson(Map<String, dynamic> json) =>
      _$PostInputFromJson(json);
}

enum PostRefType {
  @JsonKey(name: 'EVENT')
  event,
  @JsonKey(name: 'FILE')
  file,
}

enum PostVisibility {
  @JsonKey(name: 'FOLLOWERS')
  followers,
  @JsonKey(name: 'FRIENDS')
  friends,
  @JsonKey(name: 'MENTIONS')
  mentions,
  @JsonKey(name: 'PUBLIC')
  public,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class PricingInfo with _$PricingInfo {
  const PricingInfo._();

  const factory PricingInfo({
    required String discount,
    @JsonKey(name: 'payment_accounts') List<NewPaymentAccount>? paymentAccounts,
    required String subtotal,
    required String total,
  }) = _PricingInfo;

  factory PricingInfo.fromJson(Map<String, dynamic> json) =>
      _$PricingInfoFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class PurchasableItem with _$PurchasableItem {
  const PurchasableItem._();

  const factory PurchasableItem({
    required int count,
    required String id,
  }) = _PurchasableItem;

  factory PurchasableItem.fromJson(Map<String, dynamic> json) =>
      _$PurchasableItemFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class PurchasableTicketType with _$PurchasableTicketType {
  const PurchasableTicketType._();

  const factory PurchasableTicketType({
    @JsonKey(name: '_id') required String id,
    bool? active,
    @JsonKey(name: 'address_required') bool? addressRequired,
    @JsonKey(name: 'default') bool? default_,
    String? description,
    @JsonKey(name: 'description_line') String? descriptionLine,
    required bool discountable,
    required String event,
    @JsonKey(name: 'external_ids') List<String>? externalIds,
    required double limit,
    List<EventOffer>? offers,
    List<String>? photos,
    required List<EventTicketPrice> prices,
    required String title,
  }) = _PurchasableTicketType;

  factory PurchasableTicketType.fromJson(Map<String, dynamic> json) =>
      _$PurchasableTicketTypeFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RawTransaction with _$RawTransaction {
  const RawTransaction._();

  const factory RawTransaction({
    required String data,
    required String to,
    required String value,
  }) = _RawTransaction;

  factory RawTransaction.fromJson(Map<String, dynamic> json) =>
      _$RawTransactionFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class ReactionInput with _$ReactionInput {
  const ReactionInput._();

  const factory ReactionInput({
    required bool active,
    required String post,
  }) = _ReactionInput;

  factory ReactionInput.fromJson(Map<String, dynamic> json) =>
      _$ReactionInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RedeemItem with _$RedeemItem {
  const RedeemItem._();

  const factory RedeemItem({
    required int count,
    @JsonKey(name: 'ticket_type') required String ticketType,
  }) = _RedeemItem;

  factory RedeemItem.fromJson(Map<String, dynamic> json) =>
      _$RedeemItemFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RedeemTicketsInput with _$RedeemTicketsInput {
  const RedeemTicketsInput._();

  const factory RedeemTicketsInput({
    required String event,
    required List<RedeemItem> items,
  }) = _RedeemTicketsInput;

  factory RedeemTicketsInput.fromJson(Map<String, dynamic> json) =>
      _$RedeemTicketsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RedeemTicketsResponse with _$RedeemTicketsResponse {
  const RedeemTicketsResponse._();

  const factory RedeemTicketsResponse({
    @JsonKey(name: 'event_join_request') EventJoinRequest? eventJoinRequest,
    List<Ticket>? tickets,
  }) = _RedeemTicketsResponse;

  factory RedeemTicketsResponse.fromJson(Map<String, dynamic> json) =>
      _$RedeemTicketsResponseFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Registration with _$Registration {
  const Registration._();

  const factory Registration({
    required String client,
    @JsonKey(name: 'consent_communications') bool? consentCommunications,
    String? country,
    required String email,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    String? organization,
    @JsonKey(name: 'postal_code') String? postalCode,
  }) = _Registration;

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class ReportUserInput with _$ReportUserInput {
  const ReportUserInput._();

  const factory ReportUserInput({
    bool? block,
    String? reason,
    required String user,
  }) = _ReportUserInput;

  factory ReportUserInput.fromJson(Map<String, dynamic> json) =>
      _$ReportUserInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RequestRoomStageInput with _$RequestRoomStageInput {
  const RequestRoomStageInput._();

  const factory RequestRoomStageInput({
    @JsonKey(name: '_id') required String id,
    required String user,
  }) = _RequestRoomStageInput;

  factory RequestRoomStageInput.fromJson(Map<String, dynamic> json) =>
      _$RequestRoomStageInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RewindUserDiscoveryResponse with _$RewindUserDiscoveryResponse {
  const RewindUserDiscoveryResponse._();

  const factory RewindUserDiscoveryResponse({
    required UserDiscoverySwipeDecision decision,
    User? user,
  }) = _RewindUserDiscoveryResponse;

  factory RewindUserDiscoveryResponse.fromJson(Map<String, dynamic> json) =>
      _$RewindUserDiscoveryResponseFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Room with _$Room {
  const Room._();

  const factory Room({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'access_requesters') List<String>? accessRequesters,
    @JsonKey(name: 'access_requesters_expanded')
    List<User>? accessRequestersExpanded,
    @JsonKey(name: 'access_users') List<String>? accessUsers,
    @JsonKey(name: 'access_users_expanded') List<User>? accessUsersExpanded,
    required bool active,
    @JsonKey(name: 'attending_users') List<String>? attendingUsers,
    @JsonKey(name: 'attending_users_expanded')
    List<User>? attendingUsersExpanded,
    @JsonKey(name: 'audience_size') double? audienceSize,
    @JsonKey(name: 'audience_total') double? audienceTotal,
    @JsonKey(name: 'broadcasters_count') double? broadcastersCount,
    List<String>? cohosts,
    @JsonKey(name: 'cohosts_expanded') List<User?>? cohostsExpanded,
    @JsonKey(name: 'creator_last_seen_at') DateTime? creatorLastSeenAt,
    String? description,
    String? event,
    @JsonKey(name: 'event_expanded') Event? eventExpanded,
    @JsonKey(name: 'has_access') bool? hasAccess,
    @JsonKey(name: 'highlight_events') List<String>? highlightEvents,
    @JsonKey(name: 'highlight_events_expanded')
    List<Event>? highlightEventsExpanded,
    @JsonKey(name: 'highlight_rooms') List<String>? highlightRooms,
    @JsonKey(name: 'highlight_rooms_expanded')
    List<Room>? highlightRoomsExpanded,
    @JsonKey(name: 'highlight_stores') List<String>? highlightStores,
    @JsonKey(name: 'highlight_stores_expanded')
    List<Store>? highlightStoresExpanded,
    @JsonKey(name: 'highlight_users') List<String>? highlightUsers,
    @JsonKey(name: 'highlight_users_expanded')
    List<User>? highlightUsersExpanded,
    required String host,
    @JsonKey(name: 'host_expanded') User? hostExpanded,
    List<RoomOffer>? offers,
    @JsonKey(name: 'payment_direct') bool? paymentDirect,
    List<String>? photos,
    @JsonKey(name: 'photos_expanded') List<File>? photosExpanded,
    bool? private,
    required String shortid,
    @JsonKey(name: 'stage_invitees') List<String>? stageInvitees,
    @JsonKey(name: 'stage_invitees_expanded') List<User>? stageInviteesExpanded,
    @JsonKey(name: 'stage_open') bool? stageOpen,
    @JsonKey(name: 'stage_requesters') List<String>? stageRequesters,
    @JsonKey(name: 'stage_requesters_expanded')
    List<User>? stageRequestersExpanded,
    @JsonKey(name: 'staged_size') double? stagedSize,
    @JsonKey(name: 'staged_uids') List<double>? stagedUids,
    @JsonKey(name: 'staged_users') List<String>? stagedUsers,
    @JsonKey(name: 'staged_users_expanded') List<User>? stagedUsersExpanded,
    required DateTime stamp,
    required DateTime start,
    required RoomState state,
    @JsonKey(name: 'theme_background_photo') String? themeBackgroundPhoto,
    @JsonKey(name: 'theme_background_photo_expanded')
    File? themeBackgroundPhotoExpanded,
    @JsonKey(name: 'theme_color') String? themeColor,
    @JsonKey(name: 'theme_layout') double? themeLayout,
    required String title,
    required String url,
    @JsonKey(name: 'url_go') required String urlGo,
    bool? used,
    bool? verify,
    Video? video,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RoomActionPayload with _$RoomActionPayload {
  const RoomActionPayload._();

  const factory RoomActionPayload.roomActionPayloadAccessRequestDecided({
    required String user,
  }) = RoomActionPayloadAccessRequestDecided;

  const factory RoomActionPayload.roomActionPayloadAccessRequested({
    required String message,
    required String user,
    @JsonKey(name: 'user_expanded') required RoomUser userExpanded,
  }) = RoomActionPayloadAccessRequested;

  const factory RoomActionPayload.roomActionPayloadAttendingUsersModified({
    required bool attending,
    required String user,
    @JsonKey(name: 'user_expanded') required RoomUser userExpanded,
  }) = RoomActionPayloadAttendingUsersModified;

  const factory RoomActionPayload.roomActionPayloadNotify({
    required String message,
  }) = RoomActionPayloadNotify;

  const factory RoomActionPayload.roomActionPayloadRenew({
    required RoomCredentials credentials,
  }) = RoomActionPayloadRenew;

  const factory RoomActionPayload.roomActionPayloadStageInvited({
    required String message,
    bool? requested,
    required String user,
    @JsonKey(name: 'user_expanded') required RoomUser userExpanded,
  }) = RoomActionPayloadStageInvited;

  const factory RoomActionPayload.roomActionPayloadStageModified({
    required bool staged,
    required double uid,
    required String user,
  }) = RoomActionPayloadStageModified;

  const factory RoomActionPayload.roomActionPayloadStageRequestDecided({
    required String user,
  }) = RoomActionPayloadStageRequestDecided;

  const factory RoomActionPayload.roomActionPayloadStageRequested({
    required String message,
    required String user,
    @JsonKey(name: 'user_expanded') required RoomUser userExpanded,
  }) = RoomActionPayloadStageRequested;

  factory RoomActionPayload.fromJson(Map<String, dynamic> json) =>
      _$RoomActionPayloadFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RoomActionPayloadAccessRequestDecided
    with _$RoomActionPayloadAccessRequestDecided {
  const RoomActionPayloadAccessRequestDecided._();

  const factory RoomActionPayloadAccessRequestDecided({
    required String user,
  }) = _RoomActionPayloadAccessRequestDecided;

  factory RoomActionPayloadAccessRequestDecided.fromJson(
          Map<String, dynamic> json) =>
      _$RoomActionPayloadAccessRequestDecidedFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RoomActionPayloadAccessRequested with _$RoomActionPayloadAccessRequested {
  const RoomActionPayloadAccessRequested._();

  const factory RoomActionPayloadAccessRequested({
    required String message,
    required String user,
    @JsonKey(name: 'user_expanded') required RoomUser userExpanded,
  }) = _RoomActionPayloadAccessRequested;

  factory RoomActionPayloadAccessRequested.fromJson(
          Map<String, dynamic> json) =>
      _$RoomActionPayloadAccessRequestedFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RoomActionPayloadAttendingUsersModified
    with _$RoomActionPayloadAttendingUsersModified {
  const RoomActionPayloadAttendingUsersModified._();

  const factory RoomActionPayloadAttendingUsersModified({
    required bool attending,
    required String user,
    @JsonKey(name: 'user_expanded') required RoomUser userExpanded,
  }) = _RoomActionPayloadAttendingUsersModified;

  factory RoomActionPayloadAttendingUsersModified.fromJson(
          Map<String, dynamic> json) =>
      _$RoomActionPayloadAttendingUsersModifiedFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RoomActionPayloadNotify with _$RoomActionPayloadNotify {
  const RoomActionPayloadNotify._();

  const factory RoomActionPayloadNotify({
    required String message,
  }) = _RoomActionPayloadNotify;

  factory RoomActionPayloadNotify.fromJson(Map<String, dynamic> json) =>
      _$RoomActionPayloadNotifyFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RoomActionPayloadRenew with _$RoomActionPayloadRenew {
  const RoomActionPayloadRenew._();

  const factory RoomActionPayloadRenew({
    required RoomCredentials credentials,
  }) = _RoomActionPayloadRenew;

  factory RoomActionPayloadRenew.fromJson(Map<String, dynamic> json) =>
      _$RoomActionPayloadRenewFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RoomActionPayloadStageInvited with _$RoomActionPayloadStageInvited {
  const RoomActionPayloadStageInvited._();

  const factory RoomActionPayloadStageInvited({
    required String message,
    bool? requested,
    required String user,
    @JsonKey(name: 'user_expanded') required RoomUser userExpanded,
  }) = _RoomActionPayloadStageInvited;

  factory RoomActionPayloadStageInvited.fromJson(Map<String, dynamic> json) =>
      _$RoomActionPayloadStageInvitedFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RoomActionPayloadStageModified with _$RoomActionPayloadStageModified {
  const RoomActionPayloadStageModified._();

  const factory RoomActionPayloadStageModified({
    required bool staged,
    required double uid,
    required String user,
  }) = _RoomActionPayloadStageModified;

  factory RoomActionPayloadStageModified.fromJson(Map<String, dynamic> json) =>
      _$RoomActionPayloadStageModifiedFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RoomActionPayloadStageRequestDecided
    with _$RoomActionPayloadStageRequestDecided {
  const RoomActionPayloadStageRequestDecided._();

  const factory RoomActionPayloadStageRequestDecided({
    required String user,
  }) = _RoomActionPayloadStageRequestDecided;

  factory RoomActionPayloadStageRequestDecided.fromJson(
          Map<String, dynamic> json) =>
      _$RoomActionPayloadStageRequestDecidedFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RoomActionPayloadStageRequested with _$RoomActionPayloadStageRequested {
  const RoomActionPayloadStageRequested._();

  const factory RoomActionPayloadStageRequested({
    required String message,
    required String user,
    @JsonKey(name: 'user_expanded') required RoomUser userExpanded,
  }) = _RoomActionPayloadStageRequested;

  factory RoomActionPayloadStageRequested.fromJson(Map<String, dynamic> json) =>
      _$RoomActionPayloadStageRequestedFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RoomCredentials with _$RoomCredentials {
  const RoomCredentials._();

  const factory RoomCredentials({
    required String token,
    required double uid,
  }) = _RoomCredentials;

  factory RoomCredentials.fromJson(Map<String, dynamic> json) =>
      _$RoomCredentialsFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RoomInput with _$RoomInput {
  const RoomInput._();

  const factory RoomInput({
    @JsonKey(name: 'access_users') List<String>? accessUsers,
    bool? active,
    List<String>? cohosts,
    String? description,
    String? event,
    @JsonKey(name: 'highlight_events') List<String>? highlightEvents,
    @JsonKey(name: 'highlight_rooms') List<String>? highlightRooms,
    @JsonKey(name: 'highlight_stores') List<String>? highlightStores,
    @JsonKey(name: 'highlight_users') List<String>? highlightUsers,
    List<RoomOfferInput>? offers,
    @JsonKey(name: 'payment_direct') bool? paymentDirect,
    List<String>? photos,
    bool? private,
    @JsonKey(name: 'stage_open') bool? stageOpen,
    DateTime? start,
    RoomState? state,
    @JsonKey(name: 'theme_background_photo') String? themeBackgroundPhoto,
    @JsonKey(name: 'theme_color') String? themeColor,
    @JsonKey(name: 'theme_layout') double? themeLayout,
    String? title,
    bool? verify,
    VideoInput? video,
  }) = _RoomInput;

  factory RoomInput.fromJson(Map<String, dynamic> json) =>
      _$RoomInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RoomOffer with _$RoomOffer {
  const RoomOffer._();

  const factory RoomOffer({
    @JsonKey(name: '_id') String? id,
    double? position,
    required OfferProvider provider,
    @JsonKey(name: 'provider_id') required String providerId,
    @JsonKey(name: 'provider_network') required String providerNetwork,
  }) = _RoomOffer;

  factory RoomOffer.fromJson(Map<String, dynamic> json) =>
      _$RoomOfferFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RoomOfferInput with _$RoomOfferInput {
  const RoomOfferInput._();

  const factory RoomOfferInput({
    @JsonKey(name: '_id') String? id,
    double? position,
    OfferProvider? provider,
    @JsonKey(name: 'provider_id') String? providerId,
    @JsonKey(name: 'provider_network') String? providerNetwork,
  }) = _RoomOfferInput;

  factory RoomOfferInput.fromJson(Map<String, dynamic> json) =>
      _$RoomOfferInputFromJson(json);
}

enum RoomState {
  ended,
  scheduled,
  started,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class RoomUser with _$RoomUser {
  const RoomUser._();

  const factory RoomUser({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'image_avatar') String? imageAvatar,
    String? name,
    String? username,
  }) = _RoomUser;

  factory RoomUser.fromJson(Map<String, dynamic> json) =>
      _$RoomUserFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class SafeAccount with _$SafeAccount {
  const SafeAccount._();

  const factory SafeAccount({
    required String address,
    required List<String> currencies,
    @JsonKey(name: 'currency_map') Map<String, dynamic>? currencyMap,
    @JsonKey(name: 'gelato_task_id') String? gelatoTaskId,
    required String network,
    required List<String> owners,
    bool? pending,
    required double threshold,
  }) = _SafeAccount;

  factory SafeAccount.fromJson(Map<String, dynamic> json) =>
      _$SafeAccountFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class SalesTax with _$SalesTax {
  const SalesTax._();

  const factory SalesTax({
    @JsonKey(name: '_id') required String id,
    List<String>? countries,
    @JsonKey(name: 'flat_map') Map<String, dynamic>? flatMap,
    String? name,
    @JsonKey(name: 'ratio_map') Map<String, dynamic>? ratioMap,
    List<String>? regions,
    required SalesTaxType type,
  }) = _SalesTax;

  factory SalesTax.fromJson(Map<String, dynamic> json) =>
      _$SalesTaxFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class SalesTaxInput with _$SalesTaxInput {
  const SalesTaxInput._();

  const factory SalesTaxInput({
    @JsonKey(name: '_id') required String id,
    List<String>? countries,
    @JsonKey(name: 'flat_map') Map<String, dynamic>? flatMap,
    String? name,
    @JsonKey(name: 'ratio_map') Map<String, dynamic>? ratioMap,
    List<String>? regions,
    required SalesTaxType type,
  }) = _SalesTaxInput;

  factory SalesTaxInput.fromJson(Map<String, dynamic> json) =>
      _$SalesTaxInputFromJson(json);
}

enum SalesTaxType {
  country,
  region,
  worldwide,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class SendRoomInviteInput with _$SendRoomInviteInput {
  const SendRoomInviteInput._();

  const factory SendRoomInviteInput({
    @JsonKey(name: '_id') required String id,
    required List<String> users,
  }) = _SendRoomInviteInput;

  factory SendRoomInviteInput.fromJson(Map<String, dynamic> json) =>
      _$SendRoomInviteInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Site with _$Site {
  const Site._();

  const factory Site({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'access_pass') AccessPass? accessPass,
    required bool active,
    @JsonKey(name: 'ai_config') String? aiConfig,
    required String client,
    List<SiteDao>? daos,
    required String description,
    String? event,
    @JsonKey(name: 'favicon_url') String? faviconUrl,
    @JsonKey(name: 'footer_scripts') List<SiteFooterScript>? footerScripts,
    @JsonKey(name: 'header_links') List<SiteHeaderLink>? headerLinks,
    @JsonKey(name: 'header_metas') List<SiteHeaderMeta>? headerMetas,
    List<String>? hostnames,
    @JsonKey(name: 'logo_mobile_url') String? logoMobileUrl,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'onboarding_steps')
    List<SiteOnboardingStep>? onboardingSteps,
    List<String>? owners,
    List<String>? partners,
    SitePassport? passport,
    @JsonKey(name: 'privacy_url') String? privacyUrl,
    @JsonKey(name: 'share_url') Map<String, dynamic>? shareUrl,
    Map<String, dynamic>? text,
    @JsonKey(name: 'theme_data') Map<String, dynamic>? themeData,
    @JsonKey(name: 'theme_type') String? themeType,
    required String title,
    String? user,
    @JsonKey(name: 'user_expanded') User? userExpanded,
    Map<String, dynamic>? visibility,
  }) = _Site;

  factory Site.fromJson(Map<String, dynamic> json) => _$SiteFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class SiteDao with _$SiteDao {
  const SiteDao._();

  const factory SiteDao({
    required String address,
    String? icon,
    required String name,
    required String network,
  }) = _SiteDao;

  factory SiteDao.fromJson(Map<String, dynamic> json) =>
      _$SiteDaoFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class SiteFooterScript with _$SiteFooterScript {
  const SiteFooterScript._();

  const factory SiteFooterScript({
    String? children,
    String? id,
    String? src,
    SiteFooterScriptStrategy? strategy,
  }) = _SiteFooterScript;

  factory SiteFooterScript.fromJson(Map<String, dynamic> json) =>
      _$SiteFooterScriptFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class SiteFooterScriptInput with _$SiteFooterScriptInput {
  const SiteFooterScriptInput._();

  const factory SiteFooterScriptInput({
    String? children,
    String? id,
    String? src,
    SiteFooterScriptStrategy? strategy,
  }) = _SiteFooterScriptInput;

  factory SiteFooterScriptInput.fromJson(Map<String, dynamic> json) =>
      _$SiteFooterScriptInputFromJson(json);
}

enum SiteFooterScriptStrategy {
  @JsonKey(name: 'AfterInteractive')
  afterInteractive,
  @JsonKey(name: 'BeforeInteractive')
  beforeInteractive,
  @JsonKey(name: 'LazyOnload')
  lazyOnload,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class SiteHeaderLink with _$SiteHeaderLink {
  const SiteHeaderLink._();

  const factory SiteHeaderLink({
    String? href,
    SiteHeaderLinkRel? rel,
  }) = _SiteHeaderLink;

  factory SiteHeaderLink.fromJson(Map<String, dynamic> json) =>
      _$SiteHeaderLinkFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class SiteHeaderLinkInput with _$SiteHeaderLinkInput {
  const SiteHeaderLinkInput._();

  const factory SiteHeaderLinkInput({
    String? href,
    SiteHeaderLinkRel? rel,
  }) = _SiteHeaderLinkInput;

  factory SiteHeaderLinkInput.fromJson(Map<String, dynamic> json) =>
      _$SiteHeaderLinkInputFromJson(json);
}

enum SiteHeaderLinkRel {
  @JsonKey(name: 'Icon')
  icon,
  @JsonKey(name: 'Stylesheet')
  stylesheet,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class SiteHeaderMeta with _$SiteHeaderMeta {
  const SiteHeaderMeta._();

  const factory SiteHeaderMeta({
    String? content,
    String? key,
    String? name,
    String? property,
  }) = _SiteHeaderMeta;

  factory SiteHeaderMeta.fromJson(Map<String, dynamic> json) =>
      _$SiteHeaderMetaFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class SiteHeaderMetaInput with _$SiteHeaderMetaInput {
  const SiteHeaderMetaInput._();

  const factory SiteHeaderMetaInput({
    String? content,
    String? key,
    String? name,
    String? property,
  }) = _SiteHeaderMetaInput;

  factory SiteHeaderMetaInput.fromJson(Map<String, dynamic> json) =>
      _$SiteHeaderMetaInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class SiteOnboardingStep with _$SiteOnboardingStep {
  const SiteOnboardingStep._();

  const factory SiteOnboardingStep({
    Map<String, dynamic>? data,
    required SiteOnboardingStepName name,
  }) = _SiteOnboardingStep;

  factory SiteOnboardingStep.fromJson(Map<String, dynamic> json) =>
      _$SiteOnboardingStepFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class SiteOnboardingStepInput with _$SiteOnboardingStepInput {
  const SiteOnboardingStepInput._();

  const factory SiteOnboardingStepInput({
    Map<String, dynamic>? data,
    required SiteOnboardingStepName name,
  }) = _SiteOnboardingStepInput;

  factory SiteOnboardingStepInput.fromJson(Map<String, dynamic> json) =>
      _$SiteOnboardingStepInputFromJson(json);
}

enum SiteOnboardingStepName {
  @JsonKey(name: 'About')
  about,
  @JsonKey(name: 'AdultCheck')
  adultCheck,
  @JsonKey(name: 'Biography')
  biography,
  @JsonKey(name: 'ConditionsCheck')
  conditionsCheck,
  @JsonKey(name: 'Custom')
  custom,
  @JsonKey(name: 'DisplayName')
  displayName,
  @JsonKey(name: 'Done')
  done,
  @JsonKey(name: 'Feeds')
  feeds,
  @JsonKey(name: 'Interests')
  interests,
  @JsonKey(name: 'Job')
  job,
  @JsonKey(name: 'Photo')
  photo,
  @JsonKey(name: 'SocialHandles')
  socialHandles,
  @JsonKey(name: 'Username')
  username,
  @JsonKey(name: 'Wallet')
  wallet,
  @JsonKey(name: 'WalletInput')
  walletInput,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class SitePassport with _$SitePassport {
  const SitePassport._();

  const factory SitePassport({
    required String baseV1Address,
    required double baseV1ChainId,
    Map<String, dynamic>? crowdfundAddress,
    required String image,
    required String logo,
    required String name,
    Map<String, dynamic>? passportV1AxelarAddress,
    required String passportV1CallAddress,
  }) = _SitePassport;

  factory SitePassport.fromJson(Map<String, dynamic> json) =>
      _$SitePassportFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Store with _$Store {
  const Store._();

  const factory Store({
    @JsonKey(name: '_id') required String id,
    required bool active,
    Address? address,
    @JsonKey(name: 'age_restriction_min') double? ageRestrictionMin,
    @JsonKey(name: 'age_restriction_reason') String? ageRestrictionReason,
    @JsonKey(name: 'api_secret') String? apiSecret,
    bool? approved,
    required String currency,
    @JsonKey(name: 'delivery_options') List<DeliveryOption>? deliveryOptions,
    @JsonKey(name: 'easyship_company_id') String? easyshipCompanyId,
    @JsonKey(name: 'easyship_enabled') bool? easyshipEnabled,
    @JsonKey(name: 'easyship_secret_key') String? easyshipSecretKey,
    @JsonKey(name: 'easyship_token') String? easyshipToken,
    @JsonKey(name: 'fulfillment_addresses')
    required List<Address> fulfillmentAddresses,
    required List<String> managers,
    @JsonKey(name: 'managers_expanded') List<User?>? managersExpanded,
    @JsonKey(name: 'new_photos') required List<String> newPhotos,
    @JsonKey(name: 'new_photos_expanded') List<File?>? newPhotosExpanded,
    @JsonKey(name: 'order_count') double? orderCount,
    @JsonKey(name: 'payment_fee_store') required double paymentFeeStore,
    @JsonKey(name: 'payment_fee_user') required double paymentFeeUser,
    List<FileInline>? photos,
    @JsonKey(name: 'pickup_addresses') List<Address>? pickupAddresses,
    List<StorePromotion?>? promotions,
    @JsonKey(name: 'sales_taxes') List<SalesTax>? salesTaxes,
    required DateTime stamp,
    List<String>? tags,
    required String title,
    required String user,
    @JsonKey(name: 'user_expanded') User? userExpanded,
  }) = _Store;

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StoreBucketItem with _$StoreBucketItem {
  const StoreBucketItem._();

  const factory StoreBucketItem({
    @JsonKey(name: '_id') required String id,
    required bool active,
    required double count,
    required String product,
    @JsonKey(name: 'product_expanded') StoreProduct? productExpanded,
    @JsonKey(name: 'product_groups')
    required Map<String, dynamic> productGroups,
    @JsonKey(name: 'product_variant') required String productVariant,
    required DateTime stamp,
    required String store,
    @JsonKey(name: 'store_expanded') Store? storeExpanded,
    required String user,
  }) = _StoreBucketItem;

  factory StoreBucketItem.fromJson(Map<String, dynamic> json) =>
      _$StoreBucketItemFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StoreBucketItemInput with _$StoreBucketItemInput {
  const StoreBucketItemInput._();

  const factory StoreBucketItemInput({
    required double count,
    required String product,
    @JsonKey(name: 'product_groups')
    required Map<String, dynamic> productGroups,
    @JsonKey(name: 'product_variant') required String productVariant,
  }) = _StoreBucketItemInput;

  factory StoreBucketItemInput.fromJson(Map<String, dynamic> json) =>
      _$StoreBucketItemInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StoreCategory with _$StoreCategory {
  const StoreCategory._();

  const factory StoreCategory({
    @JsonKey(name: '_id') required String id,
    required bool active,
    String? description,
    List<String>? parents,
    required DateTime stamp,
    required String store,
    required String title,
  }) = _StoreCategory;

  factory StoreCategory.fromJson(Map<String, dynamic> json) =>
      _$StoreCategoryFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StoreCategoryInput with _$StoreCategoryInput {
  const StoreCategoryInput._();

  const factory StoreCategoryInput({
    String? description,
    List<String>? parents,
    String? title,
  }) = _StoreCategoryInput;

  factory StoreCategoryInput.fromJson(Map<String, dynamic> json) =>
      _$StoreCategoryInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StoreInput with _$StoreInput {
  const StoreInput._();

  const factory StoreInput({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'age_restriction_min') double? ageRestrictionMin,
    @JsonKey(name: 'age_restriction_reason') String? ageRestrictionReason,
    @JsonKey(name: 'api_secret') String? apiSecret,
    String? currency,
    @JsonKey(name: 'delivery_options')
    List<DeliveryOptionInput>? deliveryOptions,
    @JsonKey(name: 'easyship_company_id') String? easyshipCompanyId,
    @JsonKey(name: 'easyship_enabled') bool? easyshipEnabled,
    @JsonKey(name: 'easyship_secret_key') String? easyshipSecretKey,
    @JsonKey(name: 'easyship_token') String? easyshipToken,
    List<String>? managers,
    @JsonKey(name: 'new_photos') List<String>? newPhotos,
    List<FileInlineInput>? photos,
    @JsonKey(name: 'sales_taxes') List<SalesTaxInput>? salesTaxes,
    List<String>? tags,
    String? title,
  }) = _StoreInput;

  factory StoreInput.fromJson(Map<String, dynamic> json) =>
      _$StoreInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StoreOrder with _$StoreOrder {
  const StoreOrder._();

  const factory StoreOrder({
    @JsonKey(name: '_id') String? id,
    required bool active,
    required Address address,
    required double amount,
    required String currency,
    @JsonKey(name: 'delivery_cost') required double deliveryCost,
    @JsonKey(name: 'delivery_option') required DeliveryOption deliveryOption,
    @JsonKey(name: 'delivery_option_cost_waived')
    bool? deliveryOptionCostWaived,
    @JsonKey(name: 'easyship_courier_id') String? easyshipCourierId,
    @JsonKey(name: 'easyship_rates') List<Map<String, dynamic>>? easyshipRates,
    @JsonKey(name: 'easyship_selected_courier')
    Map<String, dynamic>? easyshipSelectedCourier,
    @JsonKey(name: 'easyship_shipment_id') String? easyshipShipmentId,
    @JsonKey(name: 'fulfillment_address') Address? fulfillmentAddress,
    List<StoreOrderHistoryItem>? history,
    required List<StoreOrderItem> items,
    @JsonKey(name: 'label_error') String? labelError,
    @JsonKey(name: 'label_state') String? labelState,
    @JsonKey(name: 'label_url') String? labelUrl,
    @JsonKey(name: 'order_nr') required double orderNr,
    @JsonKey(name: 'pickup_address') Address? pickupAddress,
    String? promotion,
    @JsonKey(name: 'sales_tax') SalesTax? salesTax,
    required DateTime stamp,
    @JsonKey(name: 'stamp_created') required DateTime stampCreated,
    required StoreOrderState state,
    required String store,
    @JsonKey(name: 'store_expanded') Store? storeExpanded,
    @JsonKey(name: 'tracking_url') String? trackingUrl,
    required String user,
    @JsonKey(name: 'user_expanded') User? userExpanded,
    required double value,
  }) = _StoreOrder;

  factory StoreOrder.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StoreOrderHistoryItem with _$StoreOrderHistoryItem {
  const StoreOrderHistoryItem._();

  const factory StoreOrderHistoryItem({
    required DateTime stamp,
    required String state,
    String? user,
    @JsonKey(name: 'user_expanded') User? userExpanded,
  }) = _StoreOrderHistoryItem;

  factory StoreOrderHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderHistoryItemFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StoreOrderInput with _$StoreOrderInput {
  const StoreOrderInput._();

  const factory StoreOrderInput({
    required List<StoreOrderItemInput> items,
    required StoreOrderState state,
  }) = _StoreOrderInput;

  factory StoreOrderInput.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StoreOrderItem with _$StoreOrderItem {
  const StoreOrderItem._();

  const factory StoreOrderItem({
    @JsonKey(name: '_id') required String id,
    required double amount,
    required double count,
    @JsonKey(name: 'delivery_cost') double? deliveryCost,
    @JsonKey(name: 'delivery_option') DeliveryOption? deliveryOption,
    @JsonKey(name: 'delivery_option_cost_waived')
    bool? deliveryOptionCostWaived,
    double? fee,
    double? inventory,
    required StoreProduct product,
    @JsonKey(name: 'product_groups')
    required Map<String, dynamic> productGroups,
    @JsonKey(name: 'product_variant') required String productVariant,
    double? promotion,
    @JsonKey(name: 'promotion_amount') double? promotionAmount,
    required StoreOrderItemState state,
    double? tax,
    @JsonKey(name: 'tracking_url') String? trackingUrl,
    required double value,
  }) = _StoreOrderItem;

  factory StoreOrderItem.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderItemFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StoreOrderItemInput with _$StoreOrderItemInput {
  const StoreOrderItemInput._();

  const factory StoreOrderItemInput({
    @JsonKey(name: '_id') required String id,
    required double amount,
    @JsonKey(name: 'delivery_cost') double? deliveryCost,
    @JsonKey(name: 'delivery_option') DeliveryOptionInput? deliveryOption,
    @JsonKey(name: 'delivery_option_cost_waived')
    bool? deliveryOptionCostWaived,
    double? inventory,
    required StoreOrderItemState state,
    double? tax,
    @JsonKey(name: 'tracking_url') String? trackingUrl,
  }) = _StoreOrderItemInput;

  factory StoreOrderItemInput.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderItemInputFromJson(json);
}

enum StoreOrderItemState {
  accepted,
  declined,
  pending,
}

enum StoreOrderState {
  accepted,
  @JsonKey(name: 'awaiting_pickup')
  awaitingPickup,
  cancelled,
  created,
  declined,
  delivered,
  @JsonKey(name: 'delivery_confirmed')
  deliveryConfirmed,
  @JsonKey(name: 'in_transit')
  inTransit,
  pending,
  preparing,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StoreOrderStateFilterInput with _$StoreOrderStateFilterInput {
  const StoreOrderStateFilterInput._();

  const factory StoreOrderStateFilterInput({
    StoreOrderState? eq,
    @JsonKey(name: 'in') List<StoreOrderState>? in_,
    List<StoreOrderState>? nin,
  }) = _StoreOrderStateFilterInput;

  factory StoreOrderStateFilterInput.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderStateFilterInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StoreProduct with _$StoreProduct {
  const StoreProduct._();

  const factory StoreProduct({
    @JsonKey(name: '_id') required String id,
    required bool active,
    List<String>? categories,
    @JsonKey(name: 'delivery_options') List<DeliveryOption>? deliveryOptions,
    required String description,
    @JsonKey(name: 'easyship_category') EasyshipCategory? easyshipCategory,
    Map<String, dynamic>? groups,
    bool? highlight,
    required double order,
    @JsonKey(name: 'primary_group') String? primaryGroup,
    @JsonKey(name: 'sales_tax_tag') String? salesTaxTag,
    required DateTime stamp,
    required String store,
    @JsonKey(name: 'store_expanded') Store? storeExpanded,
    required String title,
    required List<StoreProductVariant> variants,
  }) = _StoreProduct;

  factory StoreProduct.fromJson(Map<String, dynamic> json) =>
      _$StoreProductFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StoreProductInput with _$StoreProductInput {
  const StoreProductInput._();

  const factory StoreProductInput({
    @JsonKey(name: '_id') String? id,
    List<String>? categories,
    @JsonKey(name: 'delivery_options')
    List<DeliveryOptionInput>? deliveryOptions,
    String? description,
    @JsonKey(name: 'easyship_category') EasyshipCategory? easyshipCategory,
    bool? highlight,
    double? order,
    @JsonKey(name: 'primary_group') String? primaryGroup,
    @JsonKey(name: 'sales_tax_tag') String? salesTaxTag,
    String? title,
  }) = _StoreProductInput;

  factory StoreProductInput.fromJson(Map<String, dynamic> json) =>
      _$StoreProductInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StoreProductVariant with _$StoreProductVariant {
  const StoreProductVariant._();

  const factory StoreProductVariant({
    @JsonKey(name: '_id') required String id,
    required double cost,
    required Map<String, dynamic> groups,
    required double height,
    double? inventory,
    required double length,
    @JsonKey(name: 'new_photos') List<String>? newPhotos,
    @JsonKey(name: 'new_photos_expanded') List<File?>? newPhotosExpanded,
    List<FileInline>? photos,
    required String title,
    required double weight,
    required double width,
  }) = _StoreProductVariant;

  factory StoreProductVariant.fromJson(Map<String, dynamic> json) =>
      _$StoreProductVariantFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StoreProductVariantInput with _$StoreProductVariantInput {
  const StoreProductVariantInput._();

  const factory StoreProductVariantInput({
    @JsonKey(name: '_id') String? id,
    double? cost,
    Map<String, dynamic>? groups,
    double? height,
    double? inventory,
    double? length,
    @JsonKey(name: 'new_photos') List<String>? newPhotos,
    List<FileInlineInput>? photos,
    String? title,
    double? weight,
    double? width,
  }) = _StoreProductVariantInput;

  factory StoreProductVariantInput.fromJson(Map<String, dynamic> json) =>
      _$StoreProductVariantInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StorePromotion with _$StorePromotion {
  const StorePromotion._();

  const factory StorePromotion({
    @JsonKey(name: '_id') required String id,
    required bool active,
    String? event,
    List<String>? products,
    @JsonKey(name: 'products_expanded') List<StoreProduct?>? productsExpanded,
    required double ratio,
    required String title,
    required StorePromotionType type,
    @JsonKey(name: 'use_count') double? useCount,
    @JsonKey(name: 'use_count_map') Map<String, dynamic>? useCountMap,
    @JsonKey(name: 'use_limit') double? useLimit,
    @JsonKey(name: 'use_limit_per') double? useLimitPer,
    @JsonKey(name: 'waive_delivery_option_cost') bool? waiveDeliveryOptionCost,
  }) = _StorePromotion;

  factory StorePromotion.fromJson(Map<String, dynamic> json) =>
      _$StorePromotionFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StorePromotionInput with _$StorePromotionInput {
  const StorePromotionInput._();

  const factory StorePromotionInput({
    String? event,
    List<String>? products,
    double? ratio,
    String? title,
    StorePromotionType? type,
    @JsonKey(name: 'use_limit') double? useLimit,
    @JsonKey(name: 'use_limit_per') double? useLimitPer,
  }) = _StorePromotionInput;

  factory StorePromotionInput.fromJson(Map<String, dynamic> json) =>
      _$StorePromotionInputFromJson(json);
}

enum StorePromotionType {
  event,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StripeAccount with _$StripeAccount {
  const StripeAccount._();

  const factory StripeAccount({
    @JsonKey(name: 'account_id') required String accountId,
    required List<String> currencies,
    @JsonKey(name: 'currency_map') Map<String, dynamic>? currencyMap,
    @JsonKey(name: 'publishable_key') required String publishableKey,
  }) = _StripeAccount;

  factory StripeAccount.fromJson(Map<String, dynamic> json) =>
      _$StripeAccountFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StripeCard with _$StripeCard {
  const StripeCard._();

  const factory StripeCard({
    @JsonKey(name: '_id') required String id,
    required bool active,
    required String brand,
    required String last4,
    required String name,
    @JsonKey(name: 'payment_account') required String paymentAccount,
    @JsonKey(name: 'provider_id') required String providerId,
    required DateTime stamp,
    required String user,
  }) = _StripeCard;

  factory StripeCard.fromJson(Map<String, dynamic> json) =>
      _$StripeCardFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class StripeOnrampSession with _$StripeOnrampSession {
  const StripeOnrampSession._();

  const factory StripeOnrampSession({
    @JsonKey(name: 'client_secret') required String clientSecret,
    @JsonKey(name: 'publishable_key') required String publishableKey,
  }) = _StripeOnrampSession;

  factory StripeOnrampSession.fromJson(Map<String, dynamic> json) =>
      _$StripeOnrampSessionFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Ticket with _$Ticket {
  const Ticket._();

  const factory Ticket({
    @JsonKey(name: '_id') required String id,
    bool? accepted,
    @JsonKey(name: 'assigned_email') String? assignedEmail,
    @JsonKey(name: 'assigned_to') String? assignedTo,
    @JsonKey(name: 'assigned_to_expanded') User? assignedToExpanded,
    required String event,
    @JsonKey(name: 'invited_by') String? invitedBy,
    required String type,
  }) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class TicketAssignee with _$TicketAssignee {
  const TicketAssignee._();

  const factory TicketAssignee({
    String? email,
    required String ticket,
    String? user,
  }) = _TicketAssignee;

  factory TicketAssignee.fromJson(Map<String, dynamic> json) =>
      _$TicketAssigneeFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class TicketBase with _$TicketBase {
  const TicketBase._();

  const factory TicketBase({
    @JsonKey(name: '_id') required String id,
    bool? accepted,
    @JsonKey(name: 'assigned_email') String? assignedEmail,
    @JsonKey(name: 'assigned_to') String? assignedTo,
    required String event,
    @JsonKey(name: 'invited_by') String? invitedBy,
    required String type,
  }) = _TicketBase;

  factory TicketBase.fromJson(Map<String, dynamic> json) =>
      _$TicketBaseFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class TicketDiscount with _$TicketDiscount {
  const TicketDiscount._();

  const factory TicketDiscount({
    required String discount,
    required double limit,
    required double ratio,
  }) = _TicketDiscount;

  factory TicketDiscount.fromJson(Map<String, dynamic> json) =>
      _$TicketDiscountFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class TicketInfo with _$TicketInfo {
  const TicketInfo._();

  const factory TicketInfo({
    required double count,
    @JsonKey(name: 'ticket_type') required String ticketType,
  }) = _TicketInfo;

  factory TicketInfo.fromJson(Map<String, dynamic> json) =>
      _$TicketInfoFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class ToggleBlockUserInput with _$ToggleBlockUserInput {
  const ToggleBlockUserInput._();

  const factory ToggleBlockUserInput({
    required bool block,
    required String user,
  }) = _ToggleBlockUserInput;

  factory ToggleBlockUserInput.fromJson(Map<String, dynamic> json) =>
      _$ToggleBlockUserInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Token with _$Token {
  const Token._();

  const factory Token({
    bool? active,
    required String contract,
    required double decimals,
    @JsonKey(name: 'logo_url') String? logoUrl,
    required String name,
    required String symbol,
  }) = _Token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UpdateBadgeInput with _$UpdateBadgeInput {
  const UpdateBadgeInput._();

  const factory UpdateBadgeInput({
    String? contract,
    String? network,
  }) = _UpdateBadgeInput;

  factory UpdateBadgeInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateBadgeInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UpdateBadgeListInput with _$UpdateBadgeListInput {
  const UpdateBadgeListInput._();

  const factory UpdateBadgeListInput({
    @JsonKey(name: 'image_url') String? imageUrl,
    String? title,
  }) = _UpdateBadgeListInput;

  factory UpdateBadgeListInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateBadgeListInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UpdateEventBroadcastInput with _$UpdateEventBroadcastInput {
  const UpdateEventBroadcastInput._();

  const factory UpdateEventBroadcastInput({
    String? description,
    double? position,
    List<String>? rooms,
    String? thumbnail,
  }) = _UpdateEventBroadcastInput;

  factory UpdateEventBroadcastInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateEventBroadcastInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UpdateEventCheckinInput with _$UpdateEventCheckinInput {
  const UpdateEventCheckinInput._();

  const factory UpdateEventCheckinInput({
    required bool active,
    required String event,
    required String user,
  }) = _UpdateEventCheckinInput;

  factory UpdateEventCheckinInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateEventCheckinInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UpdateEventRewardUseInput with _$UpdateEventRewardUseInput {
  const UpdateEventRewardUseInput._();

  const factory UpdateEventRewardUseInput({
    required bool active,
    required String event,
    @JsonKey(name: 'reward_id') required String rewardId,
    @JsonKey(name: 'reward_number') required double rewardNumber,
    required String user,
  }) = _UpdateEventRewardUseInput;

  factory UpdateEventRewardUseInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateEventRewardUseInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UpdateNewPaymentAccountInput with _$UpdateNewPaymentAccountInput {
  const UpdateNewPaymentAccountInput._();

  const factory UpdateNewPaymentAccountInput({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'account_info') required Map<String, dynamic> accountInfo,
    String? title,
  }) = _UpdateNewPaymentAccountInput;

  factory UpdateNewPaymentAccountInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateNewPaymentAccountInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UpdatePaymentInput with _$UpdatePaymentInput {
  const UpdatePaymentInput._();

  const factory UpdatePaymentInput({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'transfer_params') Map<String, dynamic>? transferParams,
  }) = _UpdatePaymentInput;

  factory UpdatePaymentInput.fromJson(Map<String, dynamic> json) =>
      _$UpdatePaymentInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UpdatePostInput with _$UpdatePostInput {
  const UpdatePostInput._();

  const factory UpdatePostInput({
    bool? published,
    PostVisibility? visibility,
  }) = _UpdatePostInput;

  factory UpdatePostInput.fromJson(Map<String, dynamic> json) =>
      _$UpdatePostInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UpdateSiteInput with _$UpdateSiteInput {
  const UpdateSiteInput._();

  const factory UpdateSiteInput({
    @JsonKey(name: 'access_pass') AccessPassInput? accessPass,
    bool? active,
    @JsonKey(name: 'ai_config') String? aiConfig,
    String? client,
    String? description,
    String? event,
    @JsonKey(name: 'favicon_url') String? faviconUrl,
    @JsonKey(name: 'footer_scripts') List<SiteFooterScriptInput>? footerScripts,
    @JsonKey(name: 'header_links') List<SiteHeaderLinkInput>? headerLinks,
    @JsonKey(name: 'header_metas') List<SiteHeaderMetaInput>? headerMetas,
    List<String>? hostnames,
    @JsonKey(name: 'logo_mobile_url') String? logoMobileUrl,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'onboarding_steps')
    List<SiteOnboardingStepInput>? onboardingSteps,
    List<String>? owners,
    List<String>? partners,
    @JsonKey(name: 'privacy_url') String? privacyUrl,
    @JsonKey(name: 'share_url') Map<String, dynamic>? shareUrl,
    Map<String, dynamic>? text,
    @JsonKey(name: 'theme_data') Map<String, dynamic>? themeData,
    @JsonKey(name: 'theme_type') String? themeType,
    String? title,
    Map<String, dynamic>? visibility,
  }) = _UpdateSiteInput;

  factory UpdateSiteInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateSiteInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UpdateStoreBucketItemInput with _$UpdateStoreBucketItemInput {
  const UpdateStoreBucketItemInput._();

  const factory UpdateStoreBucketItemInput({
    required double count,
  }) = _UpdateStoreBucketItemInput;

  factory UpdateStoreBucketItemInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateStoreBucketItemInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class User with _$User {
  const User._();

  const factory User({
    @JsonKey(name: '_id') String? id,
    required bool active,
    List<Address>? addresses,
    double? age,
    double? attended,
    List<String>? blocked,
    @JsonKey(name: 'blocked_expanded') List<User?>? blockedExpanded,
    @JsonKey(name: 'calendly_url') String? calendlyUrl,
    @JsonKey(name: 'company_address') Address? companyAddress,
    @JsonKey(name: 'company_name') String? companyName,
    String? country,
    String? cover,
    @JsonKey(name: 'cover_expanded') File? coverExpanded,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    String? currency,
    List<UserDao>? daos,
    Map<String, dynamic>? data,
    @JsonKey(name: 'date_of_birth') DateTime? dateOfBirth,
    String? description,
    @JsonKey(name: 'discord_user_info') Map<String, dynamic>? discordUserInfo,
    UserDiscoverySettings? discovery,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'education_title') String? educationTitle,
    String? email,
    @JsonKey(name: 'email_marketing') bool? emailMarketing,
    @JsonKey(name: 'email_verified') bool? emailVerified,
    String? ethnicity,
    @JsonKey(name: 'eventbrite_user_info')
    Map<String, dynamic>? eventbriteUserInfo,
    List<String>? events,
    @JsonKey(name: 'events_expanded') List<Event?>? eventsExpanded,
    @JsonKey(name: 'fcm_tokens') List<String>? fcmTokens,
    @JsonKey(name: 'first_name') String? firstName,
    double? followers,
    double? following,
    @JsonKey(name: 'frequent_questions')
    List<FrequentQuestion>? frequentQuestions,
    double? friends,
    @JsonKey(name: 'google_user_info') Map<String, dynamic>? googleUserInfo,
    @JsonKey(name: 'handle_facebook') String? handleFacebook,
    @JsonKey(name: 'handle_github') String? handleGithub,
    @JsonKey(name: 'handle_instagram') String? handleInstagram,
    @JsonKey(name: 'handle_linkedin') String? handleLinkedin,
    @JsonKey(name: 'handle_twitter') String? handleTwitter,
    double? hosted,
    List<UserIcebreaker>? icebreakers,
    @JsonKey(name: 'image_avatar') String? imageAvatar,
    String? industry,
    List<String>? interests,
    @JsonKey(name: 'job_title') String? jobTitle,
    List<String>? languages,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'layout_sections') List<LayoutSection>? layoutSections,
    @JsonKey(name: 'lemon_amount') required double lemonAmount,
    @JsonKey(name: 'lemon_cap') required double lemonCap,
    @JsonKey(name: 'lemon_refresh_at') DateTime? lemonRefreshAt,
    @JsonKey(name: 'location_line') String? locationLine,
    @JsonKey(name: 'matrix_localpart') String? matrixLocalpart,
    @JsonKey(name: 'matrix_support_room_id') String? matrixSupportRoomId,
    List<String>? music,
    required String name,
    @JsonKey(name: 'new_gender') String? newGender,
    @JsonKey(name: 'new_photos') List<String>? newPhotos,
    @JsonKey(name: 'new_photos_expanded') List<File?>? newPhotosExpanded,
    @JsonKey(name: 'notification_filters')
    List<Map<String, dynamic>>? notificationFilters,
    List<UserOffer>? offers,
    @JsonKey(name: 'payment_verification')
    UserPaymentVerification? paymentVerification,
    String? phone,
    @JsonKey(name: 'phone_verified') bool? phoneVerified,
    double? posts,
    @JsonKey(name: 'preferred_network') String? preferredNetwork,
    String? pronoun,
    @JsonKey(name: 'razorpay_customer') String? razorpayCustomer,
    @JsonKey(name: 'search_range') double? searchRange,
    Map<String, dynamic>? settings,
    @JsonKey(name: 'shopify_user_info') Map<String, dynamic>? shopifyUserInfo,
    @JsonKey(name: 'stripe_user_info') Map<String, dynamic>? stripeUserInfo,
    @JsonKey(name: 'tag_recommended') bool? tagRecommended,
    @JsonKey(name: 'tag_site') bool? tagSite,
    @JsonKey(name: 'tag_support') bool? tagSupport,
    @JsonKey(name: 'tag_timeline') bool? tagTimeline,
    @JsonKey(name: 'tag_verified') bool? tagVerified,
    String? tagline,
    @JsonKey(name: 'terms_accepted_adult') bool? termsAcceptedAdult,
    @JsonKey(name: 'terms_accepted_conditions') bool? termsAcceptedConditions,
    String? timezone,
    @JsonKey(name: 'twitch_user_info') Map<String, dynamic>? twitchUserInfo,
    @JsonKey(name: 'twitter2_user_info') Map<String, dynamic>? twitter2UserInfo,
    @JsonKey(name: 'twitter_user_info') Map<String, dynamic>? twitterUserInfo,
    UserType? type,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    String? url,
    @JsonKey(name: 'url_go') String? urlGo,
    String? username,
    bool? verified,
    @JsonKey(name: 'wallet_custodial') String? walletCustodial,
    List<String>? wallets,
    @JsonKey(name: 'zoom_user_info') Map<String, dynamic>? zoomUserInfo,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserContact with _$UserContact {
  const UserContact._();

  const factory UserContact({
    @JsonKey(name: '_id') required String id,
    String? contact,
    @JsonKey(name: 'contact_expanded') User? contactExpanded,
    @JsonKey(name: 'converted_at') DateTime? convertedAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    String? email,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'invited_at') DateTime? invitedAt,
    @JsonKey(name: 'invited_count') double? invitedCount,
    @JsonKey(name: 'last_name') String? lastName,
    String? phone,
    List<String>? tags,
    required String user,
  }) = _UserContact;

  factory UserContact.fromJson(Map<String, dynamic> json) =>
      _$UserContactFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserDao with _$UserDao {
  const UserDao._();

  const factory UserDao({
    required String address,
    required String network,
  }) = _UserDao;

  factory UserDao.fromJson(Map<String, dynamic> json) =>
      _$UserDaoFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserDaoInput with _$UserDaoInput {
  const UserDaoInput._();

  const factory UserDaoInput({
    required String address,
    required String network,
  }) = _UserDaoInput;

  factory UserDaoInput.fromJson(Map<String, dynamic> json) =>
      _$UserDaoInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserDiscovery with _$UserDiscovery {
  const UserDiscovery._();

  const factory UserDiscovery({
    @JsonKey(name: '_id') required String id,
    String? event,
    @JsonKey(name: 'max_age') required double maxAge,
    @JsonKey(name: 'min_age') required double minAge,
    @JsonKey(name: 'search_range') required double searchRange,
    required List<String> selected,
    @JsonKey(name: 'selected_expanded') List<User?>? selectedExpanded,
    required DateTime stamp,
    required String user,
  }) = _UserDiscovery;

  factory UserDiscovery.fromJson(Map<String, dynamic> json) =>
      _$UserDiscoveryFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserDiscoverySettings with _$UserDiscoverySettings {
  const UserDiscoverySettings._();

  const factory UserDiscoverySettings({
    required bool enabled,
    @JsonKey(name: 'max_age') required double maxAge,
    @JsonKey(name: 'min_age') required double minAge,
  }) = _UserDiscoverySettings;

  factory UserDiscoverySettings.fromJson(Map<String, dynamic> json) =>
      _$UserDiscoverySettingsFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserDiscoverySettingsInput with _$UserDiscoverySettingsInput {
  const UserDiscoverySettingsInput._();

  const factory UserDiscoverySettingsInput({
    required bool enabled,
    @JsonKey(name: 'max_age') required double maxAge,
    @JsonKey(name: 'min_age') required double minAge,
  }) = _UserDiscoverySettingsInput;

  factory UserDiscoverySettingsInput.fromJson(Map<String, dynamic> json) =>
      _$UserDiscoverySettingsInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserDiscoverySwipe with _$UserDiscoverySwipe {
  const UserDiscoverySwipe._();

  const factory UserDiscoverySwipe({
    @JsonKey(name: '_id') required String id,
    UserDiscoverySwipeDecision? decision1,
    UserDiscoverySwipeDecision? decision2,
    String? other,
    @JsonKey(name: 'other_expanded') User? otherExpanded,
    required UserDiscoverySwipeSource source,
    required DateTime stamp,
    required UserDiscoverySwipeState state,
    required String user1,
    required String user2,
  }) = _UserDiscoverySwipe;

  factory UserDiscoverySwipe.fromJson(Map<String, dynamic> json) =>
      _$UserDiscoverySwipeFromJson(json);
}

enum UserDiscoverySwipeDecision {
  accept,
  decline,
}

enum UserDiscoverySwipeSource {
  discovery,
  live,
}

enum UserDiscoverySwipeState {
  declined,
  matched,
  pending,
  undecided,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserFollow with _$UserFollow {
  const UserFollow._();

  const factory UserFollow({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required String followee,
    @JsonKey(name: 'followee_expanded') User? followeeExpanded,
    required String follower,
    @JsonKey(name: 'follower_expanded') User? followerExpanded,
  }) = _UserFollow;

  factory UserFollow.fromJson(Map<String, dynamic> json) =>
      _$UserFollowFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserFriendship with _$UserFriendship {
  const UserFriendship._();

  const factory UserFriendship({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    String? other,
    @JsonKey(name: 'other_expanded') User? otherExpanded,
    required UserFriendshipState state,
    UserFriendshipType? type,
    Map<String, dynamic>? types,
    required String user1,
    required String user2,
  }) = _UserFriendship;

  factory UserFriendship.fromJson(Map<String, dynamic> json) =>
      _$UserFriendshipFromJson(json);
}

enum UserFriendshipState {
  accepted,
  pending,
}

enum UserFriendshipType {
  crew,
  tribe,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserIcebreaker with _$UserIcebreaker {
  const UserIcebreaker._();

  const factory UserIcebreaker({
    @JsonKey(name: '_id') String? id,
    required String question,
    @JsonKey(name: 'question_expanded')
    UserIcebreakerQuestion? questionExpanded,
    required String value,
  }) = _UserIcebreaker;

  factory UserIcebreaker.fromJson(Map<String, dynamic> json) =>
      _$UserIcebreakerFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserIcebreakerInput with _$UserIcebreakerInput {
  const UserIcebreakerInput._();

  const factory UserIcebreakerInput({
    @JsonKey(name: '_id') String? id,
    required String question,
    required String value,
  }) = _UserIcebreakerInput;

  factory UserIcebreakerInput.fromJson(Map<String, dynamic> json) =>
      _$UserIcebreakerInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserIcebreakerQuestion with _$UserIcebreakerQuestion {
  const UserIcebreakerQuestion._();

  const factory UserIcebreakerQuestion({
    @JsonKey(name: '_id') required String id,
    String? description,
    required String title,
  }) = _UserIcebreakerQuestion;

  factory UserIcebreakerQuestion.fromJson(Map<String, dynamic> json) =>
      _$UserIcebreakerQuestionFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserInput with _$UserInput {
  const UserInput._();

  const factory UserInput({
    List<AddressInput>? addresses,
    @JsonKey(name: 'calendly_url') String? calendlyUrl,
    @JsonKey(name: 'company_address') AddressInput? companyAddress,
    @JsonKey(name: 'company_name') String? companyName,
    String? cover,
    String? currency,
    List<UserDaoInput>? daos,
    Map<String, dynamic>? data,
    @JsonKey(name: 'date_of_birth') DateTime? dateOfBirth,
    String? description,
    UserDiscoverySettingsInput? discovery,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'education_title') String? educationTitle,
    @JsonKey(name: 'email_marketing') bool? emailMarketing,
    String? ethnicity,
    List<String>? events,
    @JsonKey(name: 'frequent_questions')
    List<FrequentQuestionInput>? frequentQuestions,
    @JsonKey(name: 'handle_facebook') String? handleFacebook,
    @JsonKey(name: 'handle_github') String? handleGithub,
    @JsonKey(name: 'handle_instagram') String? handleInstagram,
    @JsonKey(name: 'handle_linkedin') String? handleLinkedin,
    @JsonKey(name: 'handle_twitter') String? handleTwitter,
    List<UserIcebreakerInput>? icebreakers,
    String? industry,
    List<String>? interests,
    @JsonKey(name: 'job_title') String? jobTitle,
    List<String>? languages,
    @JsonKey(name: 'layout_sections') List<LayoutSectionInput>? layoutSections,
    List<String>? music,
    String? name,
    @JsonKey(name: 'new_gender') String? newGender,
    @JsonKey(name: 'new_photos') List<String>? newPhotos,
    @JsonKey(name: 'notification_filters')
    List<Map<String, dynamic>>? notificationFilters,
    List<UserOfferInput>? offers,
    String? phone,
    @JsonKey(name: 'preferred_network') String? preferredNetwork,
    String? pronoun,
    @JsonKey(name: 'search_range') double? searchRange,
    Map<String, dynamic>? settings,
    String? tagline,
    @JsonKey(name: 'terms_accepted_adult') bool? termsAcceptedAdult,
    @JsonKey(name: 'terms_accepted_conditions') bool? termsAcceptedConditions,
    String? timezone,
    String? username,
  }) = _UserInput;

  factory UserInput.fromJson(Map<String, dynamic> json) =>
      _$UserInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserOffer with _$UserOffer {
  const UserOffer._();

  const factory UserOffer({
    @JsonKey(name: '_id') String? id,
    bool? auto,
    double? position,
    required OfferProvider provider,
    @JsonKey(name: 'provider_id') required String providerId,
    @JsonKey(name: 'provider_network') required String providerNetwork,
  }) = _UserOffer;

  factory UserOffer.fromJson(Map<String, dynamic> json) =>
      _$UserOfferFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserOfferInput with _$UserOfferInput {
  const UserOfferInput._();

  const factory UserOfferInput({
    @JsonKey(name: '_id') String? id,
    bool? auto,
    double? position,
    required OfferProvider provider,
    @JsonKey(name: 'provider_id') required String providerId,
    @JsonKey(name: 'provider_network') required String providerNetwork,
  }) = _UserOfferInput;

  factory UserOfferInput.fromJson(Map<String, dynamic> json) =>
      _$UserOfferInputFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserPaymentVerification with _$UserPaymentVerification {
  const UserPaymentVerification._();

  const factory UserPaymentVerification({
    String? reason,
    required DateTime stamp,
    required UserPaymentVerificationState state,
    @JsonKey(name: 'verified_by') String? verifiedBy,
  }) = _UserPaymentVerification;

  factory UserPaymentVerification.fromJson(Map<String, dynamic> json) =>
      _$UserPaymentVerificationFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserPaymentVerificationCondition with _$UserPaymentVerificationCondition {
  const UserPaymentVerificationCondition._();

  const factory UserPaymentVerificationCondition({
    required String prop,
    required bool satisfied,
    required String title,
  }) = _UserPaymentVerificationCondition;

  factory UserPaymentVerificationCondition.fromJson(
          Map<String, dynamic> json) =>
      _$UserPaymentVerificationConditionFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserPaymentVerificationInfo with _$UserPaymentVerificationInfo {
  const UserPaymentVerificationInfo._();

  const factory UserPaymentVerificationInfo({
    required List<UserPaymentVerificationCondition> conditions,
    required bool eligible,
    required bool verified,
  }) = _UserPaymentVerificationInfo;

  factory UserPaymentVerificationInfo.fromJson(Map<String, dynamic> json) =>
      _$UserPaymentVerificationInfoFromJson(json);
}

enum UserPaymentVerificationState {
  completed,
  declined,
  pending,
}

enum UserType {
  @JsonKey(name: 'Admin')
  admin,
}

@Freezed(
  copyWith: true,
  equal: true,
)
class UserWalletRequest with _$UserWalletRequest {
  const UserWalletRequest._();

  const factory UserWalletRequest({
    required String message,
    required String token,
  }) = _UserWalletRequest;

  factory UserWalletRequest.fromJson(Map<String, dynamic> json) =>
      _$UserWalletRequestFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class Video with _$Video {
  const Video._();

  const factory Video({
    required String provider,
    @JsonKey(name: 'provider_id') required String providerId,
    String? thumbnail,
    String? title,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}

@Freezed(
  copyWith: true,
  equal: true,
)
class VideoInput with _$VideoInput {
  const VideoInput._();

  const factory VideoInput({
    required String provider,
    @JsonKey(name: 'provider_id') required String providerId,
    String? thumbnail,
    String? title,
  }) = _VideoInput;

  factory VideoInput.fromJson(Map<String, dynamic> json) =>
      _$VideoInputFromJson(json);
}
