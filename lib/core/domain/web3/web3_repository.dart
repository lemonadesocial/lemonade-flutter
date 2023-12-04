import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class Web3Repository {
  Future<Either<Failure, List<Chain>>> getChainsList();

  Future<Either<Failure, Chain?>> getChainById({
    required String chainId,
  });
}
