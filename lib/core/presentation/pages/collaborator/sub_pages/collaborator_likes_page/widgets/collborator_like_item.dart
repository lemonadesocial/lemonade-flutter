import 'package:app/core/domain/collaborator/entities/user_discovery_swipe/user_discovery_swipe.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollboratorLikeItem extends StatelessWidget {
  final UserDiscoverySwipe swipe;
  const CollboratorLikeItem({
    super.key,
    required this.swipe,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final companyName = swipe.otherExpanded?.companyName;
    final jobTitle = swipe.otherExpanded?.jobTitle;

    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: swipe.message?.isNotEmpty == true
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          _Avatar(imageUrl: swipe.otherExpanded?.imageAvatar ?? ''),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          swipe.otherExpanded?.name ?? '',
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (jobTitle?.isNotEmpty == true) ...[
                          SizedBox(height: 2.w),
                          Row(
                            children: [
                              ThemeSvgIcon(
                                color: colorScheme.onSecondary,
                                builder: (filter) =>
                                    Assets.icons.icBriefcase.svg(
                                  colorFilter: filter,
                                ),
                              ),
                              SizedBox(width: Spacing.superExtraSmall),
                              Text(
                                '$jobTitle ${companyName?.isNotEmpty == true ? 'at $companyName' : ''}',
                                style: Typo.medium.copyWith(
                                  color: colorScheme.onSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
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
                if (swipe.message?.isNotEmpty == true) ...[
                  SizedBox(height: Spacing.superExtraSmall),
                  _InitialMessage(
                    message: swipe.message ?? '',
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? imageUrl;
  const _Avatar({
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        LemonNetworkImage(
          border: Border.all(
            color: colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(42.w),
          imageUrl: imageUrl ?? '',
          width: 42.w,
          height: 42.w,
          placeholder: ImagePlaceholder.defaultPlaceholder(
            radius: BorderRadius.circular(42.w),
          ),
          fit: BoxFit.cover,
        ),
        // TODO: check online status using matrix
        // Positioned(
        //   bottom: 0,
        //   right: 3.w,
        //   child: Container(
        //     width: Sizing.xxSmall,
        //     height: Sizing.xxSmall,
        //     decoration: ShapeDecoration(
        //       color: LemonColor.malachiteGreen,
        //       shape: OvalBorder(
        //         side: BorderSide(
        //           width: 3.w,
        //           strokeAlign: BorderSide.strokeAlignOutside,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class _InitialMessage extends StatelessWidget {
  final String message;
  const _InitialMessage({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.xSmall,
        vertical: Spacing.extraSmall,
      ),
      decoration: ShapeDecoration(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(LemonRadius.small),
            bottomLeft: Radius.circular(LemonRadius.small),
            bottomRight: Radius.circular(LemonRadius.small),
          ),
        ),
      ),
      child: Text(
        message,
        style: Typo.small.copyWith(
          color: colorScheme.onSecondary,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
