import 'package:app/core/domain/event/input/buy_tickets_input/buy_tickets_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/input/update_payment_input/update_payment_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/web3/web3_contract_service.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:convert/convert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/web3dart.dart';
import 'package:app/core/service/wallet/rpc_error_handler_extension.dart';

part 'buy_tickets_with_crypto_bloc.freezed.dart';

const maxUpdatePaymentAttempt = 5;

class BuyTicketsWithCryptoBloc
    extends Bloc<BuyTicketsWithCryptoEvent, BuyTicketsWithCryptoState> {
  final eventTicketRepository = getIt<EventTicketRepository>();
  final paymentRepository = getIt<PaymentRepository>();
  Payment? _currentPayment;
  String? _signature;
  String? _txHash;
  SupportedPaymentNetwork? _selectedNetwork;
  int _updatePaymentAttemptCount = 0;
  final walletConnectService = getIt<WalletConnectService>();

  BuyTicketsWithCryptoBloc()
      : super(
          BuyTicketsWithCryptoState.idle(
            data: BuyTicketsWithCryptoStateData(),
          ),
        ) {
    on<_SelectNetwork>(_onSelectNetwork);
    on<_InitAndSignPayment>(_onInitAndSignPayment);
    on<_MakeTransaction>(_onMakeTransaction);
    on<_ProcessUpdatePayment>(_onProcessUpdatePayment);
    on<_Resume>(_onResumeState);
  }

  Future<void> _onSelectNetwork(_SelectNetwork event, Emitter emit) async {
    _selectedNetwork = event.network;
    emit(
      BuyTicketsWithCryptoState.networkSelected(
        data: state.data.copyWith(
          selectedNetwork: _selectedNetwork,
        ),
      ),
    );
  }

  Future<void> _onInitAndSignPayment(
    _InitAndSignPayment event,
    Emitter emit,
  ) async {
    emit(BuyTicketsWithCryptoState.loading(data: state.data));
    final result = await eventTicketRepository.buyTickets(
      input: event.input.copyWith(
        transferParams: BuyTicketsTransferParamsInput(
          network: _selectedNetwork,
        ),
      ),
    );

    if (result.isLeft()) {
      return emit(
        BuyTicketsWithCryptoState.failure(
          data: state.data,
          failureReason: InitCryptoPaymentFailure(),
        ),
      );
    }

    final payment = result.getOrElse(() => null);
    _currentPayment = payment;
    if (payment == null) {
      return emit(
        BuyTicketsWithCryptoState.failure(
          data: state.data,
          failureReason: InitCryptoPaymentFailure(),
        ),
      );
    }
    try {
      final signature = await walletConnectService.personalSign(
        chainId:
            Web3Utils.getNetworkMetadataById(_selectedNetwork!.value).chainId,
        message: Web3Utils.toHex(payment.id ?? ''),
        wallet: event.userWalletAddress,
        walletApp: SupportedWalletApp.metamask,
      );

      _signature = signature;

      if (_signature != null) {
        emit(
          BuyTicketsWithCryptoState.signed(
            data: state.data.copyWith(
              payment: _currentPayment,
              signature: _signature,
            ),
          ),
        );
      } else {
        emit(
          BuyTicketsWithCryptoState.failure(
            data: state.data,
            failureReason: WalletConnectFailure(),
          ),
        );
      }
    } catch (e) {
      emit(
        BuyTicketsWithCryptoState.failure(
          data: state.data,
          failureReason: WalletConnectFailure(
            message: e is JsonRpcError
                ? walletConnectService.getMessageFromRpcError(e)
                : null,
          ),
        ),
      );
    }
  }

  Future<void> _onMakeTransaction(_MakeTransaction event, Emitter emit) async {
    emit(BuyTicketsWithCryptoState.loading(data: state.data));
    try {
      final contractAddress =
          event.currencyInfo.contracts?[_selectedNetwork] ?? '';
      final contract = Web3ContractService.getERC20Contract(contractAddress);
      final contractCallTxn = Transaction.callContract(
        contract: contract,
        function: contract.function('transfer'),
        parameters: [
          EthereumAddress.fromHex(event.to),
          event.amount,
        ],
      );
      final ethereumTxn = EthereumTransaction(
        from: event.from,
        to: contractAddress,
        value: '0x0',
        data: hex.encode(List<int>.from(contractCallTxn.data!)),
      );
      _txHash = await walletConnectService.requestTransaction(
        chainId:
            Web3Utils.getNetworkMetadataById(_selectedNetwork!.value).chainId,
        transaction: ethereumTxn,
        walletApp: SupportedWalletApp.metamask,
      );

      if (_txHash != null) {
        add(BuyTicketsWithCryptoEvent.processUpdatePayment());
      } else {
        emit(
          BuyTicketsWithCryptoState.failure(
            data: state.data,
            failureReason: WalletConnectFailure(),
          ),
        );
      }
    } catch (e) {
      emit(
        BuyTicketsWithCryptoState.failure(
          data: state.data,
          failureReason: WalletConnectFailure(
            message: e is JsonRpcError
                ? walletConnectService.getMessageFromRpcError(e)
                : null,
          ),
        ),
      );
    }
  }

  Future<void> _onProcessUpdatePayment(
    _ProcessUpdatePayment event,
    Emitter emit,
  ) async {
    if (_updatePaymentAttemptCount == maxUpdatePaymentAttempt) {
      return emit(
        BuyTicketsWithCryptoState.failure(
          data: state.data,
          failureReason: UpdateCryptoPaymentFailure(),
        ),
      );
    }
    _updatePaymentAttemptCount++;
    final result = await paymentRepository.updatePayment(
      input: UpdatePaymentInput(
        id: _currentPayment?.id ?? '',
        transferParams: UpdatePaymentTransferParams(
          signature: _signature,
          txHash: _txHash,
          network: _selectedNetwork!,
        ),
      ),
    );
    result.fold(
      (l) {
        add(
          BuyTicketsWithCryptoEvent.processUpdatePayment(),
        );
      },
      (payment) {
        if (payment != null) {
          _updatePaymentAttemptCount = 0;
          emit(
            BuyTicketsWithCryptoState.done(
              data: state.data.copyWith(
                payment: payment,
                txHash: _txHash,
              ),
            ),
          );
        }
      },
    );
  }

  void _onResumeState(_Resume event, Emitter emit) {
    emit(event.state);
  }
}

