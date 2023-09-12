import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class ProfileTextFieldWidget extends StatelessWidget {
  const ProfileTextFieldWidget({
    Key? key,
    required this.label,
    required this.onChange,
    this.hintText,
  }) : super(key: key);

  final String label;
  final ValueChanged<String> onChange;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Spacing.medium),
        Text(
          label,
          style: Typo.small.copyWith(
            color: colorScheme.onPrimary.withOpacity(0.36),
          ),
        ),
        SizedBox(height: Spacing.superExtraSmall),
        LemonTextField(
          onChange: onChange,
          hintText: hintText,
        ),
      ],
    );
  }
}
