import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/common/dropdown/frosted_glass_drop_down_v2.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/utils/calendar_utils.dart';
import 'package:app/core/utils/text_formatter/date_text_formatter.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileFieldItem extends StatelessWidget {
  const EditProfileFieldItem({
    super.key,
    required this.profileFieldKey,
    required this.userProfile,
    required this.onChange,
    this.onDateSelect,
    this.selectedValue,
    this.controller,
  });

  final User userProfile;
  final ProfileFieldKey profileFieldKey;
  final ValueChanged<String> onChange;
  final ValueChanged<DateTime>? onDateSelect;
  final String? selectedValue;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    switch (profileFieldKey) {
      case ProfileFieldKey.displayName:
        return LemonTextField(
          label: t.onboarding.displayName,
          hintText: t.profile.hint.displayName,
          initialText: userProfile.displayName ?? '',
          onChange: onChange,
        );
      case ProfileFieldKey.tagline:
        return LemonTextField(
          label: t.profile.tagline,
          hintText: t.profile.hint.tagline,
          initialText: userProfile.tagline ?? '',
          onChange: onChange,
          minLines: 2,
        );
      case ProfileFieldKey.description:
        return LemonTextField(
          label: t.onboarding.shortBio,
          hintText: t.profile.hint.shortBio,
          initialText: userProfile.description ?? '',
          onChange: onChange,
          minLines: 4,
        );
      case ProfileFieldKey.jobTitle:
        return LemonTextField(
          label: t.profile.jobTitle,
          hintText: t.profile.hint.jobTitle,
          initialText: userProfile.jobTitle ?? '',
          onChange: onChange,
        );
      case ProfileFieldKey.companyName:
        return LemonTextField(
          label: t.profile.organization,
          hintText: t.profile.hint.organization,
          initialText: userProfile.companyName ?? '',
          onChange: onChange,
        );
      case ProfileFieldKey.educationTitle:
        return LemonTextField(
          label: t.profile.educationQualification,
          hintText: t.profile.hint.educationQualification,
          initialText: userProfile.education ?? '',
          onChange: onChange,
        );

      case ProfileFieldKey.newGender:
        return FrostedGlassDropDownV2(
          label: t.profile.gender,
          hintText: t.profile.hint.gender,
          listItem: LemonGender.values.map((e) => e.newGender).toList(),
          onValueChange: (value) {
            if (value != null) {
              onChange(value);
            }
          },
          selectedValue: selectedValue,
        );

      case ProfileFieldKey.ethnicity:
        return FrostedGlassDropDownV2(
          label: t.profile.ethnicity,
          hintText: t.profile.hint.ethnicity,
          listItem: LemonEthnicity.values.map((e) => e.ethnicity).toList(),
          onValueChange: (value) {
            if (value != null) {
              onChange(value);
            }
          },
          selectedValue: selectedValue,
        );
      case ProfileFieldKey.dateOfBirth:
        return LemonTextField(
          label: t.profile.dob,
          onChange: onChange,
          controller: controller,
          hintText: t.profile.hint.dob,
          inputFormatters: [
            CustomDateTextFormatter(),
            LengthLimitingTextInputFormatter(10),
          ],
          suffixIcon: InkWell(
            onTap: () => showCalendar(
              context,
              onDateSelect: (selectedDate) {
                if (onDateSelect != null) {
                  onDateSelect!(selectedDate);
                }
              },
            ),
            child: Container(
              width: 36.w,
              height: 36.w,
              margin: EdgeInsets.only(right: Spacing.xSmall),
              padding: EdgeInsets.all(9.w),
              decoration: BoxDecoration(
                color: colorScheme.onPrimary.withOpacity(0.09),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: LemonColor.shadow5b,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Assets.icons.icCalendar.svg(),
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