@freezed
class BuyTicketsWithCryptoEvent with _$BuyTicketsWithCryptoEvent {
  factory BuyTicketsWithCryptoEvent.initAndSignPayment({
    required BuyTicketsInput input,
    required String userWalletAddress,
  }) = _InitAndSignPayment;
  factory BuyTicketsWithCryptoEvent.makeTransaction({
    required String from,
    required BigInt amount,
    required String to,
    required CurrencyInfo currencyInfo,
  }) = _MakeTransaction;
  factory BuyTicketsWithCryptoEvent.selectNetwork({
    required SupportedPaymentNetwork network,
  }) = _SelectNetwork;
  factory BuyTicketsWithCryptoEvent.processUpdatePayment() =
      _ProcessUpdatePayment;
  factory BuyTicketsWithCryptoEvent.resume({
    required BuyTicketsWithCryptoState state,
  }) = _Resume;
}

@freezed
class BuyTicketsWithCryptoState with _$BuyTicketsWithCryptoState {
  factory BuyTicketsWithCryptoState.idle({
    required BuyTicketsWithCryptoStateData data,
  }) = BuyTicketsWithCryptoStateIdle;
  factory BuyTicketsWithCryptoState.networkSelected({
    required BuyTicketsWithCryptoStateData data,
  }) = BuyTicketsWithCryptoStateNetworkSelected;
  factory BuyTicketsWithCryptoState.signed({
    required BuyTicketsWithCryptoStateData data,
  }) = BuyTicketsWithCryptoStateSigned;
  factory BuyTicketsWithCryptoState.loading({
    required BuyTicketsWithCryptoStateData data,
  }) = BuyTicketsWithCryptoStateLoading;
  factory BuyTicketsWithCryptoState.done({
    required BuyTicketsWithCryptoStateData data,
  }) = BuyTicketsWithCryptoStateDone;
  factory BuyTicketsWithCryptoState.failure({
    required BuyTicketsWithCryptoStateData data,
    required BuyWithCryptoFailure failureReason,
  }) = BuyTicketsWithCryptoStateFailure;
}

@freezed
class BuyTicketsWithCryptoStateData with _$BuyTicketsWithCryptoStateData {
  factory BuyTicketsWithCryptoStateData({
    Payment? payment,
    String? signature,
    String? txHash,
    SupportedPaymentNetwork? selectedNetwork,
  }) = _BuyTicketsWithCryptoStateData;
}

class BuyWithCryptoFailure {}

class InitCryptoPaymentFailure extends BuyWithCryptoFailure {}

class WalletConnectFailure extends BuyWithCryptoFailure {
  final String? message;
  WalletConnectFailure({
    this.message,
  });
}

class UpdateCryptoPaymentFailure extends BuyWithCryptoFailure {}
