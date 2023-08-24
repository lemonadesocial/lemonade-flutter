import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../gen/fonts.gen.dart';
import '../../../../../i18n/i18n.g.dart';
import '../../../../../theme/color.dart';
import '../../../../application/onboarding/onboarding_bloc/onboarding_bloc.dart';

@RoutePage()
class OnboardingProfilePhotoPage extends StatelessWidget {
  const OnboardingProfilePhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final textCtrl = TextEditingController();
    final bloc = context.read<OnboardingBloc>();
    return Scaffold(
      appBar: AppBar(
        leading: LemonBackButton(),
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () => context.router.push(OnboardingAboutRoute()),
                child: Text(
                  t.onboarding.skip,
                  style: Typo.medium.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(width: Spacing.smMedium),
            ],
          ),
        ],
      ),
      backgroundColor: theme.colorScheme.primary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.onboarding.pickUsername,
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w800,
                      color: LemonColor.onboardingTitle,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                  ),
                  SizedBox(height: Spacing.extraSmall),
                  Text(
                    t.onboarding.pickUsernameDesc,
                    style: theme.textTheme.bodyMedium,
                  ),
                  SizedBox(height: Spacing.medium),
                  InkWell(
                    onTap: bloc.selectProfileImage,
                    child: Container(
                      width: 327.w,
                      height: 327.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: theme.colorScheme.outline,
                          width: 0.5.w,
                        ),
                        color: LemonColor.white.withOpacity(0.06),
                      ),
                      child: Center(
                        child: ThemeSvgIcon(
                          color: theme.colorScheme.onSurfaceVariant,
                          builder: (colorFilter) => Assets.icons.icSelectImage.svg(
                            colorFilter: colorFilter,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 1.sw,
              child: ElevatedButton(
                onPressed: textCtrl.text.isEmpty ? null : () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 18.w,
                  ),
                  backgroundColor: theme.colorScheme.onTertiary,
                  disabledBackgroundColor: theme.colorScheme.onSecondaryContainer,
                ),
                child: Text(
                  t.onboarding.next,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: FontFamily.nohemiVariable,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
