import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart' as event_entity;
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/input/create_payment_account_input/create_payment_account_input.dart';
import 'package:app/core/domain/payment/input/update_payment_account_input/update_payment_account_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_setup_stake_crypto_payment_account_page/event_update_stake_crypto_payment_account_view.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_setup_stake_crypto_payment_account_page/widgets/stake_vault_datetime_selection_buttons.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/service/web3/stake/lemonade_stake_vault_factory.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventSetupStakeCryptoPaymentAccountPage extends StatefulWidget {
  final Chain chain;
  final PaymentAccount? activatedPaymentAccount;
  const EventSetupStakeCryptoPaymentAccountPage({
    super.key,
    required this.chain,
    this.activatedPaymentAccount,
  });

  @override
  State<EventSetupStakeCryptoPaymentAccountPage> createState() =>
      _EventSetupStakeCryptoPaymentAccountPageState();
}

class _EventSetupStakeCryptoPaymentAccountPageState
    extends State<EventSetupStakeCryptoPaymentAccountPage> {
  final debouncer = Debouncer(milliseconds: 200);
  final walletIdController = TextEditingController();
  final percentageController = TextEditingController();
  DateTime checkinBefore = DateTime.now();
  bool isValid = false;
  bool isLoading = false;
  PaymentAccount? _createdPaymentAccount;

  @override
  void initState() {
    super.initState();
    // walletIdController.text =
    //     context.read<WalletBloc>().state.activeSession?.address ?? '';
    // TODO: FIX WALLET MIGRATION
    walletIdController.text = '';
    walletIdController.addListener(() {
      setState(() {
        isValid = _validate();
      });
    });
    percentageController.addListener(() {
      setState(() {
        isValid = _validate();
      });
    });

    if (widget.activatedPaymentAccount != null) {
      checkinBefore = widget
              .activatedPaymentAccount!.accountInfo?.requirementCheckinBefore ??
          DateTime.now();
      checkinBefore =
          checkinBefore.isUtc ? checkinBefore.toLocal() : checkinBefore;
    }
  }

  @override
  void dispose() {
    walletIdController.dispose();
    percentageController.dispose();
    super.dispose();
  }

  String _getUserWalletAddress() =>
      // context.read<WalletBloc>().state.activeSession?.address ?? '';
      // TODO: FIX WALLET MIGRATION
      '';

  String _getPayeeAddress() => walletIdController.text;

  /// input 50 === 50%
  double _getPercentage() => double.parse(
        percentageController.text.isEmpty ? '0' : percentageController.text,
      );

  DateTime _getCheckinBefore() =>
      !checkinBefore.isUtc ? checkinBefore.toUtc() : checkinBefore;

  bool _validatePayeeAddress(String value) {
    try {
      // web3modal.EthereumAddress.fromHex(value);
      // TODO: FIX WALLET MIGRATION
      return true;
    } catch (e) {
      return false;
    }
  }

  bool _validate() {
    return _validatePayeeAddress(walletIdController.text) &&
        _getPercentage() > 0;
  }

  Future<void> _onSubmit(
    event_entity.Event event,
  ) async {
    setState(() {
      isLoading = true;
    });
    _createdPaymentAccount ??=
        await _createEthereumStakePaymentAccount(event: event);
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

  Future<PaymentAccount?> _createEthereumStakePaymentAccount({
    required event_entity.Event event,
  }) async {
    final vaultSalt =
        (await getIt<Web3Repository>().getVaultSalt(eventId: event.id ?? ''))
            .fold(
      (l) {
        SnackBarUtils.showError(
          message: l.message,
        );
        return null;
      },
      (r) => r,
    );
    if (vaultSalt == null) {
      return null;
    }
    final stakeVaultFactory = LemonadeStakeVaultFactory(chain: widget.chain);
    final txHash = (await stakeVaultFactory.createVault(
      payoutAddress: _getPayeeAddress(),
      percentage: _getPercentage(),
      salt: vaultSalt,
      userWalletAddress: _getUserWalletAddress(),
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

    if (txHash == null) {
      return null;
    }
    final vaultId =
        (await stakeVaultFactory.getVaultAddressFromTransaction(txHash)).fold(
      (l) {
        SnackBarUtils.showError(
          message: l.message,
        );
        return null;
      },
      (r) => r,
    );
    if (vaultId == null) {
      return null;
    }
    final result = await getIt<PaymentRepository>().createPaymentAccount(
      input: CreatePaymentAccountInput(
        type: PaymentAccountType.ethereumStake,
        accountInfo: AccountInfoInput(
          address: _getPayeeAddress(),
          configId: vaultId,
          currencies:
              widget.chain.tokens?.map((item) => item.symbol ?? '').toList() ??
                  [],
          network: widget.chain.chainId,
          requirementCheckinBefore: _getCheckinBefore(),
        ),
      ),
    );
    return result.fold(
      (l) => null,
      (r) => r,
    );
  }

  Future<event_entity.Event?> _updateEventWithNewPaymentAccount({
    required event_entity.Event event,
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

  Future<void> _onUpdate(event_entity.Event event) async {
    setState(() {
      isLoading = true;
    });

    final result = await getIt<PaymentRepository>().updatePaymentAccount(
      input: UpdatePaymentAccountInput(
        id: widget.activatedPaymentAccount!.id ?? '',
        accountInfo: AccountInfoInput(
          address: widget.activatedPaymentAccount!.accountInfo?.address,
          configId: widget.activatedPaymentAccount!.accountInfo?.configId,
          currencies: widget.activatedPaymentAccount!.accountInfo?.currencies,
          network: widget.activatedPaymentAccount!.accountInfo?.network,
          requirementCheckinBefore: _getCheckinBefore(),
        ),
      ),
    );

    setState(() {
      isLoading = false;
    });

    result.fold(
      (failure) {
        SnackBarUtils.showError(message: failure.message);
      },
      (updatedAccount) {
        context.read<GetEventDetailBloc>().add(
              GetEventDetailEvent.fetch(eventId: event.id ?? ''),
            );
        Navigator.of(context).pop(updatedAccount);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletBloc, WalletState>(
      listener: (context, state) {
        // TODO: FIX WALLET MIGRATION
        // if (state.activeSession?.address != null) {
        //   walletIdController.text = state.activeSession?.address ?? '';
        //   setState(() {
        //     isValid = _validate();
        //   });
        // }
      },
      builder: (context, state) {
        final t = Translations.of(context);
        final colorScheme = Theme.of(context).colorScheme;
        // TODO: FIX WALLET MIGRATION
        // final userWalletAddress = state.activeSession?.address;
        final userWalletAddress = '';
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
                widget.activatedPaymentAccount != null
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Spacing.small),
                        child: EventUpdateStakeCryptoPaymentAccountView(
                          chain: widget.chain,
                          paymentAccount: widget.activatedPaymentAccount!,
                          checkinBefore: checkinBefore,
                          isLoading: isLoading,
                          onDateTimeChanged: (newDateTime) {
                            debouncer.run(() {
                              setState(() {
                                checkinBefore = newDateTime;
                              });
                            });
                          },
                          onUpdate: _onUpdate,
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Spacing.small),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.chain.logoUrl?.isNotEmpty ==
                                    true) ...[
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
                                  t.event.ticketTierSetting
                                      .activateStakeChainDescription(
                                    chainName: widget.chain.name ?? '',
                                  ),
                                  style: Typo.medium.copyWith(
                                    color: colorScheme.onSecondary,
                                  ),
                                ),
                                SizedBox(height: Spacing.medium),
                                LemonTextField(
                                  controller: walletIdController,
                                  filled: true,
                                  fillColor:
                                      colorScheme.onPrimary.withOpacity(0.06),
                                  borderColor: Colors.transparent,
                                  hintText: t.event.ticketTierSetting.walletId,
                                  autofocus: true,
                                ),
                                SizedBox(height: Spacing.medium),
                                Text(
                                  t.event.ticketTierSetting.checkinBefore,
                                  style: Typo.medium.copyWith(
                                    color: colorScheme.onSecondary,
                                  ),
                                ),
                                SizedBox(height: Spacing.xSmall),
                                StakeVaultDateTimeSelectionButtons(
                                  dateTime: checkinBefore,
                                  onDateTimeChanged: (newDateTime) {
                                    debouncer.run(() {
                                      setState(() {
                                        checkinBefore = newDateTime;
                                      });
                                    });
                                  },
                                ),
                                SizedBox(height: Spacing.medium),
                                Text(
                                  t.event.ticketTierSetting.refundPercent,
                                  style: Typo.medium.copyWith(
                                    color: colorScheme.onSecondary,
                                  ),
                                ),
                                SizedBox(height: Spacing.xSmall),
                                LemonTextField(
                                  controller: percentageController,
                                  filled: true,
                                  fillColor:
                                      colorScheme.onPrimary.withOpacity(0.06),
                                  borderColor: Colors.transparent,
                                  hintText: '50%',
                                  autofocus: true,
                                  textInputType:
                                      const TextInputType.numberWithOptions(
                                    decimal: false,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
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
