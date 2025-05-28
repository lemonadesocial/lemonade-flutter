import 'package:app/core/presentation/pages/edit_profile/widgets/edit_profile_form_fields/edit_profile_form_row_prefix.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/app_theme/app_theme.dart';

class EditProfileTextField extends StatefulWidget {
  const EditProfileTextField({
    super.key,
    this.icon,
    required this.label,
    required this.onChange,
    this.initialValue,
    this.validator,
    this.placeholder,
    this.maxLines,
  });

  final SvgGenImage? icon;
  final String label;
  final Function(String) onChange;
  final String? initialValue;
  final String? Function(String?)? validator;
  final String? placeholder;
  final int? maxLines;

  @override
  State<EditProfileTextField> createState() => _EditProfileTextFieldState();
}

class _EditProfileTextFieldState extends State<EditProfileTextField> {
  @override
  Widget build(BuildContext context) {
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;

    return CupertinoFormRow(
      prefix: EditProfileFormRowPrefix(
        icon: widget.icon,
        label: widget.label,
      ),
      child: CupertinoTextFormFieldRow(
        maxLines: widget.maxLines,
        padding: EdgeInsets.zero,
        style: appText.sm,
        placeholder: widget.placeholder,
        placeholderStyle: appText.md.copyWith(
          color: appColors.textQuaternary,
        ),
        cursorColor: appColors.textPrimary,
        validator: widget.validator,
        initialValue: widget.initialValue,
        onChanged: widget.onChange,
      ),
    );
  }
}
