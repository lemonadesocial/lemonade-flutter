import 'package:app/core/data/payment/dtos/payment_dto/payment_dto.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/entities/billing_info/billing_info.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';

@freezed
class Payment with _$Payment {
  Payment._();

  factory Payment({
    String? id,
    String? user,
    Map<String, dynamic>? transferParams,
    Map<String, dynamic>? transferMetadata,
    PaymentState? state,
    Map<String, DateTime>? stamps,
    String? failureReason,
    String? currency,
    BillingInfo? billingInfo,
    String? amount,
    PaymentAccount? accountExpanded,
    String? account,
    String? dueAmount,
    List<EventTicketType>? ticketTypesExpanded,
    Map<String, dynamic>? refData,
  }) = _Payment;

  factory Payment.fromDto(PaymentDto dto) => Payment(
        id: dto.id,
        user: dto.user,
        transferParams: dto.transferParams,
        transferMetadata: dto.transferMetadata,
        state: dto.state,
        stamps: dto.stamps,
        failureReason: dto.failureReason,
        currency: dto.currency,
        billingInfo: dto.billingInfo != null
            ? BillingInfo.fromDto(dto.billingInfo!)
            : null,
        amount: dto.amount,
        accountExpanded: dto.accountExpanded != null
            ? PaymentAccount.fromDto(dto.accountExpanded!)
            : null,
        account: dto.account,
        dueAmount: dto.dueAmount,
        ticketTypesExpanded: (dto.ticketTypesExpanded ?? [])
            .where((element) => element != null)
            .map((item) => EventTicketType.fromDto(item!))
            .toList(),
        refData: dto.refData,
      );
}
