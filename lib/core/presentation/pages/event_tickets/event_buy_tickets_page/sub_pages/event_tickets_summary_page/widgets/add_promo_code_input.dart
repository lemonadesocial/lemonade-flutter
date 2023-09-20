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
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPromoCodeInput extends StatelessWidget {
  const AddPromoCodeInput({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: SizedBox(
        height: Sizing.xLarge,
        child: LemonTextField(
          hintText: t.event.eventBuyTickets.enterPromoCode,
          onChange: (value) {},
          suffixIcon: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // TODO: switch between applied badge and apply button
              // ApplyPromoCodeButton(),
              AppliedPromoCodeBadge()
            ],
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
  const ApplyPromoCodeButton({
    super.key,
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
