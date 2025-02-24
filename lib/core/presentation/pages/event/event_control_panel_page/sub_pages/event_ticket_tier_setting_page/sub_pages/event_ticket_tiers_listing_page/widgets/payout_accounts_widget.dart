import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/widgets/create_stripe_payment_account_popup/create_stripe_payment_account_popup.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/payment/mutation/disconnect_stripe_account_mutation.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:web3modal_flutter/services/explorer_service/explorer_service_singleton.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart' as web3modal_flutter;

class PayoutAccountsWidget extends StatefulWidget {
  const PayoutAccountsWidget({super.key});

  @override
  State<PayoutAccountsWidget> createState() => _PayoutAccountsWidgetState();
}

class _PayoutAccountsWidgetState extends State<PayoutAccountsWidget>
    with WidgetsBindingObserver {
  Future<void> _connectStripe() async {
    await showCupertinoModalBottomSheet<PaymentAccount>(
      context: context,
      backgroundColor: LemonColor.atomicBlack,
      barrierColor: Colors.black.withOpacity(0.5),
      expand: false,
      builder: (context) => const CreateStripePaymentAccountPopup(),
    );
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
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final loggedInUser = state.maybeWhen(
              orElse: () => null,
              authenticated: (user) => user,
            );

            final hasStripeConnected =
                loggedInUser?.stripeConnectedAccount != null &&
                    loggedInUser?.stripeConnectedAccount?.connected == true;
            return PayoutAccountItem(
              radiusTop: true,
              radiusBottom: false,
              title: hasStripeConnected
                  ? t.event.ticketTierSetting.stripeConnected
                  : t.event.ticketTierSetting.connectStripe,
              subTitle: t.event.ticketTierSetting.connectStripeDesc,
              icon: hasStripeConnected
                  ? Assets.icons.icStripe.svg()
                  : ThemeSvgIcon(
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
        Divider(
          height: 1,
          color: colorScheme.outline,
        ),
        BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) {
            final fallbackIcon = ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icWallet.svg(
                colorFilter: filter,
              ),
            );
            final activeSession = state.activeSession;
            final userWalletAddress =
                getIt<WalletConnectService>().w3mService.session?.address ?? '';
            return PayoutAccountItem(
              radiusTop: false,
              radiusBottom: true,
              title: activeSession != null
                  ? t.event.ticketTierSetting.walletConnected
                  : t.event.ticketTierSetting.connectWallet,
              subTitle: activeSession != null
                  ? Web3Utils.formatIdentifier(userWalletAddress)
                  : t.event.ticketTierSetting.connectWalletDesc,
              icon: activeSession != null
                  ? LemonNetworkImage(
                      imageUrl: explorerService.instance.getWalletImageUrl(
                        getIt<WalletConnectService>()
                                .w3mService
                                .selectedWallet
                                ?.listing
                                .imageId ??
                            '',
                      ),
                      height: Sizing.mSmall,
                      width: Sizing.mSmall,
                      placeholder: fallbackIcon,
                    )
                  : fallbackIcon,
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
  final bool radiusTop;
  final bool radiusBottom;

  const PayoutAccountItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.buttonBuilder,
    this.radiusTop = false,
    this.radiusBottom = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.only(
          topLeft:
              radiusTop ? Radius.circular(LemonRadius.medium) : Radius.zero,
          topRight:
              radiusTop ? Radius.circular(LemonRadius.medium) : Radius.zero,
          bottomLeft:
              radiusBottom ? Radius.circular(LemonRadius.medium) : Radius.zero,
          bottomRight:
              radiusBottom ? Radius.circular(LemonRadius.medium) : Radius.zero,
        ),
      ),
      child: Row(
        children: [
          icon,
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
