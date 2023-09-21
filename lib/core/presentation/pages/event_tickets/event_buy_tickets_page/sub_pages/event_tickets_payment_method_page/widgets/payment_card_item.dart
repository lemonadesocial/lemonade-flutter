import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentCardItem extends StatelessWidget {
  const PaymentCardItem({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.small),
        color: colorScheme.onPrimary.withOpacity(0.06),
      ),
      child: Row(
        children: [
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
            child: Center(
              child: Assets.icons.icVisa.image(
                width: Sizing.small,
                height: 7.w,
              ),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deutsche Bank Card',
                style: Typo.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onPrimary.withOpacity(0.87),
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                t.event.eventPayment.cardEnding(lastCardNumber: '6719'),
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              )
            ],
          ),
          const Spacer(),
          // TODO: selected state
          // Assets.icons.icInvitedFilled.svg(),
          ThemeSvgIcon(
            color: colorScheme.onSurfaceVariant,
            builder: (filter) =>
                Assets.icons.icCircleEmpty.svg(colorFilter: filter),
          ),
          SizedBox(width: 1.w)
        ],
      ),
    );
  }
}
