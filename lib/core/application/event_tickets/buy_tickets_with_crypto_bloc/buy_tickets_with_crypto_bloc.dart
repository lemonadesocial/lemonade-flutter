import 'dart:async';
import 'package:app/core/constants/web3/chains.dart';
import 'package:app/core/domain/event/entities/buy_tickets_response.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/input/buy_tickets_input/buy_tickets_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/input/update_payment_input/update_payment_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/web3/web3_contract_service.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:convert/convert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:app/core/service/wallet/rpc_error_handler_extension.dart';
part 'buy_tickets_with_crypto_bloc.freezed.dart';

const maxUpdatePaymentAttempt = 5;

class BuyTicketsWithCryptoBloc
    extends Bloc<BuyTicketsWithCryptoEvent, BuyTicketsWithCryptoState> {
  final eventTicketRepository = getIt<EventTicketRepository>();
  final paymentRepository = getIt<PaymentRepository>();
  final String? selectedNetwork;
  final _web3Repository = getIt<Web3Repository>();

  EventJoinRequest? _currentEventJoinRequest;
  Payment? _currentPayment;
  String? _signature;
  String? _txHash;
  String? _erc20approveTxHash;
  int _updatePaymentAttemptCount = 0;
  final walletConnectService = getIt<WalletConnectService>();

  BuyTicketsWithCryptoBloc({
    required this.selectedNetwork,
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
            network: selectedNetwork,
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
          await _web3Repository.getChainById(chainId: selectedNetwork!);
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
              network: selectedNetwork!,
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
          await _web3Repository.getChainById(chainId: selectedNetwork!);
      final chain = getChainResult.getOrElse(() => null);
      final contractAddress =
          event.currencyInfo.contracts?[selectedNetwork] ?? '';

      if (contractAddress.isEmpty) {
        return emit(
          BuyTicketsWithCryptoState.failure(
            data: state.data,
            failureReason: InitCryptoPaymentFailure(),
          ),
        );
      }
      late EthereumTransaction ethereumTxn;

      if (_currentPayment?.accountExpanded?.type ==
          PaymentAccountType.ethereumRelay) {
        final relayContract = Web3ContractService.getRelayPaymentContract(
          chain?.relayPaymentContract ?? '',
        );
        // token address (can be native token or ERC20 token)
        final currencyAddress = _currentPayment?.accountExpanded?.accountInfo
                ?.currencyMap?[event.currency]?.contracts?[selectedNetwork] ??
            '';
        // if currency is not native token
        // need to approve first
        if (currencyAddress != zeroAddress && _erc20approveTxHash == null) {
          final erc20Contract = Web3ContractService.getERC20Contract(
            currencyAddress,
          );
          final approveContractCall = Transaction.callContract(
            contract: erc20Contract,
            function: erc20Contract.function('approve'),
            parameters: [
              EthereumAddress.fromHex(
                chain?.relayPaymentContract ?? '',
              ),
              event.amount,
            ],
          );
          final ethereumTxn = EthereumTransaction(
            from: event.from,
            to: currencyAddress,
            value: BigInt.zero.toRadixString(16),
            data: hex.encode(List<int>.from(approveContractCall.data!)),
          );
          final txHash = await walletConnectService.requestTransaction(
            chainId: chain?.fullChainId ?? '',
            transaction: ethereumTxn,
          );
          if (txHash.isEmpty || !txHash.startsWith("0x")) {
            return emit(
              BuyTicketsWithCryptoState.failure(
                data: state.data,
                failureReason: WalletConnectFailure(),
              ),
            );
          }
          _erc20approveTxHash = txHash;
          await Future.delayed(
            Duration(seconds: chain?.completedBlockTime ?? 1),
          );
          final receipt = await Web3Utils.waitForReceipt(
            rpcUrl: chain?.rpcUrl ?? '',
            txHash: _erc20approveTxHash!,
            maxAttempt: 5,
            deplayDuration: const Duration(seconds: 5),
          );
          if (receipt?.status != true) {
            _erc20approveTxHash = null;
            return emit(
              BuyTicketsWithCryptoState.failure(
                data: state.data,
                failureReason: WalletConnectFailure(),
              ),
            );
          }
        }

        final contractCallTxn = Transaction.callContract(
          contract: relayContract,
          function: relayContract.function('pay'),
          parameters: [
            EthereumAddress.fromHex(
              _currentPayment
                      ?.accountExpanded?.accountInfo?.paymentSplitterContract ??
                  '',
            ),
            event.eventId,
            _currentPayment?.id ?? '',
            EthereumAddress.fromHex(currencyAddress),
            event.amount,
          ],
        );
        ethereumTxn = EthereumTransaction(
          from: event.from,
          to: chain?.relayPaymentContract ?? '',
          value: (currencyAddress == zeroAddress ? event.amount : BigInt.zero)
              .toRadixString(16),
          data: hex.encode(List<int>.from(contractCallTxn.data!)),
        );
      } else {
        // is erc20 token
        if (contractAddress != zeroAddress) {
          final contract =
              Web3ContractService.getERC20Contract(contractAddress);
          final contractCallTxn = Transaction.callContract(
            contract: contract,
            function: contract.function('transfer'),
            parameters: [
              EthereumAddress.fromHex(event.to),
              event.amount,
            ],
          );
          ethereumTxn = EthereumTransaction(
            from: event.from,
            to: contractAddress,
            value: BigInt.zero.toRadixString(16),
            data: hex.encode(List<int>.from(contractCallTxn.data!)),
          );
        } else {
          // is native token
          ethereumTxn = EthereumTransaction(
            from: event.from,
            to: event.to,
            value: event.amount.toRadixString(16),
          );
        }
      }

      _txHash = await walletConnectService
          .requestTransaction(
            chainId: chain?.fullChainId ?? '',
            transaction: ethereumTxn,
          )
          .timeout(
            const Duration(
              seconds: 30,
            ),
          );

      if (_txHash != null && _txHash!.startsWith('0x')) {
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
          network: selectedNetwork!,
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

class BuyWithCryptoFailure {}

class InitCryptoPaymentFailure extends BuyWithCryptoFailure {}

class WalletConnectFailure extends BuyWithCryptoFailure {
  final String? message;
  WalletConnectFailure({
    this.message,
  });
}

class UpdateCryptoPaymentFailure extends BuyWithCryptoFailure {}

class NotificationCryptoPaymentFailure extends BuyWithCryptoFailure {}
