import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
import 'package:app/core/domain/payment/input/create_payment_account_input/create_payment_account_input.dart';
import 'package:app/core/domain/payment/input/create_stripe_card_input/create_stripe_card_input.dart';
import 'package:app/core/domain/payment/input/get_payment_accounts_input/get_payment_accounts_input.dart';
import 'package:app/core/domain/payment/input/get_payment_input/get_payment_input.dart';
import 'package:app/core/domain/payment/input/get_stripe_cards_input/get_stripe_cards_input.dart';
import 'package:app/core/domain/payment/input/update_payment_input/update_payment_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

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

  Future<Either<Failure, bool>> mailTicketPaymentReciept({
    required String ticketId,
  });
}
