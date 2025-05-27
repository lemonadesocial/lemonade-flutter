import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/delete_user_bloc/delete_user_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_delete_account_dialog.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class AccountSettingPage extends StatelessWidget {
  const AccountSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteUserBloc(),
      child: const AccountSettingPageView(),
    );
  }
}

class AccountSettingPageView extends StatelessWidget {
  const AccountSettingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final user = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (user) => user,
          orElse: () => null,
        );
    final t = Translations.of(context);

    return Scaffold(
      appBar: LemonAppBar(
        title: t.setting.accountSetting,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
        child: ListView(
          children: [
            CupertinoListSection.insetGrouped(
              backgroundColor: appColors.pageBg,
              separatorColor: appColors.pageDivider,
              dividerMargin: 0,
              additionalDividerMargin: 0,
              margin: EdgeInsets.zero,
              hasLeading: false,
              header: Text(
                t.setting.basicInfo,
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
                    t.setting.firstName,
                    style: appText.md,
                  ),
                  trailing: Text(
                    user?.firstName ?? "--",
                    style: appText.md.copyWith(
                      color: appColors.textTertiary,
                    ),
                  ),
                  onTap: () {},
                ),
                CupertinoListTile(
                  title: Text(
                    t.setting.lastName,
                    style: appText.md,
                  ),
                  trailing: Text(
                    user?.lastName ?? "--",
                    style: appText.md.copyWith(
                      color: appColors.textTertiary,
                    ),
                  ),
                  onTap: () {},
                ),
                CupertinoListTile(
                  title: Text(
                    t.setting.email,
                    style: appText.md,
                  ),
                  trailing: Text(
                    user?.email ?? "",
                    style: appText.md.copyWith(
                      color: appColors.textTertiary,
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: Spacing.s1_5),
            Text.rich(
              TextSpan(
                text: t.setting.needToMakeChanges,
                style: appText.sm.copyWith(
                  color: appColors.textTertiary,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(
                          Uri.parse(
                            AppConfig.identityUrl,
                          ),
                        );
                      },
                    text: ' ${t.setting.editAccountDetails}',
                    style: appText.sm.copyWith(
                      color: appColors.textAccent,
                    ),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: t.setting.securedBy,
                style: appText.sm.copyWith(
                  color: appColors.textTertiary,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(
                          Uri.parse(
                            "https://ory.sh",
                          ),
                        );
                      },
                    text: ' ory.sh',
                    style: appText.md.copyWith(
                      color: appColors.textAccent,
                    ),
                  ),
                  TextSpan(
                    text: ' ${t.setting.openSourceIdentitySolutions}',
                  ),
                ],
              ),
            ),
            CupertinoListSection.insetGrouped(
              backgroundColor: appColors.pageBg,
              separatorColor: appColors.pageDivider,
              dividerMargin: 0,
              additionalDividerMargin: 0,
              margin: EdgeInsets.zero,
              hasLeading: false,
              header: Text(
                t.setting.cryptoIdentities,
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
                    t.setting.ethereumAddress,
                    style: appText.md,
                  ),
                  trailing: Text(
                    Web3Utils.formatIdentifier(
                      user?.walletsNew?['ethereum']?.firstOrNull ?? '--',
                    ),
                    style: appText.md.copyWith(
                      color: appColors.textTertiary,
                    ),
                  ),
                  onTap: () {},
                ),
                CupertinoListTile(
                  title: Text(
                    t.setting.solanaAddress,
                    style: appText.md,
                  ),
                  trailing: Text(
                    Web3Utils.formatIdentifier(
                      user?.walletsNew?['solana']?.firstOrNull ?? '--',
                    ),
                    style: appText.md.copyWith(
                      color: appColors.textTertiary,
                    ),
                  ),
                  onTap: () {},
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
              topMargin: 0,
              header: const SizedBox.shrink(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LemonRadius.md),
                color: appColors.cardBg,
                border: Border.all(color: appColors.cardBorder),
              ),
              children: [
                CupertinoListTile(
                  title: Text(
                    t.setting.deleteAccount,
                    style: appText.md.copyWith(
                      color: appColors.textError,
                    ),
                  ),
                  onTap: () async {
                    final confirmDeleteAccount = await showDialog<bool>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return const SettingDeleteAccountDialog();
                      },
                    );
                    if (confirmDeleteAccount == true) {
                      context
                          .read<DeleteUserBloc>()
                          .add(DeleteUserEvent.delete());
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
