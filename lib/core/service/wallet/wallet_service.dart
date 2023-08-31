import 'package:app/core/domain/wallet/wallet_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/wallet_connect/wallet_connect_service.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class WalletService {
  final walletRepository = getIt<WalletRepository>();
  final walletConnectService = getIt<WalletConnectService>();

  WalletService();

  Future<SessionData?> getActiveSession() async {
    return walletConnectService.getActiveSession();
  }

  Future<Either<Failure, bool>> initWallet() async {
    var success = await walletConnectService.init();
    if(success) return Right(success);
    return Left(Failure()); 
  }

  close() {
    walletConnectService.close();
  }

  Future<Either<Failure, bool>> connectWallet({required SupportedWalletApp walletApp}) async {
    var success = await walletConnectService.connectWallet(walletApp: walletApp);
    if(success) return Right(success);
    return Left(Failure()); 
  }

  Future<Either<Failure, bool>> updateUserWallet({
    required String wallet,
  }) async {
    final requestResult = await walletRepository.getUserWalletRequest(wallet: wallet.toLowerCase());
    if (requestResult.isLeft()) {
      return Left(Failure());
    }
    final userWalletRequest = requestResult.getOrElse(() => null);
    if (userWalletRequest == null) return Left(Failure());

    String message = Web3Utils.toHex(userWalletRequest.message);

    final signature = await walletConnectService.personalSign(
      message: message,
      wallet: wallet,
    );

    if(signature == null) return Left(Failure());

    final updateResult = await walletRepository.setUserWallet(
      token: userWalletRequest.token,
      signature: signature,
    );
    return updateResult.fold(
      (l) => Left(Failure()),
      (isUpdateSuccess) => Right(isUpdateSuccess),
    );
  }
}
