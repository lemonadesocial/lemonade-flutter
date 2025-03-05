import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
import 'package:app/core/domain/payment/input/create_payment_account_input/create_payment_account_input.dart';
import 'package:app/core/domain/payment/input/create_stripe_card_input/create_stripe_card_input.dart';
import 'package:app/core/domain/payment/input/get_payment_accounts_input/get_payment_accounts_input.dart';
import 'package:app/core/domain/payment/input/get_payment_input/get_payment_input.dart';
import 'package:app/core/domain/payment/input/get_stripe_cards_input/get_stripe_cards_input.dart';
import 'package:app/core/domain/payment/input/update_payment_account_input/update_payment_account_input.dart';
import 'package:app/core/domain/payment/input/update_payment_input/update_payment_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/graphql/backend/payment/query/get_new_payment.graphql.dart';
import 'package:app/graphql/backend/payment/query/list_event_payments.graphql.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/domain/payment/entities/event_payment_statistics/event_payment_statistics.dart';
import 'package:app/core/domain/payment/entities/list_event_payments_response/list_event_payments_response.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentCard>>> getStripeCards({
    required GetStripeCardsInput input,
  });

  Future<Either<Failure, PaymentCard>> createStripeCard({
    required CreateStripeCardInput input,
  });

  Future<Either<Failure, Payment?>> getPayment({
    required GetPaymentInput input,
  });

  Future<Either<Failure, Payment?>> updatePayment({
    required UpdatePaymentInput input,
  });

  Future<Either<Failure, List<PaymentAccount>>> getPaymentAccounts({
    required GetPaymentAccountsInput input,
  });

  Future<Either<Failure, PaymentAccount>> createPaymentAccount({
    required CreatePaymentAccountInput input,
  });

  Future<Either<Failure, PaymentAccount>> updatePaymentAccount({
    required UpdatePaymentAccountInput input,
  });

  Future<Either<Failure, bool>> mailTicketPaymentReciept({
    required String ticketId,
  });

  Future<Either<Failure, EventPaymentStatistics>> getEventPaymentStatistics({
    required String eventId,
  });

  Future<Either<Failure, ListEventPaymentsResponse>> listEventPayments({
    required Variables$Query$ListEventPayments input,
  });

  Future<Either<Failure, Payment>> getNewPayment({
    required Variables$Query$GetNewPayment input,
  });
}
