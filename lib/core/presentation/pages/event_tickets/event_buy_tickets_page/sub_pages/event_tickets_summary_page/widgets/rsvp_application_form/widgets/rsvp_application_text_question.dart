import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/event/entities/event_application_question.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final t = Translations.of(context);
    return LemonTextField(
      inputHeight: 53.w,
      filled: true,
      fillColor: LemonColor.atomicBlack,
      borderColor: colorScheme.outlineVariant,
      label: question.question,
      labelStyle: Typo.medium.copyWith(
        color: colorScheme.onPrimary,
        fontWeight: FontWeight.w500,
      ),
      hintText: t.common.hint.enterYourAnswer,
      initialText: answerInput?.answer ?? '',
      onChange: onChange,
      showRequired: question.isRequired,
    );
  }
}
