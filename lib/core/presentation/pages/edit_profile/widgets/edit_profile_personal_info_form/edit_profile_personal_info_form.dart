import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/lens/entities/lens_lemonade_profile.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_form_fields/edit_profile_text_field.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_form_fields/edit_profile_picker_field.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/i18n/i18n.g.dart';

class EditProfilePersonalInfoForm extends StatelessWidget {
  final LensLemonadeProfile? userProfile;
  final EditProfileState editState;

  const EditProfilePersonalInfoForm({
    super.key,
    required this.userProfile,
    required this.editState,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);

    String getValue(String? stateValue, String? profileValue) =>
        (stateValue != null && stateValue.isNotEmpty)
            ? stateValue
            : (profileValue ?? '');

    return CupertinoListSection.insetGrouped(
      header: Text(
        t.profile.personalInfo,
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
        EditProfilePickerField(
          label: t.profile.pronoun,
          initialValue: getValue(
            editState.pronoun?.pronoun,
            userProfile?.pronoun,
          ),
          onChange: (input) {
            if (input != null) {
              context.read<EditProfileBloc>().add(
                    EditProfileEvent.pronounChange(
                      input: LemonPronoun.fromString(input) ?? LemonPronoun.he,
                    ),
                  );
            }
          },
          options: LemonPronoun.values.map((e) => e.pronoun).toList(),
        ),
        EditProfileTextField(
          label: t.profile.jobTitle,
          initialValue: getValue(editState.jobTitle, userProfile?.jobTitle),
          onChange: (input) => context.read<EditProfileBloc>().add(
                EditProfileEvent.jobTitleChange(input: input),
              ),
          maxLines: 1,
          placeholder: t.profile.hint.jobTitle,
        ),
        EditProfileTextField(
          label: t.profile.organization,
          initialValue:
              getValue(editState.companyName, userProfile?.companyName),
          onChange: (input) => context.read<EditProfileBloc>().add(
                EditProfileEvent.organizationChange(input: input),
              ),
          maxLines: 1,
          placeholder: t.profile.hint.organization,
        ),
        // EditProfilePickerField(
        //   label: t.profile.industry,
        //   initialValue: getValue(editState.industry, userProfile?.industry),
        //   onChange: (input) => context.read<EditProfileBloc>().add(
        //         EditProfileEvent.industrySelect(industry: input),
        //       ),
        //   options: LemonIndustry.values.map((e) => e.industry).toList(),
        //   placeholder: t.profile.hint.industry,
        // ),
        // EditProfileTextField(
        //   label: t.profile.education,
        //   initialValue:
        //       getValue(editState.education, userProfile?.educationTitle),
        //   onChange: (input) => context.read<EditProfileBloc>().add(
        //         EditProfileEvent.educationChange(input: input),
        //       ),
        //   maxLines: 1,
        //   placeholder: t.profile.hint.educationQualification,
        // ),
        // EditProfileDateField(
        //   label: t.profile.dob,
        //   initialValue: userProfile?.dateOfBirth,
        //   onChange: (input) {
        //     if (input != null) {
        //       context.read<EditProfileBloc>().add(
        //             EditProfileEvent.birthdayChange(input: input),
        //           );
        //     }
        //   },
        //   placeholder: t.profile.hint.dob,
        // ),
        // EditProfilePickerField(
        //   label: t.profile.gender,
        //   initialValue: getValue(editState.gender, userProfile?.newGender),
        //   onChange: (input) => context.read<EditProfileBloc>().add(
        //         EditProfileEvent.genderSelect(gender: input),
        //       ),
        //   options: LemonGender.values.map((e) => e.newGender).toList(),
        //   placeholder: t.profile.hint.gender,
        // ),
        // EditProfilePickerField(
        //   label: t.profile.ethnicity,
        //   initialValue: getValue(editState.ethnicity, userProfile?.ethnicity),
        //   onChange: (input) => context.read<EditProfileBloc>().add(
        //         EditProfileEvent.ethnicitySelect(ethnicity: input),
        //       ),
        //   options: LemonEthnicity.values.map((e) => e.ethnicity).toList(),
        //   placeholder: t.profile.hint.ethnicity,
        // ),
      ],
    );
  }
}
