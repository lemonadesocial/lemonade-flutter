import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
import 'package:app/core/domain/payment/input/update_payment_input/update_payment_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentCard>>> getListCard();

  Future<Either<Failure, PaymentCard>> createNewCard({
    required String userId,
    required String tokenId,
  });

  Future<Either<Failure, Payment?>> updatePayment({
    required UpdatePaymentInput input,
  });
}
