import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/data/payment/dtos/payment_account_dto/payment_account_dto.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event_application_profile_field.dart';
import 'package:app/core/domain/event/entities/event_payment_ticket_discount.dart';
import 'package:app/core/domain/event/entities/event_frequent_question.dart';
import 'package:app/core/domain/event/entities/event_session.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/domain/event/entities/sub_event_settings.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/web3/entities/application_blockchain_platform.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/core/domain/event/entities/event_application_question.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
class Event with _$Event {
  const Event._();

  @JsonSerializable(explicitToJson: true)
  factory Event({
    String? id,
    User? hostExpanded,
    List<DbFile?>? newNewPhotosExpanded,
    List<String>? newNewPhotos,
    String? title,
    String? slug,
    List<String>? speakerUsers,
    List<User?>? speakerUsersExpanded,
    bool? hideCohosts,
    List<String>? cohosts,
    List<User?>? cohostsExpanded,
    List<String>? visibleCohosts,
    List<User?>? visibleCohostsExpanded,
    String? host,
    List<Broadcast>? broadcasts,
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
    String? matrixEventRoomId,
    List<EventOffer>? offers,
    List<EventTicketType>? eventTicketTypes,
    Address? address,
    List<String>? paymentAccountsNew,
    List<PaymentAccount>? paymentAccountsExpanded,
    double? guestLimit,
    double? guestLimitPer,
    bool? virtual,
    String? virtualUrl,
    bool? private,
    List<Reward>? rewards,
    bool? approvalRequired,
    int? invitedCount,
    int? checkInCount,
    int? attendingCount,
    int? pendingRequestCount,
    int? ticketCount,
    int? guests,
    List<EventSession>? sessions,
    List<EventApplicationQuestion>? applicationQuestions,
    List<EventApplicationProfileField>? applicationProfileFields,
    DateTime? applicationFormSubmission,
    bool? guestDirectoryEnabled,
    List<EventPaymentTicketDiscount>? paymentTicketDiscounts,
    bool? published,
    List<EventFrequentQuestion>? frequentQuestions,
    String? timezone,
    // Sub-event related
    bool? subeventEnabled,
    String? subeventParent,
    Event? subeventParentExpanded,
    SubEventSettings? subeventSettings,
    List<String>? inheritedCohosts,
    List<String>? tags,
    bool? applicationRequired,
    bool? registrationDisabled,
    String? shortId,
    List<String>? addressDirectionsRecommendations,
    List<ApplicationBlockchainPlatform>? rsvpWalletPlatforms,
    String? space,
    Space? spaceExpanded,
  }) = _Event;

