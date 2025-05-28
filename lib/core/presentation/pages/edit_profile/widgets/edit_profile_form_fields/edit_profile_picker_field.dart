import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_form_fields/edit_profile_form_row_prefix.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EditProfilePickerField extends StatefulWidget {
  const EditProfilePickerField({
    super.key,
    required this.label,
    required this.onChange,
    required this.options,
    this.icon,
    this.initialValue,
    this.validator,
    this.placeholder,
  });

  final SvgGenImage? icon;
  final String label;
  final Function(String?) onChange;
  final String? initialValue;
  final String? Function(String?)? validator;
  final String? placeholder;
  final List<String> options;

  @override
  State<EditProfilePickerField> createState() => _EditProfilePickerFieldState();
}

class _EditProfilePickerFieldState extends State<EditProfilePickerField> {
  String? _tempValue;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
  }

  void showPicker(
    BuildContext context,
  ) async {
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    await showCupertinoModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 350.w,
              child: CupertinoPicker(
                backgroundColor: appColors.pageBg,
                itemExtent: Sizing.s10,
                onSelectedItemChanged: (selectedIndex) {
                  _tempValue = widget.options[selectedIndex];
                },
                children: widget.options
                    .map(
                      (option) => Center(
                        child: Text(
                          option,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            SafeArea(
              child: LinearGradientButton.primaryButton(
                label: t.common.actions.ok,
                onTap: () {
                  widget.onChange(_tempValue);
                  _controller.text = _tempValue ?? '';
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
              builder: (filter) => Assets.icons.icDoubleArrowUpDown.svg(
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
