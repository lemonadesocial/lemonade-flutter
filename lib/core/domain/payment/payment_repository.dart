import 'package:app/core/domain/payment/entities/payment_card_entity/payment_card_entity.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentRepository {
  Future<Either<Failure, String>> getPublishableKey();

  Future<Either<Failure, List<PaymentCardEntity>>> getListCard();

  Future<Either<Failure, bool>> createNewCard();

  Future<Either<Failure, dynamic>> createNewPayment();
}
