import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectTicketItem extends StatelessWidget {
  const SelectTicketItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.all(Spacing.smMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              child: CachedNetworkImage(
                imageUrl:
                    "https://s3-alpha-sig.figma.com/img/bceb/64a8/1944e0cbe8118bcba599a4dcd49dbae5?Expires=1696204800&Signature=DCVTcs0f10zt4oihidwZ~Dmax86HmZBR8E7e4zVJdjgKZvBvx6wX9nosEyuWC4OPHhPyvVxHbzLnYGYfOHYVOVn4tMI67IKIYtFc22iafH77z~KLneTFtpC8ynL0qm7~2-DE3Qui7hb~3u4ry7ZKQZnf~gLlQkJEqDKMuXrO-yR7ByBbGlFdgXXpfvQr639ihftYa8SufCeN8WwoDNZxbaD4ome2KxMY6LIy7cbuMFYqbug3zgsATRonbqw7RL5NmLstv-1UNSlONYBQiP8f-MGiLB1HM7PLXbP2dIp-3kIWalPCpMaACAaY5CiMEAmbvDg~JzYPzTLq-XnubKg4hA__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
                placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
                errorWidget: (_, __, ___) =>
                    ImagePlaceholder.defaultPlaceholder(),
              ),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          // ticket type name and description
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Regular - Free",
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.87),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.w),
                Text(
                  "Access to all zones, stages + 20% discount on all purchases through pop-up shops",
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          SizedBox(width: Spacing.smMedium),
          // quantity selection
          InkWell(
            child: Container(
              width: 70.w,
              height: Sizing.medium,
              decoration: BoxDecoration(
                color: colorScheme.onPrimary.withOpacity(0.05),
                // TODO:switch between no quantity and has quantity
                // color:  Colors.transparent,
                border: Border.all(
                  color: colorScheme.onPrimary.withOpacity(0.09),
                  // TODO:switch between no quantity and has quantity
                  // color:  colorScheme.onPrimary.withOpacity(0.005),
                ),
                borderRadius: BorderRadius.circular(LemonRadius.xSmall),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "0",
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                      // TODO:switch between no quantity and has quantity
                      // color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: Spacing.xSmall),
                  ThemeSvgIcon(
                    color: colorScheme.onSurfaceVariant,
                    builder: (filter) =>
                        Assets.icons.icArrowDown.svg(colorFilter: filter),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
