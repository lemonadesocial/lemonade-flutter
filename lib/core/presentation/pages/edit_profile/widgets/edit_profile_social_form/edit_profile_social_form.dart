import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_form_fields/edit_profile_text_field.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileSocialForm extends StatelessWidget {
  final User? userProfile;
  final EditProfileState editState;

  const EditProfileSocialForm({
    super.key,
    required this.userProfile,
    required this.editState,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    // Use bloc state if changed, otherwise fallback to userProfile
    String getValue(String? stateValue, String? profileValue) =>
        (stateValue != null && stateValue.isNotEmpty)
            ? stateValue
            : (profileValue ?? '');

    return CupertinoListSection.insetGrouped(
      header: Text(
        "Social handles",
        style: appText.sm.copyWith(
          color: appColors.textTertiary,
        ),
      ),
      backgroundColor: appColors.pageBg,
      separatorColor: appColors.pageDivider,
      dividerMargin: 0,
      additionalDividerMargin: 0,
      hasLeading: true,
      topMargin: 0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.md),
        color: appColors.buttonTertiaryBg,
        border: Border.all(color: appColors.cardBorder),
      ),
      children: [
        EditProfileTextField(
          icon: Assets.icons.icXLine,
          label: "X(Twitter)",
          initialValue:
              getValue(editState.handleTwitter, userProfile?.handleTwitter),
          onChange: (input) => context.read<EditProfileBloc>().add(
                EditProfileEvent.twitterChange(input: input),
              ),
          maxLines: 1,
          placeholder: 'username',
        ),
        EditProfileTextField(
          icon: Assets.icons.icLinkedin,
          label: "LinkedIn",
          initialValue:
              getValue(editState.handleLinkedin, userProfile?.handleLinkedin),
          onChange: (input) => context.read<EditProfileBloc>().add(
                EditProfileEvent.linkedinChange(input: input),
              ),
          maxLines: 1,
          placeholder: '/us/handle',
        ),
        EditProfileTextField(
          icon: Assets.icons.icInstagram,
          label: "Instagram",
          initialValue:
              getValue(editState.handleInstagram, userProfile?.handleInstagram),
          onChange: (input) => context.read<EditProfileBloc>().add(
                EditProfileEvent.instagramChange(input: input),
              ),
          maxLines: 1,
          placeholder: 'username',
        ),
        EditProfileTextField(
          icon: Assets.icons.icGithubFilled,
          label: "Github",
          initialValue:
              getValue(editState.handleGithub, userProfile?.handleGithub),
          onChange: (input) => context.read<EditProfileBloc>().add(
                EditProfileEvent.githubChange(input: input),
              ),
          maxLines: 1,
          placeholder: 'username',
        ),
        EditProfileTextField(
          icon: Assets.icons.icLensFilled,
          label: "Lens",
          initialValue: getValue(editState.handleLens, userProfile?.handleLens),
          onChange: (input) => context.read<EditProfileBloc>().add(
                EditProfileEvent.lensChange(input: input),
              ),
          maxLines: 1,
          placeholder: 'username',
        ),
        EditProfileTextField(
          icon: Assets.icons.icMirror,
          label: "Mirror",
          initialValue:
              getValue(editState.handleMirror, userProfile?.handleMirror),
          onChange: (input) => context.read<EditProfileBloc>().add(
                EditProfileEvent.mirrorChange(input: input),
              ),
          maxLines: 1,
          placeholder: 'username',
        ),
      ],
    );
  }
}
