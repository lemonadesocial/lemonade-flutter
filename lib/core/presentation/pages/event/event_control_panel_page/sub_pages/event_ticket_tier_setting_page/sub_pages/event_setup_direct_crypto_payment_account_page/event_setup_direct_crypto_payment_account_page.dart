import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/input/create_payment_account_input/create_payment_account_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/service/web3/lemonade_relay/lemonade_relay_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart' as web3modal;

class EventSetupDirectCryptoPaymentAccountPage extends StatefulWidget {
  final Chain chain;
  const EventSetupDirectCryptoPaymentAccountPage({
    super.key,
    required this.chain,
  });

  @override
  State<EventSetupDirectCryptoPaymentAccountPage> createState() =>
      _EventSetupDirectCryptoPaymentAccountPageState();
}

class _EventSetupDirectCryptoPaymentAccountPageState
    extends State<EventSetupDirectCryptoPaymentAccountPage> {
  final textController = TextEditingController();
  bool isValid = false;
  bool isLoading = false;
  PaymentAccount? _createdPaymentAccount;

  @override
  void initState() {
    super.initState();
    textController.text =
        context.read<WalletBloc>().state.activeSession?.address ?? '';
    textController.addListener(() {
      setState(() {
        isValid = _validatePayeeAddress(textController.text);
      });
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  String _getPayeeAddress() => textController.text;

  bool _validatePayeeAddress(String value) {
    try {
      web3modal.EthereumAddress.fromHex(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _onSubmit(
    Event event,
  ) async {
    setState(() {
      isLoading = true;
    });
    _createdPaymentAccount ??= await _createEthereumRelayPaymentAccount(
      selectedChain: widget.chain,
      userWalletAddress:
          context.read<WalletBloc>().state.activeSession?.address ?? '',
      payeeAddress: _getPayeeAddress(),
    );
    if (_createdPaymentAccount == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final updatedEvent = await _updateEventWithNewPaymentAccount(
      event: event,
      newPaymentAccount: _createdPaymentAccount!,
    );
    setState(() {
      isLoading = false;
    });
    if (updatedEvent == null) {
      return;
    }
    context
        .read<GetEventDetailBloc>()
        .add(GetEventDetailEvent.fetch(eventId: event.id ?? ''));
    if (_createdPaymentAccount != null) {
      SnackBarUtils.showSuccess(
        message: t.event.ticketTierSetting
            .chainActivated(chainName: widget.chain.name ?? ''),
      );
      Navigator.of(context).pop(_createdPaymentAccount!);
    }
  }

  Future<PaymentAccount?> _createEthereumRelayPaymentAccount({
    required Chain selectedChain,
    required String userWalletAddress,
    required String payeeAddress,
  }) async {
    final paymentSplitterContract = (await LemonadeRelayUtils.register(
      chain: selectedChain,
      payeeAddress: payeeAddress,
      userWalletAddress: userWalletAddress,
    ))
        .fold(
      (l) {
        SnackBarUtils.showError(
          message: l.message,
        );
        return null;
      },
      (r) => r,
    );

    if (paymentSplitterContract == null) {
      return null;
    }
    final result = await getIt<PaymentRepository>().createPaymentAccount(
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
    return result.fold(
      (l) => null,
      (r) => r,
    );
  }

  Future<Event?> _updateEventWithNewPaymentAccount({
    required Event event,
    required PaymentAccount newPaymentAccount,
  }) async {
    final result = await getIt<EventRepository>().updateEvent(
      input: Input$EventInput(
        payment_accounts_new: [
          ...event.paymentAccountsNew ?? [],
          newPaymentAccount.id ?? '',
        ],
      ),
      id: event.id ?? '',
    );
    return result.fold(
      (l) => null,
      (r) => r,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletBloc, WalletState>(
      listener: (context, state) {
        if (state.activeSession?.address != null) {
          textController.text = state.activeSession?.address ?? '';
          setState(() {
            isValid = _validatePayeeAddress(textController.text);
          });
        }
      },
      builder: (context, state) {
        final t = Translations.of(context);
        final colorScheme = Theme.of(context).colorScheme;
        final userWalletAddress = state.activeSession?.address;
        final event = context.read<GetEventDetailBloc>().state.maybeWhen(
              orElse: () => null,
              fetched: (event) => event,
            );
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: BottomSheetGrabber(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.chain.logoUrl?.isNotEmpty == true) ...[
                        LemonNetworkImage(
                          imageUrl: widget.chain.logoUrl ?? '',
                          width: Sizing.small,
                          height: Sizing.small,
                        ),
                        SizedBox(height: Spacing.medium),
                      ],
                      Text(
                        '${t.event.ticketTierSetting.activate} ${widget.chain.name}',
                        style: Typo.extraLarge.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        t.event.ticketTierSetting.activateChainDescription(
                          chainName: widget.chain.name ?? '',
                        ),
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                      SizedBox(height: Spacing.medium),
                      LemonTextField(
                        controller: textController,
                        filled: true,
                        fillColor: colorScheme.onPrimary.withOpacity(0.06),
                        borderColor: Colors.transparent,
                        hintText: t.event.ticketTierSetting.walletId,
                        autofocus: true,
                      ),
                      SizedBox(height: Spacing.medium),
                      if (userWalletAddress == null)
                        const ConnectWalletButton(),
                      if (userWalletAddress != null)
                        Opacity(
                          opacity: (isValid && !isLoading) ? 1 : 0.5,
                          child: LinearGradientButton.primaryButton(
                            label: t.event.ticketTierSetting.activate,
                            loadingWhen: isLoading,
                            onTap: () {
                              if (isLoading) {
                                return;
                              }
                              if (event == null) {
                                SnackBarUtils.showError(
                                  message: 'Event not found',
                                );
                                return;
                              }
                              _onSubmit(event);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
