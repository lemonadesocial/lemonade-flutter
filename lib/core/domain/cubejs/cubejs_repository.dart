import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CubeJsRepository {
  Future<Either<Failure, String>> generateCubejsToken({
    required String eventId,
  });
}
