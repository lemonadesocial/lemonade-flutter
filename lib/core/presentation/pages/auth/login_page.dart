import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/bottom_bar/bottom_bar_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/home_appbar/home_appbar_default_more_actions_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/ory_wallet_auth/ory_wallet_auth_button.dart';
import 'package:app/core/utils/onboarding_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  final bool isHomeScreen;
  const LoginPage({
    super.key,
    this.isHomeScreen = false,
  });

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = Theme.of(context).appColors;
    return Scaffold(
      appBar: LemonAppBar(
        backButtonColor: appColors.textTertiary,
        leading: widget.isHomeScreen
            ? Padding(
                padding: EdgeInsets.only(left: Spacing.smMedium),
                child: Assets.icons.icLemonadeLogo.svg(),
              )
            : null,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacing.xSmall),
            child: const HomeAppBarDefaultMoreActionsWidget(),
          ),
        ],
      ),
      backgroundColor: colorScheme.primary,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (user) {
              if (!widget.isHomeScreen) {
                AutoRouter.of(context).pop();
              }
            },
            onBoardingRequired: (user) {
              OnboardingUtils.startOnboarding(context, user: user);
            },
            orElse: () {},
          );
        },
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final t = Translations.of(context);
    final appColors = Theme.of(context).appColors;
    final appText = context.theme.appTextTheme;
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 1,
              child: Image(
                image: Assets.images.bgGetStarted.provider(),
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t.auth.lets_get_you_in,
                    textAlign: TextAlign.center,
                    style: appText.xl,
                  ),
                  SizedBox(height: 9.h),
                  Text(
                    t.auth.get_started_description,
                    textAlign: TextAlign.center,
                    style: appText.md.copyWith(
                      color: appColors.textTertiary,
                    ),
                  ),
                  SizedBox(height: Spacing.small),
                  _buildAuthButtons(context),
                  SizedBox(height: Spacing.small),
                  LemonOutlineButton(
                    onTap: () {
                      AutoRouter.of(context).navigate(
                        DiscoverRoute(),
                      );
                    },
                    borderColor: Colors.transparent,
                    label: t.auth.explore,
                    textStyle: appText.md.copyWith(
                      color: appColors.textAccent,
                    ),
                  ),
                  SizedBox(height: Spacing.small),
                ],
              ),
            ),
            if (widget.isHomeScreen)
              SizedBox(
                height: BottomBar.bottomBarHeight + Spacing.large,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildAuthButtons(BuildContext context) {
    final t = Translations.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final processingWidget = SizedBox(
          height: 48.h,
          child: Loading.defaultLoading(context),
        );

        final loginButton = Column(
          children: [
            LinearGradientButton.secondaryButton(
              mode: GradientButtonMode.light,
              label: t.auth.signInOrCreateAccount,
              onTap: () => context.read<AuthBloc>().add(
                    const AuthEvent.login(),
                  ),
            ),
            SizedBox(height: Spacing.small),
            const OryWalletAuthButton(),
          ],
        );

        return state.maybeWhen(
          processing: () => processingWidget,
          unauthenticated: (_) => loginButton,
          unknown: () => loginButton,
          orElse: () => loginButton,
        );
      },
    );
  }
}
