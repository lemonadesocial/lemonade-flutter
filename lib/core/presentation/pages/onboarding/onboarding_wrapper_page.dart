import 'package:app/core/application/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix/matrix.dart';

@RoutePage()
class OnboardingWrapperPage extends StatelessWidget
    implements AutoRouteWrapper {
  final bool? onboardingFlow;
  const OnboardingWrapperPage({
    super.key,
    this.onboardingFlow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: onBoardingTheme,
      child: WillPopScope(
        onWillPop: () async {
          if (onboardingFlow == false) return true;
          var currentTopRoute = AutoRouter.of(context).topRoute;
          bool? isPopBlocked = currentTopRoute.meta.tryGet('popBlocked');
          return isPopBlocked != null ? !isPopBlocked : true;
        },
        child: const AutoRouter(),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<OnboardingBloc>(
      create: (context) => OnboardingBloc(
        getIt<UserRepository>(),
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
      fontFamily: FontFamily.generalSans,
    ),
  ),
  colorScheme: lemonadeDarkThemeColorScheme,
  // backgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: false,
    color: LemonColor.black,
    titleTextStyle: Typo.large,
  ),
);
