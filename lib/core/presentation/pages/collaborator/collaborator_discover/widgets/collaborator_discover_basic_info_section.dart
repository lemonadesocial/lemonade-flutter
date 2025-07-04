import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class CollaboratorDiscoverBasicInfoSection extends StatelessWidget {
  final User? user;
  const CollaboratorDiscoverBasicInfoSection({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                user?.name ?? '',
                style: appText.xl,
              ),
              SizedBox(width: Spacing.smMedium / 2),
              if (user?.username != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.superExtraSmall,
                    vertical: Spacing.extraSmall / 2,
                  ),
                  decoration: ShapeDecoration(
                    color: LemonColor.acidGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(LemonRadius.extraSmall),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '@${user?.username ?? ''}',
                        style: Typo.small.copyWith(
                          color: LemonColor.paleViolet,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (user?.jobTitle?.isNotEmpty == true) ...[
            SizedBox(height: Spacing.extraSmall),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: Sizing.medium / 2,
                  height: Sizing.medium / 2,
                  child: ThemeSvgIcon(
                    color: appColors.textTertiary,
                    builder: (colorFilter) => Assets.icons.icBriefcase.svg(
                      colorFilter: colorFilter,
                    ),
                  ),
                ),
                SizedBox(width: Spacing.superExtraSmall),
                Expanded(
                  child: Text(
                    '${user?.jobTitle} ${user?.companyName?.isNotEmpty == true ? 'at ${user?.companyName}' : ''}',
                    style: appText.md.copyWith(
                      color: appColors.textTertiary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
