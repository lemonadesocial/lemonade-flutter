import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentRepository {
  Future<Either<Failure, String>> getPublishableKey();

  Future<Either<Failure, dynamic>> getListCard();

  Future<Either<Failure, dynamic>> createNewCard();

  Future<Either<Failure, dynamic>> createNewPayment();
}
