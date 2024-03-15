import 'package:app/core/application/event/event_application_form_bloc/event_application_form_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/profile/user_profile_bloc/user_profile_bloc.dart';
import 'package:app/core/domain/event/entities/event_application_question.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestEventApplicationFormAnswersItems extends StatelessWidget {
  const GuestEventApplicationFormAnswersItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventProviderBloc>().event;
    User? user = context.watch<UserProfileBloc>().state.maybeWhen(
          fetched: (user) => user,
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
          children: applicationQuestions.map((applicationQuestion) {
            return Column(
              children: [
                LemonTextField(
                  label: applicationQuestion.question,
                  hintText: '',
                  initialText: '',
                  onChange: (value) {
                    context.read<EventApplicationFormBloc>().add(
                          EventApplicationFormBlocEvent.updateAnswer(
                            questionId: applicationQuestion.id ?? '',
                            answer: value,
                          ),
                        );
                  },
                  showRequired: applicationQuestion.required,
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
