import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LemonTextField extends StatelessWidget {
  const LemonTextField({
    Key? key,
    required this.onChange,
    this.initialText,
    this.hintText,
    this.minLines = 1,
    this.maxLines,
  }) : super(key: key);

  final ValueChanged<String> onChange;
  final String? initialText;
  final String? hintText;
  final int minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
      borderRadius: BorderRadius.circular(12.r),
    );
    return TextField(
      onChanged: onChange,
      style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.onPrimary),
      minLines: minLines,
      maxLines: maxLines ?? minLines,
      cursorColor: theme.colorScheme.onPrimary,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.outlineVariant),
        enabledBorder: border,
        focusedBorder: border,
        border: border,
      ),
    );
  }
}
