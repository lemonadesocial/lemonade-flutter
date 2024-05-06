import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/social_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class _ItemData {
  final String socialFieldName;
  final String value;
  final String title;
  final ThemeSvgIcon themeSvgIcon;

  _ItemData({
    required this.title,
    required this.themeSvgIcon,
    required this.value,
    required this.socialFieldName,
  });
}

class CollaboratorDiscoverSocialGridSection extends StatelessWidget {
  final User? user;

  const CollaboratorDiscoverSocialGridSection({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final List<_ItemData> items = [
      if (user?.handleFarcaster?.isNotEmpty == true)
        _ItemData(
          socialFieldName: 'handleFarcaster',
          value: user?.handleFarcaster ?? '',
          title: t.profile.socials.farcaster,
          themeSvgIcon: ThemeSvgIcon(
            color: colorScheme.onPrimary,
            builder: (colorFilter) => Assets.icons.icFarcaster.svg(
              colorFilter: colorFilter,
              width: 18.w,
              height: 18.w,
            ),
          ),
        ),
      if (user?.handleTwitter?.isNotEmpty == true)
        _ItemData(
          socialFieldName: 'handleTwitter',
          value: user?.handleTwitter ?? '',
          title: t.profile.socials.twitter,
          themeSvgIcon: ThemeSvgIcon(
            color: colorScheme.onPrimary,
            builder: (colorFilter) => Assets.icons.icXLine.svg(
              colorFilter: colorFilter,
              width: 18.w,
              height: 18.w,
            ),
          ),
        ),
      // Add more items here as needed
    ];

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Spacing.extraSmall,
        mainAxisSpacing: Spacing.extraSmall,
        childAspectRatio: 3,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return InkWell(
            onTap: () {
              final socialUrl = SocialUtils.buildSocialLinkBySocialFieldName(
                socialFieldName: items[index].socialFieldName,
                socialUserName: items[index].value,
              );
              launchUrl(Uri.parse(socialUrl));
            },
            child: _Item(
              title: items[index].title,
              icon: items[index].themeSvgIcon,
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String title;
  final ThemeSvgIcon icon;

  const _Item({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Spacing.smMedium),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: LemonColor.white06,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.normal),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: Spacing.extraSmall),
          Expanded(
            child: SizedBox(
              child: Text(
                title,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: Spacing.extraSmall),
          ThemeSvgIcon(
            builder: (colorFilter) => Assets.icons.icExpand.svg(
              colorFilter: colorFilter,
              width: 18.w,
              height: 18.w,
            ),
          ),
        ],
      ),
    );
  }
}
