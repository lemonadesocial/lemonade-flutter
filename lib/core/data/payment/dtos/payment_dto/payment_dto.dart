import 'package:app/core/data/event/dtos/event_ticket_types_dto/event_ticket_types_dto.dart';
import 'package:app/core/data/payment/dtos/billing_info_dto/billing_info_dto.dart';
import 'package:app/core/data/payment/dtos/payment_account_dto/payment_account_dto.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_dto.freezed.dart';
part 'payment_dto.g.dart';

@freezed
class PaymentDto with _$PaymentDto {
  const factory PaymentDto({
    @JsonKey(name: '_id') String? id,
    String? user,
    @JsonKey(name: 'transfer_params') Map<String, dynamic>? transferParams,
    @JsonKey(name: 'transfer_metadata') Map<String, dynamic>? transferMetadata,
    Enum$NewPaymentState? state,
    Map<String, DateTime>? stamps,
    @JsonKey(name: 'failure_reason') String? failureReason,
    String? currency,
    @JsonKey(name: 'billing_info') BillingInfoDto? billingInfo,
    String? amount,
    @JsonKey(name: 'account_expanded') PaymentAccountDto? accountExpanded,
    String? account,
    @JsonKey(name: 'due_amount') String? dueAmount,
    @JsonKey(name: 'ticket_types_expanded')
    List<EventTicketTypeDto?>? ticketTypesExpanded,
    @JsonKey(name: 'ref_data') Map<String, dynamic>? refData,
  }) = _PaymentDto;

  factory PaymentDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentDtoFromJson(json);
}
