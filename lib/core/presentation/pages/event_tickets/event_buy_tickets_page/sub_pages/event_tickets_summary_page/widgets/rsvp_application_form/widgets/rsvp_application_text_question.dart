import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/event/entities/event_application_question.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);
    return LemonTextField(
      inputHeight: 53.w,
      filled: true,
      fillColor: appColors.cardBg,
      borderColor: appColors.pageDivider,
      label: question.question,
      labelStyle: appText.md,
      hintText: t.common.hint.enterYourAnswer,
      initialText: answerInput?.answer ?? '',
      onChange: onChange,
      showRequired: question.isRequired,
    );
  }
}
