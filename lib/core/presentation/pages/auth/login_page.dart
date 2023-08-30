import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const LemonAppBar(),
      backgroundColor: colorScheme.primary,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (_) {
              AutoRouter.of(context).pop();
            },
            onBoardingRequired: (authSession) {
              context.router.push(
                const OnboardingWrapperRoute(
                  children: [OnboardingUsernameRoute()],
                ),
              );
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
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Positioned.fill(
          child: Image(image: Assets.images.bgCircle.provider()),
        ),
        Column(
          children: [
            // Image(image: Assets.images.bgGetStarted.provider()),
            Transform.translate(
              offset: Offset(0, -22.h), // Move the image up by 30 pixels
              child: Image(image: Assets.images.bgGetStarted.provider()),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 42.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t.auth.lets_get_you_in,
                    textAlign: TextAlign.center,
                    style: Typo.large.copyWith(
                      color: colorScheme.onPrimary,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w800,
                      fontFamily: FontFamily.spaceGrotesk,
                    ),
                  ),
                  SizedBox(height: 9.h),
                  Text(
                    t.auth.get_started_description,
                    textAlign: TextAlign.center,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 42.h),
                  _buildAuthButton(context),
                  SizedBox(height: 42.h),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAuthButton(BuildContext context) {
    final t = Translations.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final processingWidget = SizedBox(
          height: 48.h,
          child: Loading.defaultLoading(context),
        );

        final loginButton = LinearGradientButton(
          label: t.auth.get_started,
          mode: GradientButtonMode.lavenderMode,
          height: 48.h,
          radius: BorderRadius.circular(24),
          textStyle: Typo.medium.copyWith(),
          onTap: () => context.read<AuthBloc>().add(
                const AuthEvent.login(),
              ),
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
