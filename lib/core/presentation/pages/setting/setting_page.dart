import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/delete_user_bloc/delete_user_bloc.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_delete_account_dialog.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_profile_tile.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
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
import 'package:package_info_plus/package_info_plus.dart';

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
          leading: const LemonBackButton(),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) => state.maybeWhen(
                orElse: () => Center(
                  child: EmptyList(
                    emptyText: t.common.somethingWrong,
                  ),
                ),
                authenticated: (_) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Spacing.superExtraSmall),
                    const SettingProfileTile(),
                    SizedBox(height: 24.h),
                    SettingTileWidget(
                      title: t.common.vaults,
                      subTitle: t.setting.vaultDesc,
                      leading: ThemeSvgIcon(
                        color: colorScheme.onPrimary.withOpacity(0.54),
                        builder: (filter) {
                          return Assets.icons.icBank.svg(colorFilter: filter);
                        },
                      ),
                      featureAvailable: true,
                      onTap: () =>
                          AutoRouter.of(context).push(const VaultRootRoute()),
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
                    SizedBox(height: Spacing.xSmall),
                    SettingTileWidget(
                      title: t.setting.blockAccount,
                      subTitle: t.setting.blockAccountDesc,
                      leading: Assets.icons.icBlock.svg(),
                      trailing: Assets.icons.icArrowBack.svg(
                        width: 18.w,
                        height: 18.w,
                      ),
                      onTap: () =>
                          context.router.push(const SettingBlockRoute()),
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
                      titleStyle: Typo.medium.copyWith(
                        color: LemonColor.deleteAccountRed,
                        fontWeight: FontWeight.w600,
                      ),
                      trailing: Assets.icons.icArrowBack.svg(
                        width: 18.w,
                        height: 18.w,
                      ),
                      onTap: () async {
                        final confirmDeleteAccount = await showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return const SettingDeleteAccountDialog();
                          },
                        ) as bool;
                        if (confirmDeleteAccount) {
                          context
                              .read<DeleteUserBloc>()
                              .add(DeleteUserEvent.delete());
                        }
                      },
                    ),
                    // Display version information
                    FutureBuilder<String>(
                      future: getVersion(),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<String> snapshot,
                      ) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: Spacing.large,
                              bottom: Spacing.xLarge,
                            ),
                            child: Center(
                              child: Text(
                                t.common.appVersion(
                                  appVersion: snapshot.data as String,
                                ),
                                style: Typo.medium.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w400,
                                ),
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
          ),
        ),
      ),
    );
  }
}
