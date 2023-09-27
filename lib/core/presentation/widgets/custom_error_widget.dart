import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/gen/assets.gen.dart';

class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomError({
    super.key,
    required this.errorDetails,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Assets.images.icComingSoon.provider(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(height: 25.h),
            Text(
              t.common.oops,
              style: Typo.extraLarge.copyWith(
                fontFamily: FontFamily.nohemiVariable,
                color: colorScheme.onPrimary,
              ),
            ),
            Container(height: 10.h),
            Text(
              t.common.looksLikeSomethingWrong,
              style: Typo.medium.copyWith(
                fontFamily: FontFamily.spaceGrotesk,
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              width: 180.w,
              margin: EdgeInsets.symmetric(vertical: Spacing.medium),
              child: LinearGradientButton(
                label: t.common.goBack,
                height: 42.h,
                mode: GradientButtonMode.defaultMode,
                radius: BorderRadius.circular(24),
                textStyle: Typo.medium.copyWith(),
                onTap: () => {context.router.pop()},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
