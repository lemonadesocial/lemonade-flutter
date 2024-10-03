import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/promo_code/promo_code_input_bottomsheet.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PromoCodeSummary extends StatelessWidget {
  const PromoCodeSummary({
    super.key,
    required this.pricingInfo,
    this.onPressRemove,
    this.onPressApply,
  });

  final EventTicketsPricingInfo pricingInfo;
  final Function()? onPressRemove;
  final Function({
    String? promoCode,
  })? onPressApply;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    if (pricingInfo.promoCode == null ||
        pricingInfo.promoCode?.isEmpty == true) {
      return InkWell(
        onTap: () {
          showCupertinoModalBottomSheet(
            useRootNavigator: true,
            context: context,
            bounce: true,
            backgroundColor: LemonColor.atomicBlack,
            barrierColor: Colors.black.withOpacity(0.5),
            builder: (context) => PromoCodeInputBottomsheet(
              onPressApply: ({
                promoCode,
              }) {
                onPressApply?.call(promoCode: promoCode);
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          );
        },
        child: Text(
          t.event.eventBuyTickets.addDiscountCode,
          style: Typo.medium.copyWith(
            color: LemonColor.paleViolet,
          ),
        ),
      );
    }

    return Row(
      children: [
        Text(
          t.event.eventBuyTickets.discountCode,
          style: Typo.medium.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            onPressApply?.call(promoCode: null);
          },
          child: Row(
            children: [
              Text(
                pricingInfo.promoCode ?? '',
                style: Typo.medium.copyWith(
                  color: LemonColor.malachiteGreen,
                ),
              ),
              SizedBox(width: Spacing.extraSmall),
              Container(
                width: 18.w,
                height: 18.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(
                    color: colorScheme.outline,
                    width: 0.5.w,
                  ),
                ),
                child: Center(
                  child: ThemeSvgIcon(
                    builder: (filter) => Assets.icons.icClose.svg(
                      colorFilter: filter,
                      width: 12.w,
                      height: 12.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
