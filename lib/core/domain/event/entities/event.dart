import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';

class Event {
  String? id;
  User? hostExpanded;
  List<User?>? cohostsExpanded;
  List<DbFile?>? newNewPhotosExpanded;
  String? title;
  String? slug;
  String? host;
  List<Broadcast>? broadcasts;
  String? description;
  DateTime? start;
  DateTime? end;
  double? cost;
  Currency? currency;

  Event({
    this.id,
    this.hostExpanded,
    this.cohostsExpanded,
    this.title,
    this.slug,
    this.host,
    this.broadcasts,
    this.description,
    this.start,
    this.end,
    this.cost,
    this.currency,
    this.newNewPhotosExpanded,
  });

  factory Event.fromDto(EventDto dto) {
    return Event(
      id: dto.id,
      hostExpanded: dto.hostExpanded != null ? User.fromDto(dto.hostExpanded!) : null,
      cohostsExpanded:
          List.from(dto.cohostsExpanded ?? []).map((item) => item != null ? User.fromDto(item) : null).toList(),
      newNewPhotosExpanded: (dto.newNewPhotosExpanded ?? []).map((i) => i == null ? null : DbFile.fromDto(i)).toList(),
      title: dto.title,
      slug: dto.slug,
      host: dto.host,
      broadcasts: List.from(dto.broadcasts ?? []).map((broadcast) => Broadcast.fromDto(broadcast)).toList(),
      description: dto.description,
      start: dto.start,
      end: dto.end,
      cost: dto.cost,
      currency: dto.currency,
    );
  }
}

class Broadcast {
  String? providerId;

  Broadcast({this.providerId});

  factory Broadcast.fromDto(BroadcastDto dto) {
    return Broadcast(
      providerId: dto.providerId,
    );
  }
}
