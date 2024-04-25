import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollboratorLikeItem extends StatelessWidget {
  const CollboratorLikeItem({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Avatar(),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kierra Donin',
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            ThemeSvgIcon(
                              color: colorScheme.onSecondary,
                              builder: (filter) => Assets.icons.icBriefcase.svg(
                                colorFilter: filter,
                              ),
                            ),
                            SizedBox(width: Spacing.superExtraSmall),
                            Text(
                              'Head Chef at Marriot',
                              style: Typo.medium.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icArrowRight.svg(
                        colorFilter: filter,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Spacing.superExtraSmall),
                const _InitialMessage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outline),
            borderRadius: BorderRadius.circular(42.w),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(42.w),
            child: CachedNetworkImage(
              imageUrl: "https://via.placeholder.com/60x60",
              width: 42.w,
              height: 42.w,
              errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(
                radius: BorderRadius.circular(42.w),
              ),
              placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(
                radius: BorderRadius.circular(42.w),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 3.w,
          child: Container(
            width: Sizing.xxSmall,
            height: Sizing.xxSmall,
            decoration: ShapeDecoration(
              color: LemonColor.malachiteGreen,
              shape: OvalBorder(
                side: BorderSide(
                  width: 3.w,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InitialMessage extends StatelessWidget {
  const _InitialMessage();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.xSmall,
        vertical: Spacing.extraSmall,
      ),
      decoration: ShapeDecoration(
        color: colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(LemonRadius.small),
            bottomLeft: Radius.circular(LemonRadius.small),
            bottomRight: Radius.circular(LemonRadius.small),
          ),
        ),
      ),
      child: Text(
        'Hey! We are build the worlds biggest automobile brand in the world! Would you like to join us? We have an amazing working environment that would suit your needs as well!',
        style: Typo.small.copyWith(
          color: colorScheme.onSecondary,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
