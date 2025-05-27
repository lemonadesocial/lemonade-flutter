import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_form_fields/edit_profile_text_field.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_form_fields/edit_profile_picker_field.dart';
import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_form_fields/edit_profile_date_field.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/cupertino.dart';

class EditProfilePersonalInfoForm extends StatelessWidget {
  const EditProfilePersonalInfoForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return CupertinoListSection.insetGrouped(
      header: Text(
        "Personal Details",
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
          label: "Job Title",
          onChange: (input) {},
          maxLines: 1,
        ),
        EditProfileTextField(
          label: "Organization",
          onChange: (input) {},
          maxLines: 1,
        ),
        EditProfilePickerField(
          label: "Industry",
          onChange: (input) {},
          options: LemonIndustry.values.map((e) => e.industry).toList(),
        ),
        EditProfileTextField(
          label: "Education",
          onChange: (input) {},
          maxLines: 1,
        ),
        EditProfileDateField(
          label: "Date of Birth",
          onChange: (input) {},
          initialValue: DateTime.now(),
        ),
        EditProfilePickerField(
          label: "Gender",
          onChange: (input) {},
          options: LemonGender.values.map((e) => e.newGender).toList(),
        ),
        EditProfilePickerField(
          label: "Ethnicity",
          onChange: (input) {},
          options: LemonEthnicity.values.map((e) => e.ethnicity).toList(),
        ),
      ],
    );
  }
}
