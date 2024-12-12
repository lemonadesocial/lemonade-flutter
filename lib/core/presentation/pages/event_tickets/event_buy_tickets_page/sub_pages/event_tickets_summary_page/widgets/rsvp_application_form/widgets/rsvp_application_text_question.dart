import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/event/entities/event_application_question.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';

class RsvpApplicationTextQuestion extends StatelessWidget {
  final EventApplicationQuestion question;
  final Input$EventApplicationAnswerInput? answerInput;
  final Function(String) onChange;

  const RsvpApplicationTextQuestion({
    super.key,
    required this.question,
    required this.answerInput,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LemonTextField(
      filled: true,
      fillColor: LemonColor.atomicBlack,
      borderColor: colorScheme.outlineVariant,
      label: question.question,
      labelStyle: Typo.medium.copyWith(
        color: colorScheme.onPrimary,
        fontWeight: FontWeight.w500,
      ),
      hintText: '',
      initialText: answerInput?.answer ?? '',
      onChange: onChange,
      showRequired: question.isRequired,
    );
  }
}
