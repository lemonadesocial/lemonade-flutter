import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/edit_profile/sub_pages/edit_profile_social_page.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CollaboratorEditSocialConnect extends StatelessWidget {
  const CollaboratorEditSocialConnect({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );
    final isConnectedFarCaster = user?.handleFarcaster?.isNotEmpty == true;
    final isConnectedTwitter = user?.handleTwitter?.isNotEmpty == true;
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _SocialItem(
            socialTitle: t.profile.socials.farcaster,
            socialValue: user?.handleFarcaster ?? '',
            socialIcon: ThemeSvgIcon(
              color: appColors.textTertiary,
              builder: (filter) => Assets.icons.icFarcaster.svg(
                colorFilter: filter,
              ),
            ),
            isConnected: isConnectedFarCaster,
            isSpecialRadiusTop: true,
            isSpecialRadiusBottom: false,
            user: user,
          ),
          SizedBox(height: Spacing.superExtraSmall),
          _SocialItem(
            socialTitle: t.profile.socials.twitter,
            socialValue: user?.handleTwitter ?? '',
            socialIcon: ThemeSvgIcon(
              color: appColors.textTertiary,
              builder: (filter) => Assets.icons.icXLine.svg(
                colorFilter: filter,
              ),
            ),
            isConnected: isConnectedTwitter,
            isSpecialRadiusTop: false,
            isSpecialRadiusBottom: true,
            user: user,
          ),
        ],
      ),
    );
  }
}

class _SocialItem extends StatelessWidget {
  final String socialTitle;
  final String socialValue;
  final Widget socialIcon;
  final bool isConnected;
  final bool? isSpecialRadiusTop;
  final bool? isSpecialRadiusBottom;
  final User? user;
  const _SocialItem({
    required this.socialTitle,
    required this.socialValue,
    required this.socialIcon,
    required this.isConnected,
    this.isSpecialRadiusBottom,
    this.isSpecialRadiusTop,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;
    final lineColor =
        isConnected == true ? appColors.textSuccess : appColors.textError;
    final connectInfo = isConnected == true
        ? '${t.common.status.connected} : $socialValue'
        : t.common.status.notConnected;

    final double topRadius = isSpecialRadiusTop == true
        ? LemonRadius.medium
        : LemonRadius.extraSmall;
    final double bottomRadius = isSpecialRadiusBottom == true
        ? LemonRadius.medium
        : LemonRadius.extraSmall;

    final editProfileBloc = context.watch<EditProfileBloc>();
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topRadius),
          topRight: Radius.circular(topRadius),
          bottomLeft: Radius.circular(bottomRadius),
          bottomRight: Radius.circular(bottomRadius),
        ),
        color: appColors.cardBg,
      ),
      child: Row(
        children: [
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appColors.cardBg,
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
                  style: appText.md,
                ),
                SizedBox(height: 2.w),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 2.w,
                      height: 9.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.w),
                        color: lineColor,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      connectInfo,
                      style: appText.sm.copyWith(
                        color: appColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          isConnected == false
              ? LinearGradientButton.secondaryButton(
                  height: Sizing.medium,
                  label: t.common.actions.connect.capitalize(),
                  onTap: () {
                    if (user == null) {
                      return;
                    }
                    showCupertinoModalBottomSheet(
                      backgroundColor: appColors.pageBg,
                      context: context,
                      builder: (innerContext) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: editProfileBloc,
                          ),
                        ],
                        child: EditProfileSocialDialog(
                          userProfile: user!,
                        ),
                      ),
                    );
                  },
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
