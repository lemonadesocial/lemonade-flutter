import 'package:app/core/application/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/fonts.gen.dart';
import '../../../../injection/register_module.dart';
import '../../../../theme/color.dart';
import '../../../../theme/typo.dart';
import '../../../domain/post/post_repository.dart';
import '../../../service/post/post_service.dart';

@RoutePage()
class OnboardingWrapperPage extends StatelessWidget implements AutoRouteWrapper {
  const OnboardingWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: onBoardingTheme,
      child: const AutoRouter(),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<OnboardingBloc>(
      create: (context) => OnboardingBloc(
        PostService(
          getIt<PostRepository>(),
        ),
      ),
      child: this,
    );
  }
}

final onBoardingTheme = ThemeData(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  brightness: Brightness.dark,
  textTheme: TextTheme(
    titleMedium: TextStyle(
      fontSize: 26.sp,
      fontWeight: FontWeight.w800,
      color: LemonColor.onboardingTitle,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: LemonColor.white54,
      fontFamily: FontFamily.switzerVariable,
    ),
  ),
  colorScheme: lemonadeDarkThemeColorScheme,
  backgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: false,
    color: LemonColor.black,
    titleTextStyle: Typo.large,
  ),
);
