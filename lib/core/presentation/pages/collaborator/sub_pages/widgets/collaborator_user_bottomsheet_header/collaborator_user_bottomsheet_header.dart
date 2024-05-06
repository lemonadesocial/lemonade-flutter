import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorUserBottomsheetHeader extends StatelessWidget {
  final User? user;
  final Widget? icon;
  const CollaboratorUserBottomsheetHeader({
    super.key,
    this.icon,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final companyName = user?.companyName;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(60.r),
      ),
      child: Row(
        children: [
          LemonNetworkImage(
            width: Sizing.medium,
            height: Sizing.medium,
            imageUrl: ImageUtils.generateUrl(
              file: user?.newPhotosExpanded?.firstOrNull,
            ),
            borderRadius: BorderRadius.circular(Sizing.medium),
            placeholder: ImagePlaceholder.defaultPlaceholder(
              radius: BorderRadius.circular(Sizing.medium),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  user?.name ?? '',
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.w),
                if (user?.jobTitle?.isNotEmpty == true)
                  Row(
                    children: [
                      ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => Assets.icons.icBriefcase.svg(
                          colorFilter: filter,
                        ),
                      ),
                      SizedBox(width: Spacing.superExtraSmall),
                      Expanded(
                        child: Text(
                          '${user?.jobTitle} ${companyName?.isNotEmpty == true ? 'at $companyName' : ''}',
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(width: Spacing.xSmall),
                    ],
                  ),
              ],
            ),
          ),
          if (icon != null) icon!,
        ],
      ),
    );
  }
}