  factory Event.fromDto(EventDto dto) {
    return Event(
      id: dto.id,
      hostExpanded:
          dto.hostExpanded != null ? User.fromDto(dto.hostExpanded!) : null,
      cohostsExpanded: List.from(dto.cohostsExpanded ?? [])
          .map((item) => item != null ? User.fromDto(item) : null)
          .toList(),
      newNewPhotosExpanded: (dto.newNewPhotosExpanded ?? [])
          .map((i) => i == null ? null : DbFile.fromDto(i))
          .toList(),
      newNewPhotos: (dto.newNewPhotos ?? []),
      title: dto.title,
      slug: dto.slug,
      speakerUsers: List<String>.from(dto.speakerUsers ?? [])
          .map((item) => item)
          .toList(),
      speakerUsersExpanded: List.from(dto.speakerUsersExpanded ?? [])
          .map((item) => item != null ? User.fromDto(item) : null)
          .toList(),
      hideCohosts: dto.hideCohosts,
      cohosts:
          List<String>.from(dto.cohosts ?? []).map((item) => item).toList(),
      visibleCohosts: dto.visibleCohosts?.isNotEmpty == true
          ? List<String>.from(dto.visibleCohosts ?? [])
              .map((item) => item)
              .toList()
          : [
              dto.host ?? '',
              ...(dto.cohosts ?? []),
            ].whereType<String>().toList(),
      visibleCohostsExpanded: dto.visibleCohosts?.isNotEmpty == true
          ? List.from(dto.visibleCohostsExpanded ?? [])
              .map((item) => item != null ? User.fromDto(item) : null)
              .toList()
          : [
              dto.hostExpanded != null ? User.fromDto(dto.hostExpanded!) : null,
              ...(dto.cohostsExpanded ?? [])
                  .map((item) => item != null ? User.fromDto(item) : null),
            ].whereType<User>().toList(),
      host: dto.host,
      broadcasts: List<BroadcastDto>.from(dto.broadcasts ?? [])
          .map(Broadcast.fromDto)
          .toList(),
      description: dto.description,
      start: dto.start,
      end: dto.end,
      cost: dto.cost,
      currency: dto.currency,
      accepted:
          List<String>.from(dto.accepted ?? []).map((item) => item).toList(),
      invited:
          List<String>.from(dto.invited ?? []).map((item) => item).toList(),
      pending:
          List<String>.from(dto.pending ?? []).map((item) => item).toList(),
      latitude: dto.latitude,
      longitude: dto.longitude,
      matrixEventRoomId: dto.matrixEventRoomId,
      offers: List.from(dto.offers ?? [])
          .map((item) => EventOffer.fromDto(item))
          .toList(),
      eventTicketTypes: List.from(dto.eventTicketTypes ?? [])
          .map((item) => EventTicketType.fromDto(item))
          .toList(),
      address: dto.address != null ? Address.fromDto(dto.address!) : null,
      paymentAccountsNew: dto.paymentAccountsNew ?? [],
      paymentAccountsExpanded: List.from(dto.paymentAccountsExpanded ?? [])
          .whereType<PaymentAccountDto>()
          .map((item) => PaymentAccount.fromDto(item))
          .toList(),
      guestLimit: dto.guestLimit,
      guestLimitPer: dto.guestLimitPer,
      virtual: dto.virtual,
      virtualUrl: dto.virtualUrl,
      private: dto.private,
      rewards: List.from(dto.rewards ?? [])
          .map((item) => Reward.fromDto(item))
          .toList(),
      approvalRequired: dto.approvalRequired,
      invitedCount: dto.invitedCount?.toInt() ?? 0,
      checkInCount: dto.checkInCount?.toInt() ?? 0,
      attendingCount: dto.attendingCount?.toInt() ?? 0,
      pendingRequestCount: dto.pendingRequestCount?.toInt() ?? 0,
      ticketCount: dto.ticketCount?.toInt() ?? 0,
      guests: dto.guests?.toInt() ?? 0,
      sessions: List.from(dto.sessions ?? [])
          .map((item) => EventSession.fromDto(item))
          .toList(),
      applicationQuestions: List.from(dto.applicationQuestions ?? [])
          .map((item) => EventApplicationQuestion.fromDto(item))
          .toList(),
      applicationProfileFields: List.from(dto.applicationProfileFields ?? [])
          .map((item) => EventApplicationProfileField.fromDto(item))
          .toList(),
      applicationFormSubmission: dto.applicationFormSubmission,
      guestDirectoryEnabled: dto.guestDirectoryEnabled,
      paymentTicketDiscounts: List.from(dto.paymentTicketDiscounts ?? [])
          .map(
            (item) => EventPaymentTicketDiscount.fromDto(item),
          )
          .toList(),
      published: dto.published,
      frequentQuestions: List.from(dto.frequentQuestions ?? [])
          .map((item) => EventFrequentQuestion.fromDto(item))
          .toList(),
      timezone: dto.timezone,
      // Sub-event related
      subeventEnabled: dto.subeventEnabled,
      subeventParent: dto.subeventParent,
      subeventParentExpanded: dto.subeventParentExpanded != null
          ? Event.fromDto(dto.subeventParentExpanded!)
          : null,
      subeventSettings: dto.subeventSettings != null
          ? SubEventSettings.fromDto(dto.subeventSettings!)
          : null,
      inheritedCohosts: dto.inheritedCohosts,
      tags: dto.tags,
      applicationRequired: dto.applicationRequired,
      registrationDisabled: dto.registrationDisabled,
      shortId: dto.shortId,
      addressDirectionsRecommendations:
          List.from(dto.addressDirectionsRecommendations ?? []),
      rsvpWalletPlatforms: List.from(dto.rsvpWalletPlatforms ?? [])
          .map((item) => ApplicationBlockchainPlatform.fromDto(item))
          .toList(),
      space: dto.space,
      spaceExpanded:
          dto.spaceExpanded != null ? Space.fromDto(dto.spaceExpanded!) : null,
    );
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

@freezed
class EventOffer with _$EventOffer {
  const EventOffer._();

  factory EventOffer({
    String? id,
    bool? auto,
    List<String>? broadcastRooms,
    double? position,
    OfferProvider? provider,
    String? providerId,
    String? providerNetwork,
  }) = _EventOffer;

  factory EventOffer.fromDto(EventOfferDto dto) => EventOffer(
        id: dto.id,
        auto: dto.auto,
        broadcastRooms: dto.broadcastRooms,
        position: dto.position,
        provider: dto.provider,
        providerId: dto.providerId,
        providerNetwork: dto.providerNetwork,
      );

  factory EventOffer.fromJson(Map<String, dynamic> json) =>
      _$EventOfferFromJson(json);
}

@freezed
class Broadcast with _$Broadcast {
  const Broadcast._();

  factory Broadcast({
    String? providerId,
  }) = _Broadcast;

  factory Broadcast.fromDto(BroadcastDto dto) {
    return Broadcast(
      providerId: dto.providerId,
    );
  }

  factory Broadcast.fromJson(Map<String, dynamic> json) =>
      _$BroadcastFromJson(json);
}
