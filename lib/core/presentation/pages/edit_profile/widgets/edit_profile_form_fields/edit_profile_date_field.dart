import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_form_fields/edit_profile_form_row_prefix.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EditProfileDateField extends StatefulWidget {
  const EditProfileDateField({
    super.key,
    required this.label,
    required this.onChange,
    this.icon,
    this.initialValue,
    this.validator,
    this.placeholder,
  });

  final SvgGenImage? icon;
  final String label;
  final Function(DateTime?) onChange;
  final DateTime? initialValue;
  final String? Function(String?)? validator;
  final String? placeholder;

  @override
  State<EditProfileDateField> createState() => _EditProfileDateFieldState();
}

class _EditProfileDateFieldState extends State<EditProfileDateField> {
  DateTime? _tempValue;
  final TextEditingController _controller = TextEditingController();
  final String datePattern = "dd/MM/yyyy";

  @override
  void initState() {
    super.initState();
    _controller.text =
        DateFormatUtils.custom(widget.initialValue, pattern: datePattern);
  }

  void showPicker(
    BuildContext context,
  ) async {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);
    await showCupertinoModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CalendarDatePicker2(
              config: CalendarDatePicker2WithActionButtonsConfig(
                firstDayOfWeek: 1,
                calendarType: CalendarDatePicker2Type.single,
                selectedDayTextStyle: appText.md,
                selectedDayHighlightColor: appColors.textAccent,
                todayTextStyle: appText.md,
                okButtonTextStyle: appText.md,
                cancelButtonTextStyle: appText.md.copyWith(
                  color: appColors.textTertiary,
                ),
                dayTextStyle: appText.sm,
              ),
              value: [widget.initialValue],
              onValueChanged: (value) {
                _tempValue = value.firstOrNull;
              },
            ),
            SafeArea(
              child: LinearGradientButton.primaryButton(
                label: t.common.actions.ok,
                onTap: () {
                  if (_tempValue != null) {
                    _controller.text = DateFormatUtils.custom(_tempValue,
                        pattern: datePattern);
                    widget.onChange(_tempValue);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;

    return CupertinoFormRow(
      prefix: EditProfileFormRowPrefix(
        icon: widget.icon,
        label: widget.label,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CupertinoTextFormFieldRow(
              controller: _controller,
              padding: EdgeInsets.zero,
              style: appText.sm,
              placeholder: widget.placeholder,
              placeholderStyle: appText.md.copyWith(
                color: appColors.textQuaternary,
              ),
              onTap: () {
                showPicker(context);
              },
              readOnly: true,
              cursorColor: appColors.textPrimary,
              validator: widget.validator,
            ),
          ),
          InkWell(
            onTap: () {
              showPicker(context);
            },
            child: ThemeSvgIcon(
              color: appColors.textQuaternary,
              builder: (filter) => Assets.icons.icCalendarTodayOutline.svg(
                colorFilter: filter,
                width: Sizing.s5,
                height: Sizing.s5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
