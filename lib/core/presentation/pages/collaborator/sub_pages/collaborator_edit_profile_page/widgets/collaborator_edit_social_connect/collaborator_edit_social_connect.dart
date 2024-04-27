import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorEditSocialConnect extends StatelessWidget {
  const CollaboratorEditSocialConnect({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _SocialItem(
            socialTitle: t.profile.socials.farcaster,
            socialIcon: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icFarcaster.svg(
                colorFilter: filter,
              ),
            ),
          ),
          SizedBox(height: Spacing.superExtraSmall),
          _SocialItem(
            socialTitle: t.profile.socials.twitter,
            socialIcon: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icXLine.svg(
                colorFilter: filter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialItem extends StatelessWidget {
  final String socialTitle;
  final Widget socialIcon;
  const _SocialItem({
    required this.socialTitle,
    required this.socialIcon,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        color: LemonColor.atomicBlack,
      ),
      child: Row(
        children: [
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.secondaryContainer,
            ),
            child: Center(
              child: socialIcon,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  socialTitle,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 2.w,
                      height: 9.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.w),
                        color: LemonColor.coralReef,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      t.common.status.notConnected,
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          LinearGradientButton.secondaryButton(
            height: Sizing.medium,
            label: t.common.actions.connect,
            textStyle: Typo.small.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
