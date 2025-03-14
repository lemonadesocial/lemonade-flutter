import 'package:app/core/data/event/dtos/event_guest_detail_dto/event_guest_detail_dto.dart';
import 'package:app/core/domain/event/entities/event_guest_user/event_guest_user.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/entities/event_application_question_and_answer/event_application_question_and_answer.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_guest_detail.freezed.dart';
part 'event_guest_detail.g.dart';

@freezed
class EventGuestDetail with _$EventGuestDetail {
  factory EventGuestDetail({
    required EventGuestUser user,
    EventTicket? ticket,
    Payment? payment,
    List<EventApplicationQuestionAndAnswer>? application,
    EventJoinRequest? joinRequest,
  }) = _EventGuestDetail;

  factory EventGuestDetail.fromDto(EventGuestDetailDto dto) => EventGuestDetail(
        user: EventGuestUser.fromDto(dto.user),
        ticket: dto.ticket != null ? EventTicket.fromDto(dto.ticket!) : null,
        payment: dto.payment != null ? Payment.fromDto(dto.payment!) : null,
        application: dto.application
            ?.map((e) => EventApplicationQuestionAndAnswer.fromDto(e))
            .toList(),
        joinRequest: dto.joinRequest != null
            ? EventJoinRequest.fromDto(dto.joinRequest!)
            : null,
      );

  factory EventGuestDetail.fromJson(Map<String, dynamic> json) =>
      _$EventGuestDetailFromJson(json);
}
