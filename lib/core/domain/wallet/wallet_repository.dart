import 'package:app/core/domain/wallet/entities/wallet_entities.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class WalletRepository {
  Future<Either<Failure, UserWalletRequest?>> getUserWalletRequest({ required String wallet });

  Future<Either<Failure, bool>> setUserWallet({ required String token, required String signature });
}