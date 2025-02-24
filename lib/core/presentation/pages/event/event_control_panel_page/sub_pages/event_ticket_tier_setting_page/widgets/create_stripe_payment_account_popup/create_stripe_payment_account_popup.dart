import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/widgets/create_stripe_payment_account_popup/setup_stripe_payment_account_builder.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateStripePaymentAccountPopup extends StatelessWidget {
  const CreateStripePaymentAccountPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return SetupStripePaymentAccountBuilder(
      onPaymentAccountCreated: (paymentAccount) {
        Navigator.of(context).pop(paymentAccount);
      },
      builder: (state) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.center,
                child: BottomSheetGrabber(),
              ),
              SizedBox(height: Spacing.xSmall),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.event.ticketTierSetting.stripeSetup,
                      style: Typo.extraLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      t.event.ticketTierSetting.stripeSetupDesc,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(height: Spacing.medium),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(LemonRadius.small),
                        border: Border.all(
                          color: colorScheme.outline,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(Spacing.smMedium),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Assets.icons.icLemonConnectStripe.svg(),
                                SizedBox(height: Spacing.smMedium),
                                Text(
                                  t.event.ticketTierSetting.startSelling,
                                  style: Typo.medium.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                                Text(
                                  t.event.ticketTierSetting.startSellingDesc,
                                  style: Typo.small.copyWith(
                                    color: colorScheme.onSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: colorScheme.outline,
                            height: 1.w,
                          ),
                          InkWell(
                            onTap: () async {
                              if (state.isCreatingPaymentAccount) {
                                return;
                              }
                              if (!state.stripeConnected) {
                                await state.connectStripe();
                              } else {
                                if (!state.stripePaymentAccountCreated) {
                                  await state.createStripePaymentAccount();
                                } else {
                                  Navigator.of(context)
                                      .pop(state.getStripePaymentAccount());
                                }
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(Spacing.smMedium),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.isCreatingPaymentAccount
                                        ? t.event.ticketTierSetting.settingUp
                                        : t.event.ticketTierSetting.getStarted,
                                    style: Typo.medium.copyWith(
                                      color: LemonColor.paleViolet,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  ThemeSvgIcon(
                                    color: LemonColor.paleViolet,
                                    builder: (filter) =>
                                        Assets.icons.icExpand.svg(
                                      colorFilter: filter,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
