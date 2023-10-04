import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    this.label,
    this.suffixIcon,
    this.leadingIcon,
    this.autofocus = false,
    this.inputFormatters,
    this.controller,
    this.contentPadding,
  }) : super(key: key);

  final ValueChanged<String> onChange;
  final String? initialText;
  final String? hintText;
  final int minLines;
  final int? maxLines;
  final Color? borderColor;
  final Widget? statusWidget;
  final String? label;
  final Widget? suffixIcon;
  final Widget? leadingIcon;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final EdgeInsets? contentPadding;

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Typo.small.copyWith(
              color: theme.colorScheme.onPrimary.withOpacity(0.36),
            ),
          ),
          SizedBox(height: Spacing.superExtraSmall),
        ],
        TextFormField(
          controller: controller,
          autofocus: autofocus,
          onChanged: onChange,
          style: theme.textTheme.bodyMedium!
              .copyWith(color: theme.colorScheme.onPrimary),
          minLines: minLines,
          maxLines: maxLines ?? minLines,
          cursorColor: theme.colorScheme.onPrimary,
          initialValue: initialText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium!
                .copyWith(color: theme.colorScheme.outlineVariant),
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: border,
            border: border,
            contentPadding: contentPadding ?? EdgeInsets.all(Spacing.smMedium),
            suffixIcon: suffixIcon,
            prefixIcon: leadingIcon,
          ),
          inputFormatters: inputFormatters,
        ),
        if (statusWidget != null) ...[
          SizedBox(height: Spacing.xSmall),
          statusWidget!,
        ]
      ],
    );
  }
}
