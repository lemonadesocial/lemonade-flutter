import 'package:app/core/domain/wallet/wallet_repository.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_wallet_bloc.freezed.dart';

class SignWalletBloc extends Bloc<SignWalletEvent, SignWalletState> {
  final walletRepository = getIt<WalletRepository>();
  final walletConnectService = getIt<WalletConnectService>();

  SignWalletBloc() : super(SignWalletState.idle()) {
    on<SignWalletEventSign>(_onSignWallet);
  }

  Future<void> _onSignWallet(SignWalletEventSign event, Emitter emit) async {
    emit(SignWalletState.loading());
    final walletRequestResult = await walletRepository.getUserWalletRequest(
      wallet: event.wallet.toLowerCase(),
    );

    if (walletRequestResult.isLeft()) {
      return emit(SignWalletState.failure());
    }

    final userWalletRequest = walletRequestResult.getOrElse(() => null);
    if (userWalletRequest == null) {
      return emit(SignWalletState.failure());
    }

    String signedMessage = Web3Utils.toHex(userWalletRequest.message);

    final signature = await walletConnectService.personalSign(
      message: signedMessage,
      wallet: event.wallet,
    );

    if (signature == null || signature.isEmpty || !signature.startsWith('0x')) {
      return emit(SignWalletState.failure());
    }

    final result = await walletRepository.setUserWallet(
      token: userWalletRequest.token,
      signature: signature,
    );

    result.fold(
      (l) => emit(
        SignWalletState.failure(),
      ),
      (isSuccess) {
        emit(
          isSuccess ? SignWalletState.success() : SignWalletState.failure(),
        );
      },
    );
  }
}

@freezed
class SignWalletEvent with _$SignWalletEvent {
  factory SignWalletEvent.sign({
    required String wallet,
  }) = SignWalletEventSign;
}

@freezed
class SignWalletState with _$SignWalletState {
  factory SignWalletState.idle() = SignWalletStateIdle;
  factory SignWalletState.loading() = SignWalletStateLoading;
  factory SignWalletState.success() = SignWalletStateSuccess;
  factory SignWalletState.failure() = SignWalletStateFailure;
}
