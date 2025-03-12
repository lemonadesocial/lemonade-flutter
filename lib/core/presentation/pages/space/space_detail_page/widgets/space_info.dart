import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/social_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_button_by_role.dart';

class SpaceInfo extends StatelessWidget {
  final Space space;

  const SpaceInfo({
    super.key,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(),
              SpaceButtonByRole(space: space),
            ],
          ),
          SizedBox(height: Spacing.small),
          // Space name
          Text(
            space.title ?? '',
            style: Typo.extraLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary,
            ),
          ),
          if (space.description?.isNotEmpty == true) ...[
            SizedBox(height: Spacing.superExtraSmall),
            // Description
            Text(
              space.description ?? '',
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ],
          if (space.address != null) ...[
            SizedBox(height: Spacing.superExtraSmall),
            Row(
              children: [
                ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icLocationPin.svg(
                    colorFilter: filter,
                  ),
                ),
                SizedBox(width: Spacing.superExtraSmall),
                Text(
                  space.address?.title ?? '',
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ],
          if (space.handleTwitter != null ||
              space.handleInstagram != null ||
              space.handleLinkedin != null) ...[
            SizedBox(height: Spacing.small),
            Row(
              children: <(String?, String, SvgGenImage)>[
                (space.handleInstagram, 'instagram', Assets.icons.icInstagram),
                (space.handleTwitter, 'twitter', Assets.icons.icXLine),
                (space.handleYoutube, 'youtube', Assets.icons.icYoutube),
                (space.handleLinkedin, 'linkedin', Assets.icons.icLinkedin),
                (space.handleTiktok, 'tiktok', Assets.icons.icTiktok),
                (space.website, 'website', Assets.icons.icGlobe),
              ].where((item) => item.$1 != null).map((item) {
                return InkWell(
                  onTap: () {
                    if (item.$1 != null) {
                      String url = '';
                      if (item.$2 == 'website') {
                        url = item.$1!;
                      } else {
                        url = SocialUtils.buildSocialLinkBySocialFieldName(
                          socialFieldName: item.$2,
                          socialUserName: item.$1!,
                        );
                      }
                      launchUrl(Uri.parse(url));
                    }
                  },
                  child: Container(
                    width: Sizing.medium,
                    height: Sizing.medium,
                    margin: EdgeInsets.only(right: Spacing.superExtraSmall),
                    decoration: ShapeDecoration(
                      color: LemonColor.chineseBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(LemonRadius.button),
                      ),
                    ),
                    child: Center(
                      child: ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => item.$3.svg(
                          colorFilter: filter,
                          width: 16.w,
                          height: 16.w,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
