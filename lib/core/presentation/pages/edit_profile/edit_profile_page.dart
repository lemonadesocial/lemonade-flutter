import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/edit_profile/sub_pages/edit_profile_personal_page.dart';
import 'package:app/core/presentation/pages/edit_profile/sub_pages/edit_profile_social_page.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_avatar.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_field_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(),
      child: const EditProfileView(),
    );
  }
}

class EditProfileView extends StatelessWidget {
  const EditProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final editProfileBloc = context.watch<EditProfileBloc>();
    return FutureBuilder(
      future: getIt<UserRepository>().getMe(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 120.w,
            child: Loading.defaultLoading(context),
          );
        }
        User? userProfile = snapshot.data!.fold(
          (l) => null,
          (user) => user,
        );
        if (userProfile == null) {
          return Center(
            child: EmptyList(
              emptyText: t.common.somethingWrong,
            ),
          );
        }
        return BlocListener<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            if (state.status == EditProfileStatus.success) {
              context.read<AuthBloc>().add(const AuthEvent.refreshData());
              SnackBarUtils.showSuccess(
                message: t.profile.editProfileSuccess,
              );
              context
                  .read<EditProfileBloc>()
                  .add(EditProfileEvent.clearState());
            }
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: LemonAppBar(title: t.profile.editProfile),
              backgroundColor: colorScheme.primary,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: Column(
                  children: [
                    BlocBuilder<EditProfileBloc, EditProfileState>(
                      builder: (context, state) {
                        return Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                _PersonalCardWidget(userProfile: userProfile),
                                SizedBox(height: 30.h),
                                Row(
                                  children: [
                                    EditProfileAvatar(
                                      imageFile: state.profilePhoto,
                                      imageUrl: userProfile.imageAvatar,
                                    ),
                                    SizedBox(width: 15.w),
                                    Expanded(
                                      child: EditProfileFieldItem(
                                        profileFieldKey:
                                            ProfileFieldKey.displayName,
                                        onChange: (input) {
                                          context.read<EditProfileBloc>().add(
                                                EditProfileEvent
                                                    .displayNameChange(
                                                  input: input,
                                                ),
                                              );
                                        },
                                        value: userProfile.displayName,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Spacing.smMedium),
                                _UserEditor(
                                  userName: state.username ??
                                      userProfile.username ??
                                      '',
                                ),
                                SizedBox(height: Spacing.smMedium),
                                EditProfileFieldItem(
                                  profileFieldKey: ProfileFieldKey.tagline,
                                  onChange: (input) {
                                    context.read<EditProfileBloc>().add(
                                          EditProfileEvent.taglineChange(
                                            input: input,
                                          ),
                                        );
                                  },
                                  value: userProfile.tagline,
                                ),
                                SizedBox(height: Spacing.smMedium),
                                EditProfileFieldItem(
                                  profileFieldKey: ProfileFieldKey.description,
                                  onChange: (input) {
                                    context.read<EditProfileBloc>().add(
                                          EditProfileEvent.shortBioChange(
                                            input: input,
                                          ),
                                        );
                                  },
                                  value: userProfile.description,
                                ),
                                SizedBox(height: Spacing.smMedium),
                                InkWell(
                                  onTap: () {
                                    BottomSheetUtils.showSnapBottomSheet(
                                      context,
                                      builder: (innerContext) =>
                                          MultiBlocProvider(
                                        providers: [
                                          BlocProvider.value(
                                            value: editProfileBloc,
                                          ),
                                        ],
                                        child: EditProfileSocialDialog(
                                          userProfile: userProfile,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(Spacing.xSmall),
                                    decoration: BoxDecoration(
                                      color: colorScheme.onPrimary
                                          .withOpacity(0.06),
                                      borderRadius: BorderRadius.circular(
                                        LemonRadius.normal,
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text(t.profile.socialHandle),
                                      subtitle:
                                          Text(t.profile.socialHandleDesc),
                                      trailing: Assets.icons.icArrowBack.svg(
                                        width: 18.w,
                                        height: 18.w,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: Spacing.smMedium),
                                InkWell(
                                  onTap: () {
                                    BottomSheetUtils.showSnapBottomSheet(
                                      context,
                                      builder: (innerContext) =>
                                          MultiBlocProvider(
                                        providers: [
                                          BlocProvider.value(
                                            value: editProfileBloc,
                                          ),
                                        ],
                                        child: EditProfilePersonalDialog(
                                          userProfile: userProfile,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(Spacing.xSmall),
                                    decoration: BoxDecoration(
                                      color: colorScheme.onPrimary
                                          .withOpacity(0.06),
                                      borderRadius: BorderRadius.circular(
                                        LemonRadius.normal,
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text(t.profile.personalInfo),
                                      subtitle:
                                          Text(t.profile.personalInfoDesc),
                                      trailing: Assets.icons.icArrowBack.svg(
                                        width: 18.w,
                                        height: 18.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<EditProfileBloc, EditProfileState>(
                      builder: (context, state) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            vertical: Spacing.smMedium,
                          ),
                          child: LinearGradientButton(
                            onTap: () {
                              if (state.status == EditProfileStatus.editing) {
                                FocusScope.of(context).unfocus();
                                context.read<EditProfileBloc>().add(
                                      EditProfileEvent.submitEditProfile(),
                                    );
                              }
                            },
                            label: t.profile.saveChanges,
                            textStyle: Typo.medium.copyWith(
                              fontFamily: FontFamily.nohemiVariable,
                              fontWeight: FontWeight.w600,
                            ),
                            height: Sizing.large,
                            radius: BorderRadius.circular(LemonRadius.large),
                            mode: state.status != EditProfileStatus.initial
                                ? GradientButtonMode.lavenderMode
                                : GradientButtonMode.defaultMode,
                            loadingWhen:
                                state.status == EditProfileStatus.loading,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: Spacing.smMedium),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PersonalCardWidget extends StatelessWidget {
  const _PersonalCardWidget({
    required this.userProfile,
  });

  final User userProfile;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(const SettingRoute());
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.normal),
          color: colorScheme.onPrimary.withOpacity(0.06),
        ),
        child: Column(
          children: [
            SizedBox(height: Spacing.smMedium),
            Row(
              children: [
                Assets.icons.icProfile.svg(
                  width: 18.w,
                  height: 18.w,
                ),
                SizedBox(width: Spacing.xSmall),
                Expanded(
                  child: Text(
                    userProfile.name ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: Typo.medium.copyWith(
                      fontWeight: FontWeight.normal,
                      color: colorScheme.onPrimary.withOpacity(0.54),
                    ),
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
                Assets.icons.icExpand.svg(),
              ],
            ),
            SizedBox(height: Spacing.xSmall),
            Row(
              children: [
                Assets.icons.icMail.svg(),
                SizedBox(width: Spacing.xSmall),
                Expanded(
                  child: Text(
                    userProfile.email ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: Typo.medium.copyWith(
                      fontWeight: FontWeight.normal,
                      color: colorScheme.onPrimary.withOpacity(0.54),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.smMedium),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Spacing.small),
              child: Text(
                t.profile.infoSecureDesc,
                style: Typo.small.copyWith(
                  color: colorScheme.onPrimary.withOpacity(0.36),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserEditor extends StatelessWidget {
  const _UserEditor({
    required this.userName,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.onboarding.username,
          style: Typo.small.copyWith(
            color: colorScheme.onPrimary.withOpacity(0.36),
          ),
        ),
        SizedBox(height: Spacing.superExtraSmall),
        InkWell(
          onTap: () async {
            final userName = await context.router.push(
              OnboardingWrapperRoute(
                onboardingFlow: false,
                children: [OnboardingUsernameRoute(onboardingFlow: false)],
              ),
            ) as String?;
            if (userName != null) {
              context.read<EditProfileBloc>().add(
                    EditProfileEvent.usernameChange(input: userName),
                  );
            }
          },
          child: Container(
            width: 1.sw,
            padding: EdgeInsets.all(Spacing.smMedium),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Text(
              userName,
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
