import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PaymentRepository)
class PaymentRepositoryImpl extends PaymentRepository {
  // final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, dynamic>> createNewCard() {
    // TODO: implement createNewCard
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> createNewPayment() {
    // TODO: implement createNewPayment
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> getListCard() {
    // TODO: implement getListCard
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> getPublishableKey() async {
    return Right('');
  }
}
