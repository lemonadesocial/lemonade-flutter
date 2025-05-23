import 'package:app/core/presentation/pages/onboarding/widgets/onboarding_photo_picker.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/core/application/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/app_theme/app_theme.dart';

@RoutePage()
class OnboardingProfilePhotoPage extends StatelessWidget {
  const OnboardingProfilePhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    final bloc = context.read<OnboardingBloc>();
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state.status == OnboardingStatus.success) {
          context.router.push(const OnboardingSocialOnChainRoute());
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: appColors.pageBg,
          appBar: LemonAppBar(
            actions: [
              Row(
                children: [
                  InkWell(
                    onTap: () => context.router
                        .push(const OnboardingSocialOnChainRoute()),
                    child: Text(
                      t.onboarding.skip,
                      style: appText.md.copyWith(
                        color: appColors.textTertiary,
                      ),
                    ),
                  ),
                  SizedBox(width: Spacing.smMedium),
                ],
              ),
            ],
          ),
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
                        style: appText.xl,
                      ),
                      SizedBox(height: Spacing.extraSmall),
                      Text(
                        t.onboarding.findYourLookDesc,
                        style: appText.md.copyWith(
                          color: appColors.textTertiary,
                        ),
                      ),
                      SizedBox(height: Spacing.medium),
                      OnboardingPhotoPicker(
                        imageFile: state.profilePhoto,
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Spacing.xSmall,
                    ),
                    child: LinearGradientButton.primaryButton(
                      onTap:
                          state.profilePhoto == null ? null : bloc.uploadImage,
                      label: t.onboarding.next,
                      loadingWhen: state.status == OnboardingStatus.loading,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
