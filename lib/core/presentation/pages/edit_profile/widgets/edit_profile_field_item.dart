import 'package:app/core/domain/common/common_enums.dart';
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
    required this.onChange,
    this.onDateSelect,
    this.controller,
    this.showRequired,
    required this.value,
    this.backgroundColor,
    this.labelStyle,
    this.borderColor,
  });

  // final User userProfile;
  final ProfileFieldKey profileFieldKey;
  final ValueChanged<String> onChange;
  final ValueChanged<DateTime>? onDateSelect;
  final TextEditingController? controller;
  final bool? showRequired;
  final String? value;
  final Color? backgroundColor;
  final TextStyle? labelStyle;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final border = Border.all(
      color: borderColor ?? colorScheme.outline,
    );
    switch (profileFieldKey) {
      //
      // Dropdown
      //
      case ProfileFieldKey.pronoun:
        // Handle for wrong pronoun existing data
        final newValue = value!.isNotEmpty
            ? value![0].toUpperCase() + value!.substring(1)
            : "";
        return FrostedGlassDropDownV2(
          label: t.profile.pronoun,
          labelStyle: labelStyle,
          hintText: t.profile.pronoun,
          listItem: LemonPronoun.values.map((e) => e.pronoun).toList(),
          onValueChange: (value) {
            if (value != null) {
              onChange(value);
            }
          },
          selectedValue: value == '' ? null : newValue,
          showRequired: showRequired,
          backgroundColor: backgroundColor,
          border: border,
          offset: Offset(0, -Spacing.superExtraSmall),
        );
      case ProfileFieldKey.industry:
        return FrostedGlassDropDownV2(
          label: t.profile.industry,
          labelStyle: labelStyle,
          hintText: t.profile.hint.industry,
          listItem: LemonIndustry.values.map((e) => e.industry).toList(),
          onValueChange: (value) {
            if (value != null) {
              onChange(value);
            }
          },
          selectedValue: value == '' ? null : value,
          showRequired: showRequired,
          backgroundColor: backgroundColor,
          border: border,
          offset: Offset(0, -Spacing.superExtraSmall),
        );
      case ProfileFieldKey.newGender:
        return FrostedGlassDropDownV2(
          label: t.profile.gender,
          labelStyle: labelStyle,
          hintText: t.profile.hint.gender,
          listItem: LemonGender.values.map((e) => e.newGender).toList(),
          onValueChange: (value) {
            if (value != null) {
              onChange(value);
            }
          },
          selectedValue: value == '' ? null : value,
          showRequired: showRequired,
          backgroundColor: backgroundColor,
          border: border,
          offset: Offset(0, -Spacing.superExtraSmall),
        );
      case ProfileFieldKey.ethnicity:
        return FrostedGlassDropDownV2(
          label: t.profile.ethnicity,
          labelStyle: labelStyle,
          hintText: t.profile.hint.ethnicity,
          listItem: LemonEthnicity.values.map((e) => e.ethnicity).toList(),
          onValueChange: (value) {
            if (value != null) {
              onChange(value);
            }
          },
          selectedValue: value == '' ? null : value,
          showRequired: showRequired,
          backgroundColor: backgroundColor,
          border: border,
          offset: const Offset(0, 0),
        );
      //
      // DateTimePicker mode
      //
      case ProfileFieldKey.dateOfBirth:
        return LemonTextField(
          inputHeight: 53.w,
          label: t.profile.dob,
          labelStyle: labelStyle,
          onChange: onChange,
          controller: controller,
          hintText: t.profile.hint.dob,
          showRequired: showRequired,
          fillColor: backgroundColor,
          filled: backgroundColor != null,
          borderColor: borderColor,
          inputFormatters: [
            CustomDateTextFormatter(),
            LengthLimitingTextInputFormatter(10),
          ],
          suffixIcon: InkWell(
            onTap: () => showCalendar(
              context,
              onDateSelect: (selectedDate) {
                if (onDateSelect != null) {
                  onDateSelect!(
                    DateTime.parse(
                      selectedDate.toUtc().toIso8601String(),
                    ),
                  );
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
        return LemonTextField(
          inputHeight: 53.w,
          label: profileFieldKey.label,
          labelStyle: labelStyle,
          hintText: t.common.hint.enterYourAnswer,
          initialText: value,
          onChange: onChange,
          showRequired: showRequired,
          fillColor: backgroundColor,
          filled: backgroundColor != null,
          borderColor: borderColor,
        );
    }
  }
}
