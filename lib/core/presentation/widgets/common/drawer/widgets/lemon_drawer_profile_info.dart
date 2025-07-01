import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_account_lemonade_username/lens_account_lemaonde_username.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_lemonade_profile_builder/lens_lemonade_profile_builder.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/service/wallet/wallet_session_address_extension.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/lens/account/mutation/lens_account_stats.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:share_plus/share_plus.dart';

class LemonDrawerProfileInfo extends StatelessWidget {
  const LemonDrawerProfileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authSession = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final followersCount = authSession?.followers ?? 0;
    final followingCount = authSession?.following ?? 0;
    final selectedLensAccount =
        context.watch<LensAuthBloc>().state.selectedAccount;

    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LensLemonadeProfileBuilder(
              builder: (lensLemonadeProfile) {
                return LemonNetworkImage(
                  imageUrl: lensLemonadeProfile.imageAvatar ?? '',
                  width: Sizing.s20,
                  height: Sizing.s20,
                  borderRadius: BorderRadius.circular(LemonRadius.full),
                );
              },
            ),
            SizedBox(height: Spacing.s5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                LensLemonadeProfileBuilder(
                  builder: (lensLemonadeProfile) {
                    return Text(
                      lensLemonadeProfile.name ?? 'Anonymous',
                      style: appText.lg,
                    );
                  },
                ),
                SizedBox(
                  height: Spacing.s0_5,
                ),
                const LensAccountLemonadeUsername(),
              ],
            ),
          ],
        ),
        SizedBox(
          height: Spacing.s3,
        ),
        if (selectedLensAccount != null)
          GraphQLProvider(
            client: ValueNotifier(getIt<LensGQL>().client),
            child: Query$LensAccountStats$Widget(
              options: Options$Query$LensAccountStats(
                variables: Variables$Query$LensAccountStats(
                  request: Input$AccountStatsRequest(
                    account: selectedLensAccount.address,
                  ),
                ),
              ),
              builder: (
                result, {
                refetch,
                fetchMore,
              }) {
                return _FollowersCount(
                  followersCount: result.parsedData?.accountStats
                          .graphFollowStats.followers ??
                      0,
                  followingCount: result.parsedData?.accountStats
                          .graphFollowStats.following ??
                      0,
                );
              },
            ),
          )
        else
          _FollowersCount(
            followersCount: followersCount,
            followingCount: followingCount,
          ),
        SizedBox(
          height: Spacing.s5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _DrawerConnectWalletButton(),
            SizedBox(
              width: Spacing.s2,
            ),
            InkWell(
              onTap: () => _onPressQRCode(context),
              child: Container(
                padding: EdgeInsets.all(Spacing.s2),
                decoration: ShapeDecoration(
                  // color: Colors.red,
                  shape: CircleBorder(
                    side: BorderSide(
                      color: appColors.pageDivider,
                    ),
                  ),
                ),
                child: ThemeSvgIcon(
                  color: appColors.textTertiary,
                  builder: (filter) => Assets.icons.icQr.svg(
                    colorFilter: filter,
                    width: Sizing.s5,
                    height: Sizing.s5,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Spacing.s2,
            ),
            InkWell(
              onTap: () {
                if (authSession != null) {
                  _onPressShare(context, authSession);
                }
              },
              child: Container(
                padding: EdgeInsets.all(Spacing.s2),
                decoration: ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(
                      color: appColors.pageDivider,
                    ),
                  ),
                ),
                child: ThemeSvgIcon(
                  color: appColors.textTertiary,
                  builder: (filter) => Assets.icons.icShare.svg(
                    colorFilter: filter,
                    width: Sizing.s5,
                    height: Sizing.s5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _onPressShare(BuildContext context, User user) {
    final url = '${AppConfig.webUrl}/u/${user.username ?? user.userId}';
    Share.share(url);
  }

  _onPressQRCode(BuildContext context) {
    AutoRouter.of(context).navigate(const QrCodeRoute());
  }
}

class _DrawerConnectWalletButton extends StatelessWidget {
  const _DrawerConnectWalletButton();

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    return ConnectWalletButton(
      builder: (onTapConnect, connectState) {
        if (connectState == ConnectButtonState.connected) {
          return BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              return LemonOutlineButton(
                radius: BorderRadius.circular(LemonRadius.full),
                height: Sizing.s9,
                label: Web3Utils.formatIdentifier(
                  state.activeSession?.address ?? '',
                ),
                onTap: () => onTapConnect(context),
                leading: ThemeSvgIcon(
                  color: appColors.textTertiary,
                  builder: (filter) => Assets.icons.icWallet.svg(
                    colorFilter: filter,
                    width: Sizing.s5,
                    height: Sizing.s5,
                  ),
                ),
              );
            },
          );
        }
        return LinearGradientButton.secondaryButton(
          onTap: () => onTapConnect(context),
          radius: BorderRadius.circular(LemonRadius.full),
          height: Sizing.s9,
          label: t.common.actions.connect,
          leading: ThemeSvgIcon(
            color: appColors.buttonSecondary,
            builder: (filter) =>
                Assets.icons.icAccountBalanceWalletOutlineSharp.svg(
              colorFilter: filter,
              width: Sizing.s5,
              height: Sizing.s5,
            ),
          ),
        );
      },
    );
  }
}

class _FollowersCount extends StatelessWidget {
  const _FollowersCount({
    required this.followersCount,
    required this.followingCount,
  });
  final int followersCount;
  final int followingCount;

  @override
  Widget build(BuildContext context) {
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            text: NumberUtils.formatCompact(amount: followersCount),
            style: appText.md,
            children: [
              TextSpan(
                text:
                    ' ${StringUtils.capitalize(t.common.follower(n: followersCount))}',
                style: appText.md.copyWith(
                  color: appColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: Spacing.s3,
        ),
        Text.rich(
          TextSpan(
            text: NumberUtils.formatCompact(amount: followingCount),
            style: appText.md,
            children: [
              TextSpan(
                text: ' ${StringUtils.capitalize(t.common.following)}',
                style: appText.md.copyWith(
                  color: appColors.textSecondary,
                ),
              ),
            ],
          ),
          style: appText.md.copyWith(
            color: appColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
