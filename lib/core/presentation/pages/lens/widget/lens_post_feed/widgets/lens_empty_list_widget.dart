import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LensEmptyListWidget extends StatelessWidget {
  const LensEmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Spacing.s4, vertical: Spacing.s5),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 160.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LemonRadius.md),
                  color: appColors.cardBg,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      appColors.cardBg.withOpacity(1),
                      appColors.cardBg.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Spacing.s4),
              Container(
                height: 200.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LemonRadius.md),
                  color: appColors.cardBg,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      appColors.cardBg.withOpacity(0.4),
                      appColors.pageBg,
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ThemeSvgIcon(
                  color: appColors.textQuaternary,
                  builder: (filter) => Assets.icons.icDashboard2.svg(
                    colorFilter: filter,
                    width: Spacing.s24,
                    height: Spacing.s24,
                  ),
                ),
                SizedBox(height: Spacing.s4),
                Text(
                  t.lens.noPostsYet,
                  style: appText.lg,
                ),
                SizedBox(height: Spacing.s2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.s12),
                  child: Text(
                    t.lens.postsFromThisCommunityWillAppearHere,
                    style: appText.sm.copyWith(
                      color: appColors.textTertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
