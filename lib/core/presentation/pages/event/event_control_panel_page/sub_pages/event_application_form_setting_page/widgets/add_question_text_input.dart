import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class AddQuestionTextInput extends StatelessWidget {
  const AddQuestionTextInput({
    super.key,
    required this.onChange,
    this.initialValue,
  });

  final Function(String) onChange;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.event.applicationForm.question,
          style: Typo.medium.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        LemonTextField(
          hintText: t.event.applicationForm.enterQuestion,
          onChange: onChange,
          radius: LemonRadius.medium,
          fillColor: LemonColor.chineseBlack,
          filled: true,
          initialText: initialValue,
        ),
      ],
    );
  }
}
