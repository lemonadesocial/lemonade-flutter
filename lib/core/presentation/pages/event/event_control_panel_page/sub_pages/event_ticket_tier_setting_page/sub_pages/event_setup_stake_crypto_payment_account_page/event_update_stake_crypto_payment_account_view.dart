import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_setup_stake_crypto_payment_account_page/widgets/stake_vault_datetime_selection_buttons.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/web3/stake/lemonade_stake_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventUpdateStakeCryptoPaymentAccountView extends StatelessWidget {
  final Chain chain;
  final PaymentAccount paymentAccount;
  final DateTime checkinBefore;
  final bool isLoading;
  final Function(DateTime) onDateTimeChanged;
  final Function(Event) onUpdate;

  const EventUpdateStakeCryptoPaymentAccountView({
    super.key,
    required this.chain,
    required this.paymentAccount,
    required this.checkinBefore,
    required this.isLoading,
    required this.onDateTimeChanged,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;

    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (chain.logoUrl?.isNotEmpty == true) ...[
          LemonNetworkImage(
            imageUrl: chain.logoUrl ?? '',
            width: Sizing.small,
            height: Sizing.small,
          ),
          SizedBox(height: Spacing.medium),
        ],
        Text(
          t.event.ticketTierSetting.chainActivated(chainName: chain.name ?? ''),
          style: Typo.extraLarge.copyWith(
            color: appColors.textPrimary,
          ),
        ),
        Text(
          t.event.ticketTierSetting.stakeActivatedDescription(
            chainName: chain.name ?? '',
          ),
          style: Typo.medium.copyWith(
            color: appColors.textTertiary,
          ),
        ),
        SizedBox(height: Spacing.medium),
        // Wallet ID field (read-only)
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(Spacing.small),
          decoration: BoxDecoration(
            color: appColors.cardBg,
            borderRadius: BorderRadius.circular(LemonRadius.medium),
          ),
          child: Row(
            children: [
              ThemeSvgIcon(
                color: appColors.textTertiary,
                builder: (filter) => Assets.icons.icWallet.svg(
                  colorFilter: filter,
                ),
              ),
              SizedBox(width: Spacing.small),
              Expanded(
                child: FutureBuilder(
                  future: LemonadeStakeUtils.getPayoutAddress(
                    chain: chain,
                    configId: paymentAccount.accountInfo?.configId ?? '',
                  ),
                  builder: (context, snapshot) {
                    return Text(
                      Web3Utils.formatIdentifier(
                        snapshot.data?.toString() ?? '--',
                      ),
                      style: Typo.medium.copyWith(
                        color: appColors.textPrimary,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(Spacing.small),
          decoration: BoxDecoration(
            color: appColors.cardBg,
            borderRadius: BorderRadius.circular(LemonRadius.medium),
          ),
          child: Row(
            children: [
              ThemeSvgIcon(
                color: appColors.textTertiary,
                builder: (filter) => Assets.icons.icRefundDollar.svg(
                  colorFilter: filter,
                ),
              ),
              SizedBox(width: Spacing.small),
              Expanded(
                child: FutureBuilder(
                  future: LemonadeStakeUtils.getRefundPercentage(
                    chain: chain,
                    configId: paymentAccount.accountInfo?.configId ?? '',
                  ),
                  builder: (context, snapshot) {
                    return Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                '${snapshot.data != null ? (snapshot.data)?.toInt().toString() : '--'}% ${t.event.ticketTierSetting.refundToGuest} ',
                          ),
                          TextSpan(
                            text: t.event.ticketTierSetting
                                .refundPercentDescription,
                            style: Typo.medium.copyWith(
                              color: appColors.textTertiary,
                            ),
                          ),
                        ],
                        style: Typo.medium.copyWith(
                          color: appColors.textPrimary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Spacing.medium),
        Text(
          t.event.ticketTierSetting.checkinBefore,
          style: Typo.medium.copyWith(
            color: appColors.textTertiary,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        StakeVaultDateTimeSelectionButtons(
          dateTime: checkinBefore,
          onDateTimeChanged: onDateTimeChanged,
        ),
        SizedBox(height: Spacing.medium),
        LinearGradientButton.primaryButton(
          label: t.common.actions.save,
          loadingWhen: isLoading,
          onTap: () {
            if (isLoading) return;
            if (event == null) {
              SnackBarUtils.showError(
                message: 'Event not found',
              );
              return;
            }
            onUpdate(event);
          },
        ),
      ],
    );
  }
}
