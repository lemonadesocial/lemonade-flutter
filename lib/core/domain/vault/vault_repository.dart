import 'package:app/core/domain/vault/input/get_init_safe_transaction_input/get_init_safe_transaction_input.dart';
import 'package:app/core/domain/vault/input/get_safe_free_limit_input/get_safe_free_limit_input.dart';
import 'package:app/core/domain/web3/entities/raw_transaction.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class VaultRepository {
  Future<Either<Failure, RawTransaction>> getInitSafeTransaction({
    required GetInitSafeTransactionInput input,
  });

  Future<Either<Failure, int>> getSafeFreeLimit({
    required GetSafeFreeLimitInput input,
  });
}
