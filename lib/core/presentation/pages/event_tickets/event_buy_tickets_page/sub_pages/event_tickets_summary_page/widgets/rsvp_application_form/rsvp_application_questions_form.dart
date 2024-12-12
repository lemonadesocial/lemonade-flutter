import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_application_form_bloc/event_application_form_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/domain/event/entities/event_application_question.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/rsvp_application_form/widgets/rsvp_application_multi_options_question.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/rsvp_application_form/widgets/rsvp_application_single_option_question.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/rsvp_application_form/widgets/rsvp_application_text_question.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class RSVPApplicationQuestionsForm extends StatelessWidget {
  const RSVPApplicationQuestionsForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventProviderBloc>().event;
    User? user = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (user) => user,
          orElse: () => null,
        );
    List<EventApplicationQuestion> applicationQuestions =
        (event.applicationQuestions ?? []).toList();
    if (user == null) {
      return const SizedBox();
    }
    return BlocBuilder<EventApplicationFormBloc, EventApplicationFormBlocState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: applicationQuestions.map((applicationQuestion) {
            final answerInput = state.answers.firstWhereOrNull(
              (answer) => answer.question == applicationQuestion.id,
            );
            if (applicationQuestion.type == Enum$QuestionType.text) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RsvpApplicationTextQuestion(
                    question: applicationQuestion,
                    answerInput: answerInput,
                    onChange: (value) {
                      context.read<EventApplicationFormBloc>().add(
                            EventApplicationFormBlocEvent.updateAnswer(
                              event: event,
                              questionId: applicationQuestion.id ?? '',
                              answer: value,
                            ),
                          );
                    },
                  ),
                  SizedBox(
                    height: Spacing.small,
                  ),
                ],
              );
            }

            if (applicationQuestion.type == Enum$QuestionType.options) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (applicationQuestion.selectType == Enum$SelectType.single)
                    RsvpApplicationSingleOptionQuestion(
                      question: applicationQuestion,
                      answerInput: answerInput,
                      onChange: (value) {
                        context.read<EventApplicationFormBloc>().add(
                              EventApplicationFormBlocEvent.updateAnswer(
                                event: event,
                                questionId: applicationQuestion.id ?? '',
                                answers: [value],
                              ),
                            );
                      },
                    ),
                  if (applicationQuestion.selectType == Enum$SelectType.multi)
                    RsvpApplicationMultiOptionsQuestion(
                      question: applicationQuestion,
                      answerInput: answerInput,
                      onChange: (value) {
                        context.read<EventApplicationFormBloc>().add(
                              EventApplicationFormBlocEvent.updateAnswer(
                                event: event,
                                questionId: applicationQuestion.id ?? '',
                                answers: value,
                              ),
                            );
                      },
                    ),
                  SizedBox(
                    height: Spacing.small,
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          }).toList(),
        );
      },
    );
  }
}
