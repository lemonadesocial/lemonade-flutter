import 'package:app/core/application/lens/enums.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_onboarding_bottom_sheet.dart';
import 'package:app/core/service/wallet/wallet_session_address_extension.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/lens/namespace/query/lens_get_usernames.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:collection/collection.dart';

class LensAccountLemonadeUsername extends StatefulWidget {
  const LensAccountLemonadeUsername({
    super.key,
  });

  @override
  State<LensAccountLemonadeUsername> createState() =>
      _LensAccountLemonadeUsernameState();
}

class _LensAccountLemonadeUsernameState
    extends State<LensAccountLemonadeUsername> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return BlocBuilder<LensAuthBloc, LensAuthState>(
      builder: (context, state) {
        final walletState = context.watch<WalletBloc>().state;
        final isWalletConnected = walletState.activeSession?.address != null;
        final hasLensAccount =
            state.accountStatus == LensAccountStatus.accountOwner;

        if (!state.loggedIn || !hasLensAccount || !isWalletConnected) {
          return InkWell(
            onTap: () async {
              await _onPressConnectLensAccount(context);
            },
            child: Text(
              t.home.drawer.connectToClaimUsername,
              style: appText.md.copyWith(
                color: appColors.textAccent,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        final lensAccount = state.availableAccounts.firstOrNull;

        if (lensAccount == null) {
          return Text(
            t.home.drawer.claimUsername,
            style: appText.md.copyWith(
              color: appColors.textAccent,
            ),
          );
        }

        return FutureBuilder(
          future: Future.value(true),
          builder: (context, snapshot) {
            return GraphQLProvider(
              client: ValueNotifier(getIt<LensGQL>().client),
              child: Query$LensGetUsernames$Widget(
                key: ValueKey(DateTime.now().millisecond),
                options: Options$Query$LensGetUsernames(
                  fetchPolicy: FetchPolicy.networkOnly,
                  variables: Variables$Query$LensGetUsernames(
                    request: Input$UsernamesRequest(
                      filter: Input$UsernamesFilter(
                        owner: lensAccount.address,
                        namespace: AppConfig.lensNamespace,
                      ),
                    ),
                  ),
                ),
                builder: (result, {refetch, fetchMore}) {
                  final lensLemonadeUsername =
                      result.parsedData?.usernames.items.firstOrNull?.localName;

                  if (lensLemonadeUsername == null) {
                    return InkWell(
                      onTap: () => _onPressClaimLensUsername(context),
                      child: Text(
                        t.home.drawer.claimUsername,
                        style: appText.md.copyWith(
                          color: appColors.textAccent,
                        ),
                      ),
                    );
                  }

                  return Text(
                    '@$lensLemonadeUsername',
                    style: appText.md.copyWith(
                      color: appColors.textAccent,
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<bool> _onPressConnectLensAccount(BuildContext context) async {
    final appColors = context.theme.appColors;
    final isLensAccountConnected = await showCupertinoModalBottomSheet(
      backgroundColor: appColors.pageBg,
      context: context,
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (newContext) {
        return const LensOnboardingBottomSheet();
      },
    );
    return isLensAccountConnected;
  }

  Future<void> _onPressClaimLensUsername(BuildContext context) async {
    final lemonadeUsernameClaimed =
        await AutoRouter.of(context).push(const CreateLensUsernameRoute());

    if (lemonadeUsernameClaimed == true) {
      setState(() {});
    }
  }
}
