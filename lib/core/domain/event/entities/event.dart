import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

@freezed
class Event with _$Event {
  Event._();

  factory Event(
      {String? id,
      User? hostExpanded,
      List<User?>? cohostsExpanded,
      List<DbFile?>? newNewPhotosExpanded,
      String? title,
      String? slug,
      List<String>? speakerUsers,
      List<User?>? speakerUsersExpanded,
      List<String>? cohosts,
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
      bool? private,
      List<Reward>? rewards,
      bool? approvalRequired,
      List<String>? requiredProfileFields,
      int? invitedCount}) = _Event;

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
      title: dto.title,
      slug: dto.slug,
      speakerUsers: List<String>.from(dto.speakerUsers ?? [])
          .map((item) => item)
          .toList(),
      speakerUsersExpanded: List.from(dto.speakerUsersExpanded ?? [])
          .map((item) => item != null ? User.fromDto(item) : null)
          .toList(),
      cohosts:
          List<String>.from(dto.cohosts ?? []).map((item) => item).toList(),
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
          .map((item) => PaymentAccount.fromDto(item))
          .toList(),
      guestLimit: dto.guestLimit,
      guestLimitPer: dto.guestLimitPer,
      virtual: dto.virtual,
      private: dto.private,
      rewards: List.from(dto.rewards ?? [])
          .map((item) => Reward.fromDto(item))
          .toList(),
      approvalRequired: dto.approvalRequired,
      requiredProfileFields: dto.requiredProfileFields ?? [],
      invitedCount: dto.invitedCount ?? 0,
    );
  }
}

class EventOffer {
  const EventOffer({
    this.id,
    this.auto,
    this.broadcastRooms,
    this.position,
    this.provider,
    this.providerId,
    this.providerNetwork,
  });

  final String? id;
  final bool? auto;
  final List<String>? broadcastRooms;
  final double? position;
  final OfferProvider? provider;
  final String? providerId;
  final String? providerNetwork;

  factory EventOffer.fromDto(EventOfferDto dto) => EventOffer(
        id: dto.id,
        auto: dto.auto,
        broadcastRooms: dto.broadcastRooms,
        position: dto.position,
        provider: dto.provider,
        providerId: dto.providerId,
        providerNetwork: dto.providerNetwork,
      );
}

class Broadcast {
  Broadcast({this.providerId});

  factory Broadcast.fromDto(BroadcastDto dto) {
    return Broadcast(
      providerId: dto.providerId,
    );
  }
  String? providerId;
}
