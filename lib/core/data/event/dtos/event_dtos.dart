import 'package:app/core/data/common/dtos/common_dtos.dart';
import 'package:app/core/data/event/dtos/event_application_profile_field_dto/event_application_profile_field_dto.dart';
import 'package:app/core/data/event/dtos/event_application_question_dto/event_application_question_dto.dart';
import 'package:app/core/data/event/dtos/event_payment_ticket_discount_dto/event_payment_ticket_discount_dto.dart';
import 'package:app/core/data/event/dtos/event_frequent_question_dto/event_frequent_question_dto.dart';
import 'package:app/core/data/event/dtos/event_session/event_session_dto.dart';
import 'package:app/core/data/event/dtos/event_ticket_dto/event_ticket_dto.dart';
import 'package:app/core/data/event/dtos/event_ticket_types_dto/event_ticket_types_dto.dart';
import 'package:app/core/data/event/dtos/reward_dto/reward_dto.dart';
import 'package:app/core/data/event/dtos/sub_event_settings_dto/sub_event_settings_dto.dart';
import 'package:app/core/data/payment/dtos/payment_account_dto/payment_account_dto.dart';
import 'package:app/core/data/web3/dtos/application_blockchain_platform_dto.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_dtos.freezed.dart';
part 'event_dtos.g.dart';

@freezed
class EventDto with _$EventDto {
  @JsonSerializable(explicitToJson: true)
  factory EventDto({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'host_expanded') UserDto? hostExpanded,
    @JsonKey(name: 'new_new_photos_expanded')
    List<DbFileDto?>? newNewPhotosExpanded,
    @JsonKey(name: 'new_new_photos') List<String>? newNewPhotos,
    @JsonKey(name: 'hide_cohosts') bool? hideCohosts,
    List<String>? cohosts,
    @JsonKey(name: 'cohosts_expanded') List<UserDto?>? cohostsExpanded,
    @JsonKey(name: 'visible_cohosts') List<String>? visibleCohosts,
    @JsonKey(name: 'visible_cohosts_expanded')
    List<UserDto?>? visibleCohostsExpanded,
    String? title,
    String? slug,
    @JsonKey(name: 'speaker_users') List<String>? speakerUsers,
    @JsonKey(name: 'speaker_users_expanded')
    List<UserDto?>? speakerUsersExpanded,
    String? host,
    List<BroadcastDto>? broadcasts,
    String? description,
    DateTime? start,
    DateTime? end,
    double? cost,
    String? currency,
    List<String>? accepted,
    List<String>? invited,
    List<String>? pending,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'matrix_event_room_id') String? matrixEventRoomId,
    @JsonKey(name: 'event_ticket_types')
    List<EventTicketTypeDto>? eventTicketTypes,
    List<EventOfferDto>? offers,
    AddressDto? address,
    @JsonKey(name: 'payment_accounts_new') List<String>? paymentAccountsNew,
    @JsonKey(name: 'payment_accounts_expanded')
    List<PaymentAccountDto?>? paymentAccountsExpanded,
    @JsonKey(name: 'guest_limit') double? guestLimit,
    @JsonKey(name: 'guest_limit_per') double? guestLimitPer,
    bool? virtual,
    @JsonKey(name: 'virtual_url') String? virtualUrl,
    bool? private,
    List<RewardDto>? rewards,
    @JsonKey(name: 'approval_required') bool? approvalRequired,
    @JsonKey(name: 'invited_count') double? invitedCount,
    @JsonKey(name: 'checkin_count') double? checkInCount,
    @JsonKey(name: 'attending_count') double? attendingCount,
    @JsonKey(name: 'pending_request_count') double? pendingRequestCount,
    @JsonKey(name: 'ticket_count') double? ticketCount,
    double? guests,
    List<EventSessionDto>? sessions,
    @JsonKey(name: 'application_questions')
    List<EventApplicationQuestionDto>? applicationQuestions,
    @JsonKey(name: 'application_profile_fields')
    List<EventApplicationProfileFieldDto>? applicationProfileFields,
    @JsonKey(name: 'application_form_submission')
    DateTime? applicationFormSubmission,
    @JsonKey(name: 'guest_directory_enabled') bool? guestDirectoryEnabled,
    @JsonKey(name: 'payment_ticket_discounts')
    List<EventPaymentTicketDiscountDto>? paymentTicketDiscounts,
    bool? published,
    @JsonKey(name: 'frequent_questions')
    List<EventFrequentQuestionDto>? frequentQuestions,
    String? timezone,
    @JsonKey(name: 'tickets') List<EventTicketDto>? tickets,
    // Sub-event related
    @JsonKey(name: 'subevent_enabled') bool? subeventEnabled,
    @JsonKey(name: 'subevent_parent') String? subeventParent,
    @JsonKey(name: 'subevent_parent_expanded') EventDto? subeventParentExpanded,
    @JsonKey(name: 'subevent_settings') SubEventSettingsDto? subeventSettings,
    @JsonKey(name: 'inherited_cohosts') List<String>? inheritedCohosts,
    List<String>? tags,
    @JsonKey(name: 'application_required') bool? applicationRequired,
    @JsonKey(name: 'registration_disabled') bool? registrationDisabled,
    @JsonKey(name: 'shortid') String? shortId,
    @JsonKey(name: 'address_directions')
    List<String>? addressDirectionsRecommendations,
    @JsonKey(name: 'rsvp_wallet_platforms')
    List<ApplicationBlockchainPlatformDto>? rsvpWalletPlatforms,
  }) = _EventDto;

  factory EventDto.fromJson(Map<String, dynamic> json) =>
      _$EventDtoFromJson(json);
}

@freezed
class EventOfferDto with _$EventOfferDto {
  factory EventOfferDto({
    @JsonKey(name: '_id') String? id,
    bool? auto,
    @JsonKey(name: 'broadcast_rooms') List<String>? broadcastRooms,
    double? position,
    OfferProvider? provider,
    @JsonKey(name: 'provider_id') String? providerId,
    @JsonKey(name: 'provider_network') String? providerNetwork,
  }) = _EventOfferDto;

  factory EventOfferDto.fromJson(Map<String, dynamic> json) =>
      _$EventOfferDtoFromJson(json);
}

@freezed
class BroadcastDto with _$BroadcastDto {
  @JsonSerializable(explicitToJson: true)
  factory BroadcastDto({
    @JsonKey(name: 'provider_id', includeIfNull: false) String? providerId,
  }) = _BroadcastDto;

  factory BroadcastDto.fromJson(Map<String, dynamic> json) =>
      _$BroadcastDtoFromJson(json);
}
