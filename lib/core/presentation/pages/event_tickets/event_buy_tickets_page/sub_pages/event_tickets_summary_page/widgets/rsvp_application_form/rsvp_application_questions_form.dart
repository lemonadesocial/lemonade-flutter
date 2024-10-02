import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_application_form_bloc/event_application_form_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/domain/event/entities/event_application_question.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
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
        final colorScheme = Theme.of(context).colorScheme;
        return Column(
          children: applicationQuestions.map((applicationQuestion) {
            return Column(
              children: [
                LemonTextField(
                  filled: true,
                  fillColor: LemonColor.atomicBlack,
                  label: applicationQuestion.question,
                  labelStyle: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  hintText: '',
                  initialText: state.answers
                          .firstWhereOrNull(
                            (answer) =>
                                answer.question == applicationQuestion.id,
                          )
                          ?.answer ??
                      '',
                  onChange: (value) {
                    context.read<EventApplicationFormBloc>().add(
                          EventApplicationFormBlocEvent.updateAnswer(
                            event: event,
                            questionId: applicationQuestion.id ?? '',
                            answer: value,
                          ),
                        );
                  },
                  showRequired: applicationQuestion.isRequired,
                ),
                SizedBox(
                  height: Spacing.smMedium,
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
