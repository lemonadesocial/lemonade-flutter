import 'package:app/core/application/event_tickets/calculate_event_tickets_pricing_bloc/calculate_event_tickets_pricing_bloc.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPromoCodeInput extends StatefulWidget {
  final Function(String? promoCode)? onPressApply;
  final EventTicketsPricingInfo? pricingInfo;

  const AddPromoCodeInput({
    super.key,
    this.onPressApply,
    this.pricingInfo,
  });

  @override
  State<AddPromoCodeInput> createState() => _AddPromoCodeInputState();
}

class _AddPromoCodeInputState extends State<AddPromoCodeInput> {
  final promoTextController = TextEditingController();
  bool applied = false;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return BlocListener<CalculateEventTicketPricingBloc,
        CalculateEventTicketPricingState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          failure: (pricingInfo) {
            setState(() {
              promoTextController.text = pricingInfo?.promoCode ?? '';
              applied = pricingInfo?.promoCode?.isNotEmpty == true &&
                  pricingInfo?.discount != null;
            });
          },
          success: (pricingInfo) {
            setState(() {
              promoTextController.text = pricingInfo.promoCode ?? '';
              applied = pricingInfo.promoCode?.isNotEmpty == true &&
                  pricingInfo.discount != null;
            });
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        child: SizedBox(
          height: Sizing.xLarge,
          child: LemonTextField(
            onChange: (value) {
              setState(() {
                applied = false;
              });
            },
            controller: promoTextController,
            hintText: t.event.eventBuyTickets.enterPromoCode,
            suffixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (promoTextController.text.isNotEmpty)
                  InkWell(
                    onTap: () {
                      promoTextController.text = '';
                      widget.onPressApply?.call(null);
                    },
                    child: Assets.icons.icClose.svg(),
                  ),
                if (!applied)
                  ApplyPromoCodeButton(
                    onPress: () {
                      if (promoTextController.text.isEmpty) return;
                      widget.onPressApply?.call(promoTextController.text);
                    },
                  ),
                if (applied) const AppliedPromoCodeBadge(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppliedPromoCodeBadge extends StatelessWidget {
  const AppliedPromoCodeBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Container(
      width: 90.w,
      height: Sizing.medium,
      margin: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.button),
        color: LemonColor.promoAppliedBackground,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            t.common.applied,
            style: Typo.small.copyWith(
              color: LemonColor.promoApplied,
            ),
          ),
          SizedBox(width: Spacing.extraSmall / 2),
          ThemeSvgIcon(
            color: LemonColor.promoApplied,
            builder: (filter) => Assets.icons.icDone.svg(
              colorFilter: filter,
              width: Sizing.xSmall,
              height: Sizing.xSmall,
            ),
          ),
        ],
      ),
    );
  }
}

class ApplyPromoCodeButton extends StatelessWidget {
  final Function()? onPress;

  const ApplyPromoCodeButton({
    super.key,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
      width: Sizing.regular * 2,
      height: Sizing.medium,
      child: LinearGradientButton(
        onTap: onPress,
        label: t.common.apply,
        radius: BorderRadius.circular(LemonRadius.button),
        textStyle: Typo.small.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
