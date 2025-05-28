import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/social_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/app_theme/app_theme.dart';

class SpaceInfo extends StatelessWidget {
  final Space space;

  const SpaceInfo({
    super.key,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    final spaceAddressTitle = space.address?.title;
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: Spacing.small),
          // Space name
          Text(
            space.title ?? '',
            style: appText.xxl,
          ),
          if (spaceAddressTitle != null) ...[
            SizedBox(height: Spacing.s2),
            Row(
              children: [
                ThemeSvgIcon(
                  color: appColors.textTertiary,
                  builder: (filter) => Assets.icons.icLocationPinOutline.svg(
                    colorFilter: filter,
                  ),
                ),
                SizedBox(width: Spacing.superExtraSmall),
                Text(
                  spaceAddressTitle,
                  style: appText.sm.copyWith(
                    color: appColors.textTertiary,
                  ),
                ),
              ],
            ),
          ],
          if (space.description?.isNotEmpty == true) ...[
            SizedBox(height: Spacing.s2),
            // Description
            Linkify(
              text: space.description ?? '',
              style: appText.sm.copyWith(
                color: appColors.textSecondary,
              ),
              options: const LinkifyOptions(humanize: true),
              linkStyle: TextStyle(
                color: appColors.textAccent,
                decoration: TextDecoration.underline,
                decorationColor: appColors.textAccent,
              ),
            ),
          ],
          if (space.handleTwitter != null ||
              space.handleInstagram != null ||
              space.handleLinkedin != null ||
              space.handleTiktok != null ||
              space.handleYoutube != null ||
              space.website != null) ...[
            SizedBox(height: Spacing.s3),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
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
                    margin: EdgeInsets.only(right: Spacing.s3),
                    child: Center(
                      child: ThemeSvgIcon(
                        color: appColors.textTertiary,
                        builder: (filter) => item.$3.svg(
                          colorFilter: filter,
                          width: Sizing.s5,
                          height: Sizing.s5,
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
