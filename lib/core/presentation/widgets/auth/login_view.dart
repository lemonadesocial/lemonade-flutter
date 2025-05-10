import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/presentation/widgets/bottom_bar/app_tabs.dart';
import 'package:app/core/presentation/widgets/bottom_bar/bottom_bar_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, this.hideBackButton = false});

  final bool hideBackButton;

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image(image: Assets.images.bgCircle.provider()),
          ),
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
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      t.auth.getStarted,
                      textAlign: TextAlign.center,
                      style: Typo.large.copyWith(
                        color: colorScheme.onPrimary,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      t.auth.getStartedDescription,
                      textAlign: TextAlign.center,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    _buildAuthButton(context),
                    SizedBox(height: 16.h),
                    _buildExploreButton(context),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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

        final loginButton = LinearGradientButton.whiteButton(
          label: t.auth.signInOrCreateAccount,
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

  Widget _buildExploreButton(BuildContext context) {
    final t = Translations.of(context);
    return TextButton(
      onPressed: () {
        context.router.navigate(DiscoverRoute());
      },
      child: Text(
        t.auth.explore,
        textAlign: TextAlign.center,
        style: Typo.medium.copyWith(
          color: LemonColor.paleViolet,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
