import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickTicketItem extends StatelessWidget {
  const PickTicketItem({super.key});

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
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
            child: CachedNetworkImage(
              width: Sizing.medium,
              height: Sizing.medium,
              imageUrl:
                  "https://s3-alpha-sig.figma.com/img/8faa/f645/6998156f019e914793c44e7944b38cfd?Expires=1696204800&Signature=CSEQ68VzkrokU3ehR~uH1PPOgbLwkZXFLnyWQYL3mzEi5Ffd5yNwIKHU7QX6TsfMw1cMkvV3I64KllhiD~2lI3CCTkxm~pOzvr3VM95ZcxJDzPPE5y0w3vzx4x08hwdPlkceXDF-~kcSW8ji4QDDku6SIJxI1mzetk~kHWfj3BVSq~yRY6-H~fTpFuitbBnsKq08g~QVSNpvJlHWWwGtpzZCx4RA-YHsWfnIrmplqtbnyxj333oQEk4r4oqqKSkqzFScis1SFnGOxXQH-B2InN3IsVe38C6B0bRNaX9EMws9S454WNwc-7Dgw~owkLqL5WEHT3rsw2KgmnnDRDxr8g__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
              errorWidget: (_, __, ___) =>
                  ImagePlaceholder.defaultPlaceholder(),
              placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                NumberUtils.formatCurrency(
                  amount: 5000,
                  currency: Currency.USD,
                  prefix: "Festival Pass   ",
                ),
                style: Typo.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onPrimary.withOpacity(0.87),
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                '2 ${t.event.tickets(n: 2)}',
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              )
            ],
          ),
          const Spacer(),
          Assets.icons.icInvitedFilled.svg(),
          // TODO: unselected state
          // ThemeSvgIcon(
          //   color: colorScheme.onSurfaceVariant,
          //   builder: (filter) => Assets.icons.icCircleEmpty.svg(colorFilter: filter),
          // ),
        ],
      ),
    );
  }
}
