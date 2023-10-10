import 'package:app/core/presentation/pages/onboarding/widgets/onboarding_photo_picker.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/core/application/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';

@RoutePage()
class OnboardingProfilePhotoPage extends StatelessWidget {
  const OnboardingProfilePhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final bloc = context.read<OnboardingBloc>();
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state.status == OnboardingStatus.success) {
          context.router.push(const OnboardingAboutRoute());
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                Row(
                  children: [
                    InkWell(
                      onTap: () =>
                          context.router.push(const OnboardingAboutRoute()),
                      child: Text(
                        t.onboarding.skip,
                        style:
                            Typo.medium.copyWith(fontWeight: FontWeight.w400),
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
                  SizedBox(height: Spacing.medium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.onboarding.findYourLook,
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w800,
                            color: LemonColor.onboardingTitle,
                            fontFamily: FontFamily.nohemiVariable,
                          ),
                        ),
                        SizedBox(height: Spacing.extraSmall),
                        Text(
                          t.onboarding.findYourLookDesc,
                          style: theme.textTheme.bodyMedium,
                        ),
                        SizedBox(height: Spacing.medium),
                        OnboardingPhotoPicker(
                          imageFile: state.profilePhoto,
                        ),
                      ],
                    ),
                  ),
                  LinearGradientButton(
                    onTap: state.profilePhoto == null ? null : bloc.uploadImage,
                    label: t.onboarding.next,
                    textStyle: Typo.medium.copyWith(
                      fontFamily: FontFamily.nohemiVariable,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onPrimary,
                    ),
                    height: Sizing.large,
                    radius: BorderRadius.circular(LemonRadius.large),
                    mode: state.profilePhoto == null
                        ? GradientButtonMode.defaultMode
                        : GradientButtonMode.lavenderMode,
                    loadingWhen: state.status == OnboardingStatus.loading,
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
