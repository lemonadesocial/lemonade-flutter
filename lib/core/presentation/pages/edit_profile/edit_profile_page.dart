import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/edit_profile/sub_pages/edit_profile_personal_page.dart';
import 'package:app/core/presentation/pages/edit_profile/sub_pages/edit_profile_social_page.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_avatar.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({
    Key? key,
    required this.userProfile,
  }) : super(key: key);

  final User userProfile;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocProvider(
      create: (context) => EditProfileBloc(
        getIt<UserRepository>(),
        PostService(
          getIt<PostRepository>(),
        ),
      ),
      child: BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
          return Scaffold(
            appBar: LemonAppBar(title: t.profile.editProfile),
            backgroundColor: colorScheme.primary,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _PersonalCardWidget(userProfile: userProfile),
                          SizedBox(height: 30.h),
                          Row(
                            children: [
                              EditProfileAvatar(imageFile: state.profilePhoto),
                              SizedBox(width: 15.w),
                              Expanded(
                                child: LemonTextField(
                                  label: t.onboarding.displayName,
                                  onChange: (value) {},
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: Spacing.smMedium),
                          LemonTextField(
                            label: t.onboarding.username,
                            onChange: (value) {},
                          ),
                          SizedBox(height: Spacing.smMedium),
                          LemonTextField(
                            label: t.profile.tagline,
                            onChange: (value) {},
                          ),
                          SizedBox(height: Spacing.smMedium),
                          LemonTextField(
                            label: t.onboarding.shortBio,
                            onChange: (value) {},
                          ),
                          SizedBox(height: Spacing.smMedium),
                          InkWell(
                            onTap: () =>
                                const EditProfileSocialDialog().show(context),
                            child: Container(
                              padding: EdgeInsets.all(Spacing.xSmall),
                              decoration: BoxDecoration(
                                color: colorScheme.onPrimary.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(
                                  LemonRadius.normal,
                                ),
                              ),
                              child: ListTile(
                                title: Text(t.profile.socialHandle),
                                subtitle: Text(t.profile.socialHandleDesc),
                                trailing: Assets.icons.icArrowBack.svg(
                                  width: 18.w,
                                  height: 18.w,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Spacing.smMedium),
                          InkWell(
                            onTap: () =>
                                const EditProfilePersonalDialog().show(context),
                            child: Container(
                              padding: EdgeInsets.all(Spacing.xSmall),
                              decoration: BoxDecoration(
                                color: colorScheme.onPrimary.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(
                                  LemonRadius.normal,
                                ),
                              ),
                              child: ListTile(
                                title: Text(t.profile.personalInfo),
                                subtitle: Text(t.profile.personalInfoDesc),
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
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: Spacing.smMedium),
                    child: LinearGradientButton(
                      onTap: () {},
                      label: t.profile.saveChanges,
                      textStyle: Typo.medium.copyWith(
                        fontFamily: FontFamily.nohemiVariable,
                        fontWeight: FontWeight.w600,
                      ),
                      height: Sizing.large,
                      radius: BorderRadius.circular(LemonRadius.large),
                      mode: GradientButtonMode.lavenderMode,
                    ),
                  ),
                  SizedBox(height: Spacing.smMedium),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PersonalCardWidget extends StatelessWidget {
  const _PersonalCardWidget({
    Key? key,
    required this.userProfile,
  }) : super(key: key);

  final User userProfile;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Container(
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
              Assets.icons.icExpand.svg()
            ],
          ),
          SizedBox(height: Spacing.xSmall),
          Row(
            children: [
              Assets.icons.icMail.svg(),
              SizedBox(width: Spacing.xSmall),
              Expanded(
                child: Text(
                  'minha2@yopmail.com',
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
              style: Typo.small,
            ),
          ),
        ],
      ),
    );
  }
}
