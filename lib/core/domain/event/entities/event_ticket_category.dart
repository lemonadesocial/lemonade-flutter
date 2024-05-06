import 'package:app/core/data/event/dtos/event_ticket_category_dto/event_ticket_category_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_ticket_category.freezed.dart';
part 'event_ticket_category.g.dart';

@freezed
class EventTicketCategory with _$EventTicketCategory {
  const EventTicketCategory._();

  factory EventTicketCategory({
    String? id,
    String? title,
    String? event,
    String? description,
  }) = _EventTicketCategory;

  factory EventTicketCategory.fromDto(EventTicketCategoryDto dto) =>
      EventTicketCategory(
        id: dto.id,
        title: dto.title,
        event: dto.event,
        description: dto.description,
      );
  factory EventTicketCategory.fromJson(Map<String, dynamic> json) =>
      _$EventTicketCategoryFromJson(json);
}
