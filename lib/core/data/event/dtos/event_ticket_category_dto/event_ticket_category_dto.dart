import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_ticket_category_dto.freezed.dart';
part 'event_ticket_category_dto.g.dart';

@freezed
class EventTicketCategoryDto with _$EventTicketCategoryDto {
  factory EventTicketCategoryDto({
    @JsonKey(name: '_id') String? id,
    String? title,
    String? event,
    String? description,
  }) = _EventTicketCategoryDto;

  factory EventTicketCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$EventTicketCategoryDtoFromJson(json);
}
