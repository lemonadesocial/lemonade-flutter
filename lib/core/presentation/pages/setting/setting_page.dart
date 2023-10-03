import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_delete_account_dialog.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_profile_tile.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    EasyLoading.show();
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          processing: EasyLoading.show,
          unauthenticated: (_) {
            EasyLoading.dismiss();
            context.router.popUntilRoot();
          },
          orElse: EasyLoading.dismiss,
        );
      },
      child: Scaffold(
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
                  onTap: () => showComingSoonDialog(context),
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
                  onTap: () =>
                      context.router.push(const NotificationSettingRoute()),
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
                  onTap: () => ChromeSafariBrowser().open(
                    url: Uri.parse('https://lemonade.social/privacy'),
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
                  onTap: () => ChromeSafariBrowser().open(
                    url: Uri.parse('https://lemonade.social/terms'),
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
                  onTap: () async {
                    final deleteAccount = await showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return const SettingDeleteAccountDialog();
                      },
                    ) as bool;
                    if (deleteAccount) {
                      context
                          .read<AuthBloc>()
                          .add(const AuthEvent.deleteAccount());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
