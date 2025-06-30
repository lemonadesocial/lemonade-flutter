import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_lemonade_profile_builder/lens_lemonade_profile_builder.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/app_theme/app_theme.dart';

class SettingProfileTile extends StatelessWidget {
  const SettingProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final authSession = state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );

        if (authSession == null) {
          return const SizedBox.shrink();
        }

        return InkWell(
          onTap: () {
            AutoRouter.of(context).push(const EditProfileRoute());
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: Spacing.s2_5,
              horizontal: Spacing.s3,
            ),
            decoration: BoxDecoration(
              color: appColors.cardBg,
              borderRadius: BorderRadius.circular(LemonRadius.md),
              border: Border.all(color: appColors.cardBorder),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LensLemonadeProfileBuilder(
                  builder: (lensLemonadeProfile) {
                    return LemonNetworkImage(
                      imageUrl: lensLemonadeProfile.imageAvatar ?? '',
                      width: Sizing.s10,
                      height: Sizing.s10,
                      borderRadius: BorderRadius.circular(LemonRadius.full),
                      border: Border.all(color: appColors.cardBorder),
                    );
                  },
                ),
                SizedBox(width: Spacing.small),
                Expanded(
                  child: LensLemonadeProfileBuilder(
                    builder: (lensLemonadeProfile) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lensLemonadeProfile.name ?? 'Anonymous',
                            style: appText.md,
                          ),
                          Text(
                            t.common.actions.editProfile,
                            style: appText.sm.copyWith(
                              color: appColors.textTertiary,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                ThemeSvgIcon(
                  color: appColors.textTertiary,
                  builder: (filter) => Assets.icons.icArrowRight.svg(
                    colorFilter: filter,
                    width: Sizing.s5,
                    height: Sizing.s5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
