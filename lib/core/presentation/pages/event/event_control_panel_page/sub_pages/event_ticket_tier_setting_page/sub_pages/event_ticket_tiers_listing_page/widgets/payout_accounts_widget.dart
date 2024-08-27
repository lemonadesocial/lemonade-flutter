import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/input/create_payment_account_input/create_payment_account_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/payment/mutation/disconnect_stripe_account_mutation.graphql.dart';
import 'package:app/graphql/backend/payment/mutation/generate_stripe_account_link_mutation.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart' as web3modal_flutter;

class PayoutAccountsWidget extends StatefulWidget {
  const PayoutAccountsWidget({super.key});

  @override
  State<PayoutAccountsWidget> createState() => _PayoutAccountsWidgetState();
}

class _PayoutAccountsWidgetState extends State<PayoutAccountsWidget>
    with WidgetsBindingObserver {
  bool stripePaymentAccountCreated = false;

  bool hasStripePaymentAccount(Event? event) {
    final eventPaymentAccountsExpanded = event?.paymentAccountsExpanded ?? [];
    final hasStripePaymentAccount = eventPaymentAccountsExpanded.any(
      (item) => item.provider == PaymentProvider.stripe,
    );
    return hasStripePaymentAccount;
  }

  bool hasStripeConnected(User? loggedInUser) {
    final hasStripeConnected = loggedInUser?.stripeConnectedAccount != null &&
        loggedInUser?.stripeConnectedAccount?.connected == true;
    return hasStripeConnected;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final loggedInUser = context.read<AuthBloc>().state.maybeWhen(
            orElse: () => null,
            authenticated: (user) => user,
          );
      final event = context.read<GetEventDetailBloc>().state.maybeWhen(
            orElse: () => null,
            fetched: (event) => event,
          );
      if (hasStripeConnected(loggedInUser)) {
        if (!hasStripePaymentAccount(event)) {
          _createStripePaymentAccount();
        } else {
          stripePaymentAccountCreated = true;
        }
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    final loggedInUser = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );

    final hasStripeConnected = loggedInUser?.stripeConnectedAccount != null &&
        loggedInUser?.stripeConnectedAccount?.connected == true;
    if (!hasStripeConnected) {
      context.read<AuthBloc>().add(const AuthEvent.refreshData());
    }
  }

  Future<void> _createStripePaymentAccount() async {
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event,
          orElse: () => null,
        );

    final response = await showFutureLoadingDialog(
      context: context,
      future: () async {
        final createPaymentAccountResult =
            await getIt<PaymentRepository>().createPaymentAccount(
          input: CreatePaymentAccountInput(
            type: PaymentAccountType.digital,
            provider: PaymentProvider.stripe,
          ),
        );
        if (createPaymentAccountResult.isLeft()) {
          return null;
        }
        final newPaymentAccount =
            createPaymentAccountResult.getOrElse(() => PaymentAccount());
        final updateEventResult = await getIt<EventRepository>().updateEvent(
          input: Input$EventInput(
            payment_accounts_new: [
              ...event?.paymentAccountsNew ?? [],
              newPaymentAccount.id ?? '',
            ],
          ),
          id: event?.id ?? '',
        );
        return updateEventResult.fold((l) => null, (r) => r);
      },
    );

    if (response.result != null) {
      stripePaymentAccountCreated = true;

      context.read<GetEventDetailBloc>().add(
            GetEventDetailEvent.replace(event: response.result!),
          );
    }
  }

  Future<void> _connectStripe() async {
    final response = await showFutureLoadingDialog(
      context: context,
      future: () => getIt<AppGQL>().client.mutate$GenerateStripeAccountLink(
            Options$Mutation$GenerateStripeAccountLink(
              variables: Variables$Mutation$GenerateStripeAccountLink(
                returnUrl: AppConfig.webUrl,
                refreshUrl: AppConfig.webUrl,
              ),
            ),
          ),
    );
    final url = response.result?.parsedData?.generateStripeAccountLink.url;
    if (url != null) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _disconnectStripe() async {
    final response = await showFutureLoadingDialog(
      context: context,
      future: () => getIt<AppGQL>().client.mutate$disconnectStripeAccount(),
    );
    if (response.result?.parsedData?.disconnectStripeAccount == true) {
      context.read<AuthBloc>().add(const AuthEvent.refreshData());
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.ticketTierSetting.payoutAccounts,
          style: Typo.medium.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onPrimary,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (stripePaymentAccountCreated) {
              return;
            }
            final loggedInUser = state.maybeWhen(
              orElse: () => null,
              authenticated: (user) => user,
            );
            final event = context
                .read<GetEventDetailBloc>()
                .state
                .maybeWhen(orElse: () => null, fetched: (event) => event);
            if (hasStripeConnected(loggedInUser)) {
              if (!hasStripePaymentAccount(event)) {
                _createStripePaymentAccount();
              }
            }
          },
          builder: (context, state) {
            final loggedInUser = state.maybeWhen(
              orElse: () => null,
              authenticated: (user) => user,
            );

            final hasStripeConnected =
                loggedInUser?.stripeConnectedAccount != null &&
                    loggedInUser?.stripeConnectedAccount?.connected == true;
            return PayoutAccountItem(
              title: t.event.ticketTierSetting.creditDebit,
              subTitle: hasStripeConnected
                  ? t.event.ticketTierSetting.connected
                  : t.event.ticketTierSetting.connectAccount,
              icon: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icBank.svg(
                  colorFilter: filter,
                ),
              ),
              buttonBuilder: () {
                if (hasStripeConnected) {
                  return LinearGradientButton(
                    onTap: () {
                      _disconnectStripe();
                    },
                    height: Sizing.medium,
                    radius: BorderRadius.circular(LemonRadius.small * 2),
                    label: t.common.actions.disconnect,
                  );
                }
                return LinearGradientButton(
                  onTap: () {
                    _connectStripe();
                  },
                  height: Sizing.medium,
                  radius: BorderRadius.circular(LemonRadius.small * 2),
                  label: t.common.actions.connect,
                );
              },
            );
          },
        ),
        SizedBox(height: Spacing.xSmall),
        FutureBuilder<web3modal_flutter.W3MSession?>(
          future: getIt<WalletConnectService>().getActiveSession(),
          builder: (context, walletConnectSnapshot) {
            final activeSession = walletConnectSnapshot.data;
            final userWalletAddress =
                getIt<WalletConnectService>().w3mService.session?.address ?? '';
            return PayoutAccountItem(
              title: t.event.ticketTierSetting.crypto,
              subTitle: activeSession != null
                  ? Web3Utils.formatIdentifier(userWalletAddress)
                  : t.common.actions.connectWallet,
              icon: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icWallet.svg(
                  colorFilter: filter,
                ),
              ),
              buttonBuilder: () {
                if (activeSession != null) {
                  return InkWell(
                    onTap: () {},
                    child: ThemeSvgIcon(
                      color: colorScheme.onSurfaceVariant,
                      builder: (filter) => Assets.icons.icArrowRight.svg(
                        colorFilter: filter,
                      ),
                    ),
                  );
                }

                return ConnectWalletButton(
                  builder: (onPressConnect, connectButtonState) =>
                      LinearGradientButton(
                    loadingWhen: connectButtonState ==
                        web3modal_flutter.ConnectButtonState.connecting,
                    height: Sizing.medium,
                    radius: BorderRadius.circular(LemonRadius.small * 2),
                    label: t.common.actions.connect,
                    onTap: () => onPressConnect(context),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class PayoutAccountItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget icon;
  final Widget Function()? buttonBuilder;

  const PayoutAccountItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.buttonBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: Row(
        children: [
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(Sizing.medium),
            ),
            child: Center(
              child: icon,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.87),
                  ),
                ),
                SizedBox(height: 2.w),
                Text(
                  subTitle,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (buttonBuilder != null) buttonBuilder!.call(),
        ],
      ),
    );
  }
}
