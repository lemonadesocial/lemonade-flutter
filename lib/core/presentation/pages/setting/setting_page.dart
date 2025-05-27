import 'dart:io';

import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/delete_user_bloc/delete_user_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_profile_tile.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteUserBloc(),
      child: const SettingPageView(),
    );
  }
}

class SettingPageView extends StatelessWidget {
  const SettingPageView({super.key});

  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}-${packageInfo.buildNumber}';
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    final backIcon = ThemeSvgIcon(
      color: appColors.textTertiary,
      builder: (filter) => Assets.icons.icArrowRight.svg(
        colorFilter: filter,
        width: Sizing.s5,
        height: Sizing.s5,
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.maybeWhen(
              processing: EasyLoading.show,
              unauthenticated: (_) async {
                await EasyLoading.dismiss();
                context.router.root.popUntilRoot();
              },
              orElse: EasyLoading.dismiss,
            );
          },
        ),
        BlocListener<DeleteUserBloc, DeleteUserState>(
          listener: (context, state) {
            state.maybeWhen(
              loading: EasyLoading.show,
              success: () async {
                await EasyLoading.dismiss();
                context.router.root.popUntilRoot();
                context.read<AuthBloc>().add(const AuthEvent.forceLogout());
              },
              orElse: EasyLoading.dismiss,
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: colorScheme.primary,
        appBar: LemonAppBar(
          title: t.setting.setting,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.s4,
          ),
          child: ListView(
            children: [
              const SettingProfileTile(),
              CupertinoListSection.insetGrouped(
                backgroundColor: appColors.pageBg,
                separatorColor: appColors.pageDivider,
                dividerMargin: 0,
                additionalDividerMargin: 0,
                margin: EdgeInsets.zero,
                hasLeading: false,
                header: Text(
                  t.setting.account,
                  style: appText.sm.copyWith(
                    color: appColors.textTertiary,
                  ),
                ),
                topMargin: 0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LemonRadius.md),
                  color: appColors.cardBg,
                  border: Border.all(color: appColors.cardBorder),
                ),
                children: [
                  CupertinoListTile(
                    title: Text(
                      t.setting.accountSettings,
                      style: appText.md,
                    ),
                    leading: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icPersonOutline.svg(
                        colorFilter: filter,
                        width: Sizing.s5,
                        height: Sizing.s5,
                      ),
                    ),
                    trailing: backIcon,
                    onTap: () {},
                  ),
                  CupertinoListTile(
                    title: Text(t.setting.blockAccount, style: appText.md),
                    leading: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icBlock.svg(
                        colorFilter: filter,
                        width: Sizing.s5,
                        height: Sizing.s5,
                      ),
                    ),
                    trailing: backIcon,
                    onTap: () {
                      context.router.push(const SettingBlockRoute());
                    },
                  ),
                ],
              ),
              CupertinoListSection.insetGrouped(
                backgroundColor: appColors.pageBg,
                separatorColor: appColors.pageDivider,
                dividerMargin: 0,
                additionalDividerMargin: 0,
                margin: EdgeInsets.zero,
                hasLeading: false,
                header: Text(
                  t.setting.preferences,
                  style: appText.sm.copyWith(
                    color: appColors.textTertiary,
                  ),
                ),
                topMargin: 0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LemonRadius.md),
                  color: appColors.cardBg,
                  border: Border.all(color: appColors.cardBorder),
                ),
                children: [
                  CupertinoListTile(
                    title: Text(t.setting.notification, style: appText.md),
                    leading: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icNotification.svg(
                        colorFilter: filter,
                        width: Sizing.s5,
                        height: Sizing.s5,
                      ),
                    ),
                    trailing: backIcon,
                    onTap: () {
                      Vibrate.feedback(FeedbackType.light);
                      context.router.push(const NotificationSettingRoute());
                    },
                  ),
                  CupertinoListTile(
                    title: Text(t.setting.appearance, style: appText.md),
                    leading: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icPallete.svg(
                        colorFilter: filter,
                        width: Sizing.s5,
                        height: Sizing.s5,
                      ),
                    ),
                    trailing: backIcon,
                    onTap: () {
                      SnackBarUtils.showComingSoon();
                      // if (context.read<AppTheme>().themeMode == ThemeMode.light) {
                      //   context.read<AppTheme>().themeMode = ThemeMode.dark;
                      // } else {
                      //   context.read<AppTheme>().themeMode = ThemeMode.light;
                      // }
                    },
                  ),
                ],
              ),
              CupertinoListSection.insetGrouped(
                backgroundColor: appColors.pageBg,
                separatorColor: appColors.pageDivider,
                dividerMargin: 0,
                additionalDividerMargin: 0,
                margin: EdgeInsets.zero,
                hasLeading: false,
                header: Text(
                  t.setting.resources,
                  style: appText.sm.copyWith(
                    color: appColors.textTertiary,
                  ),
                ),
                topMargin: 0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LemonRadius.md),
                  color: appColors.cardBg,
                  border: Border.all(color: appColors.cardBorder),
                ),
                children: [
                  CupertinoListTile(
                    title: Text(t.setting.policy, style: appText.md),
                    leading: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icShieldLockOutline.svg(
                        colorFilter: filter,
                        width: Sizing.s5,
                        height: Sizing.s5,
                      ),
                    ),
                    trailing: backIcon,
                    onTap: () {
                      ChromeSafariBrowser().open(
                        url: WebUri('https://lemonade.social/privacy'),
                      );
                    },
                  ),
                  CupertinoListTile(
                    title: Text(t.setting.term, style: appText.md),
                    leading: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icContractOutline.svg(
                        colorFilter: filter,
                        width: Sizing.s5,
                        height: Sizing.s5,
                      ),
                    ),
                    trailing: backIcon,
                    onTap: () {
                      ChromeSafariBrowser().open(
                        url: WebUri('https://lemonade.social/terms'),
                      );
                    },
                  ),
                  CupertinoListTile(
                    title: Text(t.setting.contactUs, style: appText.md),
                    leading: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icMailOutline.svg(
                        colorFilter: filter,
                        width: Sizing.s5,
                        height: Sizing.s5,
                      ),
                    ),
                    trailing: backIcon,
                    onTap: () async {
                      await launchUrl(
                        Uri.parse('mailto:suppor@lemonade.social'),
                      );
                    },
                  ),
                  CupertinoListTile(
                    title: Text(
                      Platform.isAndroid
                          ? t.setting.rateInPlayStore
                          : t.setting.rateInAppStore,
                      style: appText.md,
                    ),
                    leading: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icStar.svg(
                        colorFilter: filter,
                        width: Sizing.s5,
                        height: Sizing.s5,
                      ),
                    ),
                    trailing: backIcon,
                    onTap: () {
                      launchUrl(
                        Uri.parse(
                          Platform.isIOS
                              ? AppConfig.lemonadeIosDownloadUrl
                              : AppConfig.lemonadeAndroidDownloadUrl,
                        ),
                      );
                    },
                  ),
                  CupertinoListTile(
                    title: Text(t.setting.followLemonade, style: appText.md),
                    leading: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icXLine.svg(
                        colorFilter: filter,
                        width: Sizing.s5,
                        height: Sizing.s5,
                      ),
                    ),
                    trailing: backIcon,
                    onTap: () {
                      launchUrl(
                        Uri.parse(AppConfig.lemonadeTwitterUrl),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: Spacing.s5),
              CupertinoListSection.insetGrouped(
                backgroundColor: appColors.pageBg,
                separatorColor: appColors.pageDivider,
                dividerMargin: 0,
                additionalDividerMargin: 0,
                margin: EdgeInsets.zero,
                hasLeading: false,
                topMargin: 0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LemonRadius.md),
                  color: appColors.cardBg,
                  border: Border.all(color: appColors.cardBorder),
                ),
                children: [
                  CupertinoListTile(
                    title: Text(t.setting.signOut, style: appText.md),
                    leading: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icLogout.svg(
                        colorFilter: filter,
                        width: Sizing.s5,
                        height: Sizing.s5,
                      ),
                    ),
                    trailing: backIcon,
                    onTap: () {
                      context.read<AuthBloc>().add(
                            const AuthEvent.logout(),
                          );
                    },
                  ),
                ],
              ),
              SizedBox(height: Spacing.s10),
              // SettingTileWidget(
              //   title: t.setting.deleteAccount,
              //   subTitle: t.setting.deleteAccountDesc,
              //   leading: ThemeSvgIcon(
              //     color: LemonColor.deleteAccountRed,
              //     builder: (filter) {
              //       return Assets.icons.icDelete.svg(colorFilter: filter);
              //     },
              //   ),
              //   titleStyle: Typo.medium.copyWith(
              //     color: LemonColor.deleteAccountRed,
              //     fontWeight: FontWeight.w600,
              //   ),
              //   trailing: Assets.icons.icArrowBack.svg(
              //     width: 18.w,
              //     height: 18.w,
              //   ),
              //   onTap: () async {
              //     Vibrate.feedback(FeedbackType.light);
              //     final confirmDeleteAccount = await showDialog<bool>(
              //       context: context,
              //       barrierDismissible: true,
              //       builder: (BuildContext context) {
              //         return const SettingDeleteAccountDialog();
              //       },
              //     );
              //     if (confirmDeleteAccount == true) {
              //       context.read<DeleteUserBloc>().add(DeleteUserEvent.delete());
              //     }
              //   },
              // ),
              // Display version information
              FutureBuilder<String>(
                future: getVersion(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<String> snapshot,
                ) {
                  if (snapshot.hasData) {
                    return Center(
                      child: Text(
                        t.common.appVersion(
                          appVersion: snapshot.data as String,
                        ),
                        style: appText.xs.copyWith(
                          color: appColors.textTertiary,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
