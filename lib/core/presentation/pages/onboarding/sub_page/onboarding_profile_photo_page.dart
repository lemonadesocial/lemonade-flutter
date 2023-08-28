import 'package:app/core/presentation/pages/onboarding/widgets/onboarding_photo_picker.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
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
    final bloc = context.read<OnboardingBloc>();
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state.status == OnboardingStatus.success) {
          context.router.push(const OnboardingAboutRoute());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const LemonBackButton(),
            actions: [
              Row(
                children: [
                  InkWell(
                    onTap: () => context.router.push(const OnboardingAboutRoute()),
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
                        onTap: bloc.selectProfileImage,
                        imageFile: state.profilePhoto,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 1.sw,
                  child: ElevatedButton(
                    onPressed: state.profilePhoto == null ? null : bloc.uploadImage,
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
      },
    );
  }
}
