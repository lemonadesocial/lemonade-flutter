import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';

class Event {
  Event({
    this.id,
    this.hostExpanded,
    this.cohostsExpanded,
    this.title,
    this.slug,
    this.host,
    this.cohosts,
    this.speakerUsers,
    this.broadcasts,
    this.description,
    this.start,
    this.end,
    this.cost,
    this.currency,
    this.newNewPhotosExpanded,
    this.accepted,
    this.invited,
    this.pending,
    this.latitude,
    this.longitude,
    this.matrixEventRoomId,
    this.offers,
    this.eventTicketTypes,
    this.address,
    this.paymentAccountsExpanded,
  });

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
          .map((item) => PurchasableTicketType.fromDto(item))
          .toList(),
      address: dto.address != null ? Address.fromDto(dto.address!) : null,
      paymentAccountsExpanded: List.from(dto.paymentAccountsExpanded ?? [])
          .map((item) => PaymentAccount.fromDto(item))
          .toList(),
    );
  }
  String? id;
  User? hostExpanded;
  List<User?>? cohostsExpanded;
  List<DbFile?>? newNewPhotosExpanded;
  String? title;
  String? slug;
  List<String>? speakerUsers;
  List<String>? cohosts;
  String? host;
  List<Broadcast>? broadcasts;
  String? description;
  DateTime? start;
  DateTime? end;
  double? cost;
  Currency? currency;
  List<String>? accepted;
  List<String>? invited;
  List<String>? pending;
  double? latitude;
  double? longitude;
  String? matrixEventRoomId;
  List<EventOffer>? offers;
  List<PurchasableTicketType>? eventTicketTypes;
  Address? address;
  List<PaymentAccount>? paymentAccountsExpanded;
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
