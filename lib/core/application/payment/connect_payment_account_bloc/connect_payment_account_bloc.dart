import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/input/create_payment_account_input/create_payment_account_input.dart';
import 'package:app/core/domain/payment/input/get_payment_accounts_input/get_payment_accounts_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/service/web3/lemonade_relay/lemonade_relay_utils.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_payment_account_bloc.freezed.dart';

class ConnectPaymentAccountBloc
    extends Bloc<ConnectPaymentAccountEvent, ConnectPaymentAccountState> {
  final Event event;
  final _paymentRepository = getIt<PaymentRepository>();
  final _eventRepository = getIt<EventRepository>();

  ConnectPaymentAccountBloc({
    required this.event,
  }) : super(ConnectPaymentAccountState.idle()) {
    on<_CheckPaymentAccountConnected>(_onCheck);
  }

  Future<void> _onCheck(
    _CheckPaymentAccountConnected blocEvent,
    Emitter emit,
  ) async {
    emit(ConnectPaymentAccountState.checkingPaymentAccount());
    final connectedPaymentAccounts = _getConnectedPaymentAccounts();
    final userPaymentAccounts = await _getUserPaymentAccounts();
    final selectedCurrency = blocEvent.currency;
    final selectedChain = blocEvent.selectedChain;
    final userWalletAddress = blocEvent.userWalletAddress;

    // check if event already connected with desired payment account
    if (_hasConnectedPaymentAccount(
      connectedPaymentAccounts: connectedPaymentAccounts,
      currency: selectedCurrency,
      selectedChain: selectedChain,
    )) {
      return emit(ConnectPaymentAccountState.paymentAccountConnected());
    }

    PaymentAccount? newPaymentAccount;
    // if not connected,
    // check if user already created with desired payment account
    final createdPaymentAccount = _getCreatedPaymentAccount(
      userPaymentAccounts: userPaymentAccounts,
      currency: selectedCurrency,
      selectedChain: selectedChain,
    );

    // if not created, created an payment account for user
    if (createdPaymentAccount == null) {
      if (selectedChain != null && userWalletAddress != null) {
        newPaymentAccount = await _createEthereumPaymentAccount(
          selectedChain: selectedChain,
          userWalletAddress: userWalletAddress,
        );
      } else {
        newPaymentAccount = await _createStripePaymentAccount();
      }
    } else {
      newPaymentAccount = createdPaymentAccount;
    }

    if (newPaymentAccount == null) {
      return emit(ConnectPaymentAccountState.checkPaymentAccountFailed());
    }

    // connect desired payment account with the event
    var updatedEvent =
        await _updateEventWithNewPaymentAccount(newPaymentAccount);
    if (updatedEvent == null) {
      return emit(ConnectPaymentAccountState.checkPaymentAccountFailed());
    }

    emit(
      ConnectPaymentAccountState.paymentAccountConnected(
        updatedEvent: updatedEvent,
      ),
    );
  }

  Future<Event?> _updateEventWithNewPaymentAccount(
    PaymentAccount newPaymentAccount,
  ) async {
    final result = await _eventRepository.updateEvent(
      input: Input$EventInput(
        payment_accounts_new: [
          ...event.paymentAccountsNew ?? [],
          newPaymentAccount.id ?? '',
        ],
      ),
      id: event.id ?? '',
    );
    if (result.isLeft()) {
      return null;
    }
    return result.getOrElse(() => Event());
  }

  // Only support creating Ethereum Relay payment account
  Future<PaymentAccount?> _createEthereumPaymentAccount({
    required Chain selectedChain,
    required String userWalletAddress,
  }) async {
    final paymentSplitterContractRes = await LemonadeRelayUtils.register(
      chain: selectedChain,
      payeeAddress: userWalletAddress,
    );
    if (paymentSplitterContractRes.isLeft()) {
      return null;
    }
    final paymentSplitterContract =
        paymentSplitterContractRes.getOrElse(() => "");
    final result = await _paymentRepository.createPaymentAccount(
      input: CreatePaymentAccountInput(
        type: PaymentAccountType.ethereumRelay,
        accountInfo: AccountInfoInput(
          address: userWalletAddress,
          currencies:
              selectedChain.tokens?.map((item) => item.symbol ?? '').toList() ??
                  [],
          network: selectedChain.chainId,
          paymentSplitterContract: paymentSplitterContract,
        ),
      ),
    );
    if (result.isLeft()) {
      return null;
    }
    return result.getOrElse(() => PaymentAccount());
  }

  Future<PaymentAccount?> _createStripePaymentAccount() async {
    final result = await _paymentRepository.createPaymentAccount(
      input: CreatePaymentAccountInput(
        type: PaymentAccountType.digital,
        provider: PaymentProvider.stripe,
      ),
    );
    if (result.isLeft()) {
      return null;
    }
    return result.getOrElse(() => PaymentAccount());
  }

  bool _hasConnectedPaymentAccount({
    required List<PaymentAccount> connectedPaymentAccounts,
    required String currency,
    Chain? selectedChain,
  }) {
    bool foundAccount;
    if (selectedChain != null) {
      foundAccount = EventTicketUtils.findEthereumPaymentAccount(
            connectedPaymentAccounts,
            network: selectedChain.chainId ?? '',
            currency: currency,
          ) !=
          null;
    } else {
      foundAccount =
          EventTicketUtils.findStripePaymentAccount(connectedPaymentAccounts) !=
              null;
    }
    return foundAccount;
  }

  PaymentAccount? _getCreatedPaymentAccount({
    required List<PaymentAccount> userPaymentAccounts,
    required String currency,
    Chain? selectedChain,
  }) {
    PaymentAccount? createdPaymentAccount;
    if (selectedChain != null) {
      createdPaymentAccount = EventTicketUtils.findEthereumPaymentAccount(
        userPaymentAccounts,
        network: selectedChain.chainId ?? '',
        currency: currency,
      );
    } else {
      createdPaymentAccount =
          EventTicketUtils.findStripePaymentAccount(userPaymentAccounts);
    }
    return createdPaymentAccount;
  }

  Future<List<PaymentAccount>> _getUserPaymentAccounts() async {
    final result = await _paymentRepository.getPaymentAccounts(
      input: GetPaymentAccountsInput(),
    );
    if (result.isLeft()) {
      return [];
    }
    return result.getOrElse(() => []);
  }

  List<PaymentAccount> _getConnectedPaymentAccounts() {
    return event.paymentAccountsExpanded ?? [];
  }
}

@freezed
class ConnectPaymentAccountEvent with _$ConnectPaymentAccountEvent {
  factory ConnectPaymentAccountEvent.checkEventHasPaymentAccount({
    required String currency,
    Chain? selectedChain,
    String? userWalletAddress,
  }) = _CheckPaymentAccountConnected;
}

@freezed
class ConnectPaymentAccountState with _$ConnectPaymentAccountState {
  factory ConnectPaymentAccountState.idle() = _Idle;
  factory ConnectPaymentAccountState.checkingPaymentAccount() =
      _CheckingPaymentAccount;
  factory ConnectPaymentAccountState.paymentAccountConnected({
    Event? updatedEvent,
  }) = _PaymentAccountConnected;
  factory ConnectPaymentAccountState.checkPaymentAccountFailed() =
      _CheckPaymentAccountFailed;
}
