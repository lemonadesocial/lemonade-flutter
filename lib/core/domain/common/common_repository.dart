import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CommonRepository {
  Future<Either<Failure, List<Currency>>> listAllCurrencies();
}
