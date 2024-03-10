import 'package:app/core/presentation/widgets/animation/ripple_animation.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class GuestEventApplicationInfoPage extends StatelessWidget {
  const GuestEventApplicationInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const LemonAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    SizedBox(
                      width: 450.w,
                      height: 450.w,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: LayoutBuilder(
                              builder: (context, constraints) =>
                                  Transform.scale(
                                scale: 1.5,
                                child: RippleAnimation(
                                  size: constraints.maxWidth,
                                  color: const Color.fromARGB(255, 33, 33, 33),
                                  scaleTween: Tween<double>(begin: 0.3, end: 1),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const RadialGradient(
                                  colors: [
                                    Colors.black,
                                    Color.fromARGB(255, 33, 33, 33),
                                  ],
                                  stops: [
                                    0.5,
                                    1,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(240.w),
                              ),
                              width: 240.w,
                              height: 240.w,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Assets.icons.icAccountGradient.svg(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      t.event.requiredFields.tellUsMore,
                      textAlign: TextAlign.center,
                      style: Typo.extraLarge.copyWith(
                        color: colorScheme.onPrimary,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: FontFamily.nohemiVariable,
                      ),
                    ),
                    SizedBox(height: Spacing.superExtraSmall),
                    Text(
                      t.event.requiredFields.description,
                      textAlign: TextAlign.center,
                      style: Typo.mediumPlus.copyWith(
                        color: colorScheme.onSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
                      child: LinearGradientButton(
                        onTap: () {
                          AutoRouter.of(context).navigate(
                            const GuestEventApplicationFormRoute(),
                          );
                        },
                        label: t.event.requiredFields.completeProfile,
                        textStyle: Typo.medium.copyWith(
                          fontFamily: FontFamily.nohemiVariable,
                          fontWeight: FontWeight.w600,
                        ),
                        height: Sizing.large,
                        radius: BorderRadius.circular(LemonRadius.large),
                        mode: GradientButtonMode.lavenderMode,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
