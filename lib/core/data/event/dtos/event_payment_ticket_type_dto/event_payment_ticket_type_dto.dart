import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_payment_ticket_type_dto.freezed.dart';
part 'event_payment_ticket_type_dto.g.dart';

@freezed
class EventPaymentTicketTypeDto with _$EventPaymentTicketTypeDto {
  factory EventPaymentTicketTypeDto({
    @JsonKey(name: '_id') String? id,
    bool? active,
    @JsonKey(name: 'address_required') bool? addressRequired,
    int? cost,
    @JsonKey(name: 'default') bool? isDefault,
    String? description,
    @JsonKey(name: 'description_line') String? descriptionLine,
    bool? discountable,
    List<String>? externalIds,
    int? limit,
    List<EventOfferDto>? offers,
    List<String>? photos,
    String? title,
  }) = _EventPaymentTicketTypeDto;

  factory EventPaymentTicketTypeDto.fromJson(Map<String, dynamic> json) =>
      _$EventPaymentTicketTypeDtoFromJson(json);
}
