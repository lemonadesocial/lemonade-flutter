import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: const LemonAppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(image: Assets.images.bgCircle.provider()),
          ),
          Column(
            children: [
              Image(image: Assets.images.bgGetStarted.provider()),
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
                    LinearGradientButton(
                      label: t.auth.get_started,
                      mode: GradientButtonMode.lavenderMode,
                      height: 48.h,
                      radius: BorderRadius.circular(24),
                      textStyle: Typo.medium.copyWith(),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
