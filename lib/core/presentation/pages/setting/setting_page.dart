import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_profile_tile.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: LemonAppBar(
        title: t.setting.setting,
        leading: const LemonBackButton(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Spacing.superExtraSmall),
              const SettingProfileTile(),
              SizedBox(height: 24.h),
              SettingTileWidget(
                title: t.common.vault,
                subTitle: t.setting.vaultDesc,
                leading: ThemeSvgIcon(
                  color: colorScheme.onPrimary.withOpacity(0.54),
                  builder: (filter) {
                    return Assets.icons.icBank.svg(colorFilter: filter);
                  },
                ),
                featureAvailable: false,
                onTap: () {},
              ),
              SizedBox(height: Spacing.xSmall),
              SettingTileWidget(
                title: t.setting.notification,
                subTitle: t.setting.notificationDesc,
                leading: Assets.icons.icNotification.svg(),
                trailing: Assets.icons.icArrowBack.svg(
                  width: 18.w,
                  height: 18.w,
                ),
                onTap: () {},
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Spacing.xSmall,
                  horizontal: Spacing.superExtraSmall,
                ),
                child: Text(
                  t.setting.about,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SettingTileWidget(
                title: t.setting.policy,
                leading: Assets.icons.icPrivacy.svg(),
                trailing: Assets.icons.icExpand.svg(
                  width: 18.w,
                  height: 18.w,
                ),
                onTap: () => launchUrl(
                  Uri.parse('https://lemonade.social/privacy'),
                  mode: LaunchMode.inAppWebView,
                ),
              ),
              SizedBox(height: Spacing.xSmall),
              SettingTileWidget(
                title: t.setting.term,
                leading: Assets.icons.icTerm.svg(),
                trailing: Assets.icons.icExpand.svg(
                  width: 18.w,
                  height: 18.w,
                ),
                onTap: () => launchUrl(
                  Uri.parse('https://lemonade.social/terms'),
                  mode: LaunchMode.inAppWebView,
                ),
              ),
              SizedBox(height: Spacing.xSmall),
              SettingTileWidget(
                title: t.auth.logout,
                subTitle: t.setting.logoutDesc,
                leading: Assets.icons.icLogout.svg(),
                trailing: Assets.icons.icArrowBack.svg(
                  width: 18.w,
                  height: 18.w,
                ),
                onTap: () => context.read<AuthBloc>().add(
                      const AuthEvent.logout(),
                    ),
              ),
              SizedBox(height: Spacing.xSmall),
              SettingTileWidget(
                title: t.setting.deleteAccount,
                subTitle: t.setting.deleteAccountDesc,
                leading: ThemeSvgIcon(
                  color: LemonColor.deleteAccountRed,
                  builder: (filter) {
                    return Assets.icons.icDelete.svg(colorFilter: filter);
                  },
                ),
                titleColor: LemonColor.deleteAccountRed,
                trailing: Assets.icons.icArrowBack.svg(
                  width: 18.w,
                  height: 18.w,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
