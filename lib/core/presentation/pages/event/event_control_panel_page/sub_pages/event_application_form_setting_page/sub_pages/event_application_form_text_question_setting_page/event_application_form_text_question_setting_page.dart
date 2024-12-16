import 'package:app/core/application/event/event_application_form_setting_bloc/event_application_form_setting_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/widgets/add_question_info_widget.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/widgets/add_question_required_switch.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/widgets/add_question_text_input.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class EventApplicationFormTextQuestionSettingPage extends StatefulWidget {
  const EventApplicationFormTextQuestionSettingPage({
    super.key,
    required this.event,
    this.index,
    this.initialQuestion,
  });

  final Event? event;
  final int? index;
  final Input$QuestionInput? initialQuestion;

  @override
  State<EventApplicationFormTextQuestionSettingPage> createState() =>
      _EventApplicationFormTextQuestionSettingPageState();
}

class _EventApplicationFormTextQuestionSettingPageState
    extends State<EventApplicationFormTextQuestionSettingPage> {
  late Input$QuestionInput question;

  @override
  void initState() {
    super.initState();
    setState(() {
      question = widget.initialQuestion ??
          Input$QuestionInput(
            type: Enum$QuestionType.text,
            required: false,
          );
    });
  }

  bool get isValid {
    return question.question?.isNotEmpty ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        title: t.event.applicationForm.addQuestion,
        actions: [
          Opacity(
            opacity: isValid ? 1.0 : 0.5,
            child: LemonOutlineButton(
              radius: BorderRadius.circular(LemonRadius.button),
              backgroundColor: LemonColor.white87,
              textColor: colorScheme.primary,
              onTap: () {
                if (!isValid) return;
                Vibrate.feedback(FeedbackType.light);
                if (widget.index != null) {
                  context.read<EventApplicationFormSettingBloc>().add(
                        EventApplicationFormSettingBlocEvent.updateQuestion(
                          index: widget.index!,
                          question: question,
                        ),
                      );
                } else {
                  context.read<EventApplicationFormSettingBloc>().add(
                        EventApplicationFormSettingBlocEvent.addQuestion(
                          question: question,
                        ),
                      );
                }
                Navigator.pop(context);
              },
              label: t.common.actions.save,
            ),
          ),
          SizedBox(width: Spacing.small),
        ],
        backgroundColor: LemonColor.atomicBlack,
      ),
      backgroundColor: LemonColor.atomicBlack,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AddQuestionInfoWidget(
            title: t.event.applicationForm.questionType.text,
            description: t.event.applicationForm.questionType.textDescription,
            icon: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icInsertTextOutline.svg(
                colorFilter: filter,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.small,
              vertical: Spacing.medium,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddQuestionTextInput(
                  onChange: (value) {
                    setState(() {
                      question = question.copyWith(question: value);
                    });
                  },
                  initialValue: question.question,
                ),
                SizedBox(height: Spacing.xSmall),
                AddQuestionRequiredSwitch(
                  isRequired: question.required ?? false,
                  onChanged: (value) {
                    setState(() {
                      question = question.copyWith(required: value);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
