import 'package:app/theme/spacing.dart';
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
    this.borderColor,
    this.statusWidget,
  }) : super(key: key);

  final ValueChanged<String> onChange;
  final String? initialText;
  final String? hintText;
  final int minLines;
  final int? maxLines;
  final Color? borderColor;
  final Widget? statusWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final border = OutlineInputBorder(
      borderSide:
          BorderSide(color: borderColor ?? theme.colorScheme.outlineVariant),
      borderRadius: BorderRadius.circular(12.r),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          onChanged: onChange,
          style: theme.textTheme.bodyMedium!
              .copyWith(color: theme.colorScheme.onPrimary),
          minLines: minLines,
          maxLines: maxLines ?? minLines,
          cursorColor: theme.colorScheme.onPrimary,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium!
                .copyWith(color: theme.colorScheme.outlineVariant),
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: border,
            border: border,
          ),
        ),
        Visibility(
          visible: statusWidget != null,
          child: SizedBox(height: Spacing.xSmall),
        ),
        Visibility(
          visible: statusWidget != null,
          child: statusWidget ?? const SizedBox.shrink(),
        ),
      ],
    );
  }
}
