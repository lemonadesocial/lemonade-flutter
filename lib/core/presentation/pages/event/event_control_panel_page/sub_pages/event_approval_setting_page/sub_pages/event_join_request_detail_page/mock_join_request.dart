import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';

EventJoinRequest mockEscrowJoinRequest(EventJoinRequest eventJoinRequest) {
  return eventJoinRequest.copyWith(
    paymentExpanded: Payment(
      state: PaymentState.initialized,
      currency: 'ETH',
      dueAmount: BigInt.from(1.5e15).toString(),
      amount: BigInt.from(3e16).toString(),
      accountExpanded: PaymentAccount(
        type: PaymentAccountType.ethereumEscrow,
      ),
    ),
  );
}
