import 'package:app/core/data/event/dtos/event_application_question_and_answer_dto/event_application_question_and_answer_dto.dart';
import 'package:app/core/data/event/dtos/event_guest_user_dto/event_guest_user_dto.dart';
import 'package:app/core/data/event/dtos/event_ticket_dto/event_ticket_dto.dart';
import 'package:app/core/data/payment/dtos/payment_dto/payment_dto.dart';
import 'package:app/core/data/event/dtos/event_join_request_dto/event_join_request_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_guest_detail_dto.freezed.dart';
part 'event_guest_detail_dto.g.dart';

@freezed
class EventGuestDetailDto with _$EventGuestDetailDto {
  factory EventGuestDetailDto({
    required EventGuestUserDto user,
    EventTicketDto? ticket,
    PaymentDto? payment,
    List<EventApplicationQuestionAndAnswerDto>? application,
    @JsonKey(name: 'join_request') EventJoinRequestDto? joinRequest,
  }) = _EventGuestDetailDto;

  factory EventGuestDetailDto.fromJson(Map<String, dynamic> json) =>
      _$EventGuestDetailDtoFromJson(json);
}
