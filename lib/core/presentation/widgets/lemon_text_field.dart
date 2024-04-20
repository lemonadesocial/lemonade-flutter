import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LemonTextField extends StatelessWidget {
  const LemonTextField({
    super.key,
    this.onChange,
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
    this.textInputType,
    this.focusNode,
    this.errorText,
    this.readOnly,
    this.onTap,
    this.showRequired,
    this.filled,
    this.fillColor,
    this.radius = 12.0,
  });

  final ValueChanged<String>? onChange;
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
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  final String? errorText;
  final bool? readOnly;
  final Function()? onTap;
  final bool? showRequired;
  final bool? filled;
  final Color? fillColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final border = OutlineInputBorder(
      borderSide:
          BorderSide(color: borderColor ?? theme.colorScheme.outlineVariant),
      borderRadius: BorderRadius.circular(radius),
    );
    final errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: LemonColor.errorRedBg),
      borderRadius: BorderRadius.circular(radius),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showRequired == true) ...[
                Text(
                  "*",
                  style: Typo.mediumPlus.copyWith(
                    color: LemonColor.coralReef,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: Spacing.superExtraSmall,
                ),
              ],
              Expanded(
                child: Text(
                  label ?? '',
                  style: Typo.small.copyWith(
                    color: theme.colorScheme.onPrimary.withOpacity(0.36),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Spacing.superExtraSmall),
        ],
        TextFormField(
          onTap: onTap,
          controller: controller,
          autofocus: autofocus,
          onChanged: onChange,
          focusNode: focusNode,
          style: theme.textTheme.bodyMedium!
              .copyWith(color: theme.colorScheme.onPrimary),
          minLines: minLines,
          maxLines: maxLines ?? minLines,
          cursorColor: theme.colorScheme.onPrimary,
          initialValue: initialText,
          keyboardType: textInputType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium!
                .copyWith(color: theme.colorScheme.outlineVariant),
            errorText: errorText,
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: errorBorder,
            border: border,
            contentPadding: contentPadding ?? EdgeInsets.all(Spacing.smMedium),
            suffixIcon: suffixIcon,
            prefixIcon: leadingIcon,
            filled: filled ?? false,
            fillColor: fillColor ?? Colors.transparent,
          ),
          inputFormatters: inputFormatters,
          readOnly: readOnly ?? false,
        ),
        if (statusWidget != null) ...[
          SizedBox(height: Spacing.xSmall),
          statusWidget!,
        ],
      ],
    );
  }
}
