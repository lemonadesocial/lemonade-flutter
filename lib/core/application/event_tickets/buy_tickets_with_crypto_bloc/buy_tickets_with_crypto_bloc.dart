import 'dart:async';
import 'package:app/core/application/event_tickets/buy_tickets_with_crypto_bloc/crypto_transaction_executor/crypto_transaction_executor.dart';
import 'package:app/core/domain/event/entities/buy_tickets_response.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/input/buy_tickets_input/buy_tickets_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/input/update_payment_input/update_payment_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:app/core/service/wallet/rpc_error_handler_extension.dart';
import 'package:app/core/application/event_tickets/buy_tickets_with_crypto_bloc/crypto_transaction_executor/executors/ethereum_relay_transaction_executor.dart';
import 'package:app/core/application/event_tickets/buy_tickets_with_crypto_bloc/crypto_transaction_executor/executors/ethereum_transaction_executor.dart';
import 'package:app/core/application/event_tickets/buy_tickets_with_crypto_bloc/crypto_transaction_executor/executors/ethereum_stake_transaction_executor.dart';

part 'buy_tickets_with_crypto_bloc.freezed.dart';

const maxUpdatePaymentAttempt = 5;

class BuyTicketsWithCryptoBloc
    extends Bloc<BuyTicketsWithCryptoEvent, BuyTicketsWithCryptoState> {
  final eventTicketRepository = getIt<EventTicketRepository>();
  final paymentRepository = getIt<PaymentRepository>();
  final _web3Repository = getIt<Web3Repository>();
  final PaymentAccount? selectedPaymentAccount;

  EventJoinRequest? _currentEventJoinRequest;
  Payment? _currentPayment;
  String? _signature;
  String? _txHash;
  int _updatePaymentAttemptCount = 0;
  final walletConnectService = getIt<WalletConnectService>();

  String? get _selectedNetwork => selectedPaymentAccount?.accountInfo?.network;

  final ethereumTransactionExecutor = EthereumTransactionExecutor();
  final ethereumRelayTransactionExecutor = EthereumRelayTransactionExecutor();
  final ethereumStakeTransactionExecutor = EthereumStakeTransactionExecutor();

  BuyTicketsWithCryptoBloc({
    required this.selectedPaymentAccount,
  }) : super(
          BuyTicketsWithCryptoState.idle(
            data: BuyTicketsWithCryptoStateData(),
          ),
        ) {
    on<_InitAndSignPayment>(_onInitAndSignPayment);
    on<_MakeTransaction>(_onMakeTransaction);
    on<_ProcessUpdatePayment>(_onProcessUpdatePayment);
    on<_Resume>(_onResumeState);
    on<_ReceivedPaymentFailedFromNotification>(
      _onReceivedPaymentFailedFromNotification,
    );
  }

  Future<void> _onInitAndSignPayment(
    _InitAndSignPayment event,
    Emitter emit,
  ) async {
    emit(BuyTicketsWithCryptoState.loading(data: state.data));

    if (_currentPayment == null) {
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
      _currentPayment = result.getOrElse(() => BuyTicketsResponse()).payment;
      _currentEventJoinRequest =
          result.getOrElse(() => BuyTicketsResponse()).eventJoinRequest;
    }

    if (_currentPayment == null) {
      return emit(
        BuyTicketsWithCryptoState.failure(
          data: state.data,
          failureReason: InitCryptoPaymentFailure(),
        ),
      );
    }

    final isFree = BigInt.parse(event.input.total) == BigInt.zero;
    // if isFree then consider as payment done and listen for notification
    if (isFree) {
      return emit(
        BuyTicketsWithCryptoState.done(
          data: state.data.copyWith(
            eventJoinRequest: _currentEventJoinRequest,
            payment: _currentPayment,
            txHash: _txHash,
          ),
        ),
      );
    }

    try {
      final getChainResult =
          await _web3Repository.getChainById(chainId: _selectedNetwork!);
      final chain = getChainResult.getOrElse(() => null);
      final signature = await walletConnectService
          .personalSign(
            chainId: chain?.fullChainId,
            message: Web3Utils.toHex(_currentPayment?.id ?? ''),
            wallet: event.userWalletAddress,
          )
          .timeout(
            const Duration(
              seconds: 30,
            ),
          );

      _signature = signature;

      if (_signature != null && _signature!.startsWith("0x")) {
        await paymentRepository.updatePayment(
          input: UpdatePaymentInput(
            id: _currentPayment?.id ?? '',
            transferParams: UpdatePaymentTransferParams(
              signature: _signature,
              network: _selectedNetwork!,
              from: walletConnectService.w3mService.session?.address ?? '',
            ),
          ),
        );
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
      if (e is TimeoutException) {
        return emit(
          BuyTicketsWithCryptoState.failure(
            data: state.data,
            failureReason: WalletConnectFailure(
              message: 'Timeout',
            ),
          ),
        );
      }
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
      final getChainResult =
          await _web3Repository.getChainById(chainId: _selectedNetwork!);
      final chain = getChainResult.getOrElse(() => null);
      if (chain == null ||
          selectedPaymentAccount == null ||
          _currentPayment == null) {
        return emit(
          BuyTicketsWithCryptoState.failure(
            data: state.data,
            failureReason: InitCryptoPaymentFailure(),
          ),
        );
      }
      late CryptoTransactionExecutionResult result;
      if (selectedPaymentAccount?.type == PaymentAccountType.ethereumRelay) {
        result = await ethereumRelayTransactionExecutor.execute(
          eventId: event.eventId,
          from: event.from,
          to: event.to,
          amount: event.amount,
          currency: event.currency,
          currencyInfo: event.currencyInfo,
          chain: chain,
          paymentAccount: selectedPaymentAccount!,
          payment: _currentPayment!,
        );
        _txHash = result.txHash;
      }

      if (selectedPaymentAccount?.type == PaymentAccountType.ethereumStake) {
        result = await ethereumStakeTransactionExecutor.execute(
          eventId: event.eventId,
          from: event.from,
          to: event.to,
          amount: event.amount,
          currency: event.currency,
          currencyInfo: event.currencyInfo,
          chain: chain,
          paymentAccount: selectedPaymentAccount!,
          payment: _currentPayment!,
        );
      }

      if (selectedPaymentAccount?.type == PaymentAccountType.ethereum) {
        result = await ethereumTransactionExecutor.execute(
          eventId: event.eventId,
          from: event.from,
          to: event.to,
          amount: event.amount,
          currency: event.currency,
          currencyInfo: event.currencyInfo,
          chain: chain,
          paymentAccount: selectedPaymentAccount!,
          payment: _currentPayment!,
        );
        _txHash = result.txHash;
      }

      _txHash = result.txHash;
      add(BuyTicketsWithCryptoEvent.processUpdatePayment());
    } catch (e) {
      if (e is CryptoTransactionException) {
        return emit(
          BuyTicketsWithCryptoState.failure(
            data: state.data,
            failureReason: WalletConnectFailure(
              message: e.message,
            ),
          ),
        );
      }

      if (e is TimeoutException) {
        return emit(
          BuyTicketsWithCryptoState.failure(
            data: state.data,
            failureReason: WalletConnectFailure(
              message: 'Timeout',
            ),
          ),
        );
      }
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
          network: _selectedNetwork,
          from: walletConnectService.w3mService.session?.address ?? '',
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
                eventJoinRequest: _currentEventJoinRequest,
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

  void _onReceivedPaymentFailedFromNotification(
    _ReceivedPaymentFailedFromNotification event,
    Emitter emit,
  ) {
    emit(
      BuyTicketsWithCryptoState.failure(
        data: state.data,
        failureReason: NotificationCryptoPaymentFailure(),
      ),
    );
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
    required String eventId,
    required String currency,
  }) = _MakeTransaction;
  factory BuyTicketsWithCryptoEvent.selectNetwork({
    required String network,
  }) = _SelectNetwork;
  factory BuyTicketsWithCryptoEvent.processUpdatePayment() =
      _ProcessUpdatePayment;
  factory BuyTicketsWithCryptoEvent.resume({
    required BuyTicketsWithCryptoState state,
  }) = _Resume;
  factory BuyTicketsWithCryptoEvent.receivedPaymentFailedFromNotification({
    Payment? payment,
  }) = _ReceivedPaymentFailedFromNotification;
}

@freezed
class BuyTicketsWithCryptoState with _$BuyTicketsWithCryptoState {
  factory BuyTicketsWithCryptoState.idle({
    required BuyTicketsWithCryptoStateData data,
  }) = BuyTicketsWithCryptoStateIdle;
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
    EventJoinRequest? eventJoinRequest,
    Payment? payment,
    String? signature,
    String? txHash,
  }) = _BuyTicketsWithCryptoStateData;
}

class BuyWithCryptoFailure {
  final String? message;
  BuyWithCryptoFailure({
    this.message,
  });
}

class InitCryptoPaymentFailure extends BuyWithCryptoFailure {
  InitCryptoPaymentFailure({
    super.message,
  });
}

class WalletConnectFailure extends BuyWithCryptoFailure {
  WalletConnectFailure({
    super.message,
  });
}

class UpdateCryptoPaymentFailure extends BuyWithCryptoFailure {
  UpdateCryptoPaymentFailure({
    super.message,
  });
}

class NotificationCryptoPaymentFailure extends BuyWithCryptoFailure {
  NotificationCryptoPaymentFailure({
    super.message,
  });
}
