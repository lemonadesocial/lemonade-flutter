import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_field_item.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_bottom_sheet_mixin.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileSocialDialog extends StatelessWidget with LemonBottomSheet {
  final User userProfile;
  const EditProfileSocialDialog({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state.status == EditProfileStatus.success) {
          context.read<AuthBloc>().add(const AuthEvent.refreshData());
          SnackBarUtils.showSuccess(message: t.profile.editProfileSuccess);
          context.read<EditProfileBloc>().add(EditProfileEvent.clearState());
        }
      },
      child: Scaffold(
        appBar: LemonAppBar(
          backgroundColor: colorScheme.onPrimaryContainer,
        ),
        backgroundColor: colorScheme.onPrimaryContainer,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.profile.socialHandle,
                        style: Typo.extraLarge,
                      ),
                      SizedBox(height: Spacing.superExtraSmall),
                      Text(
                        t.profile.socialHandleLongDesc,
                        style: Typo.mediumPlus.copyWith(
                          color: colorScheme.onPrimary.withOpacity(0.56),
                        ),
                      ),
                      SizedBox(height: Spacing.medium),
                      EditProfileFieldItem(
                        profileFieldKey: ProfileFieldKey.handleTwitter,
                        onChange: (input) {
                          context.read<EditProfileBloc>().add(
                                EditProfileEvent.twitterChange(
                                  input: input,
                                ),
                              );
                        },
                        value: userProfile.handleTwitter,
                      ),
                      SizedBox(height: Spacing.medium),
                      EditProfileFieldItem(
                        profileFieldKey: ProfileFieldKey.handleLinkedin,
                        onChange: (input) {
                          context.read<EditProfileBloc>().add(
                                EditProfileEvent.linkedinChange(
                                  input: input,
                                ),
                              );
                        },
                        value: userProfile.handleLinkedin,
                      ),
                      SizedBox(height: Spacing.medium),
                      EditProfileFieldItem(
                        profileFieldKey: ProfileFieldKey.handleInstagram,
                        onChange: (input) {
                          context.read<EditProfileBloc>().add(
                                EditProfileEvent.instagramChange(
                                  input: input,
                                ),
                              );
                        },
                        value: userProfile.handleInstagram,
                      ),
                      SizedBox(height: Spacing.medium),
                      EditProfileFieldItem(
                        profileFieldKey: ProfileFieldKey.handleFarcaster,
                        onChange: (input) {
                          context.read<EditProfileBloc>().add(
                                EditProfileEvent.farcasterChange(
                                  input: input,
                                ),
                              );
                        },
                        value: userProfile.handleFarcaster,
                      ),
                      SizedBox(height: Spacing.medium),
                      EditProfileFieldItem(
                        profileFieldKey: ProfileFieldKey.handleGithub,
                        onChange: (input) {
                          context.read<EditProfileBloc>().add(
                                EditProfileEvent.githubChange(
                                  input: input,
                                ),
                              );
                        },
                        value: userProfile.handleGithub,
                      ),
                      SizedBox(height: Spacing.medium),
                      EditProfileFieldItem(
                        profileFieldKey: ProfileFieldKey.handleLens,
                        onChange: (input) {
                          context.read<EditProfileBloc>().add(
                                EditProfileEvent.lensChange(
                                  input: input,
                                ),
                              );
                        },
                        value: userProfile.handleLens,
                      ),
                      SizedBox(height: Spacing.medium),
                      EditProfileFieldItem(
                        profileFieldKey: ProfileFieldKey.handleMirror,
                        onChange: (input) {
                          context.read<EditProfileBloc>().add(
                                EditProfileEvent.mirrorChange(
                                  input: input,
                                ),
                              );
                        },
                        value: userProfile.handleMirror,
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<EditProfileBloc, EditProfileState>(
                builder: (context, state) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: Spacing.smMedium),
                    width: 1.sw,
                    child: LinearGradientButton(
                      onTap: () {
                        context.read<EditProfileBloc>().add(
                              EditProfileEvent.submitEditProfile(),
                            );
                      },
                      label: t.profile.saveChanges,
                      textStyle: Typo.medium.copyWith(
                        fontFamily: FontFamily.nohemiVariable,
                        fontWeight: FontWeight.w600,
                      ),
                      height: Sizing.large,
                      radius: BorderRadius.circular(LemonRadius.large),
                      mode: GradientButtonMode.lavenderMode,
                      loadingWhen: state.status == EditProfileStatus.loading,
                    ),
                  );
                },
              ),
              SizedBox(height: Spacing.smMedium),
            ],
          ),
        ),
      ),
    );
  }
}
