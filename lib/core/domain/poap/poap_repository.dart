import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PoapRepository {
  Future<Either<Failure, PoapViewSupply>> getPoapViewSupply({
    required GetPoapViewSupplyInput input,
  });

  Future<Either<Failure, PoapViewCheckHasClaimed>> checkHasClaimedPoap({
    required CheckHasClaimedPoapViewInput input,
  });
}
