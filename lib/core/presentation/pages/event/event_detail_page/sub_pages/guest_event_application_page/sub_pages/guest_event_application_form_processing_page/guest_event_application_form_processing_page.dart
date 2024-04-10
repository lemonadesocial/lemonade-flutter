import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_application_form_bloc/event_application_form_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/profile/user_profile_bloc/user_profile_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/sub_pages/guest_event_application_page/sub_pages/guest_event_application_form_processing_page/view/guest_event_application_form_loading_view.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/sub_pages/guest_event_application_page/sub_pages/guest_event_application_form_processing_page/view/guest_event_application_form_success_view.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class GuestEventApplicationFormProcessingPage extends StatefulWidget {
  const GuestEventApplicationFormProcessingPage({super.key});

  @override
  State<GuestEventApplicationFormProcessingPage> createState() =>
      _GuestEventApplicationFormProcessingPageState();
}

class _GuestEventApplicationFormProcessingPageState
    extends State<GuestEventApplicationFormProcessingPage> {
  late Future<void> _mutationFuture;

  @override
  void initState() {
    super.initState();
    _mutationFuture = _runMutation();
  }

  Future<void> _runMutation() async {
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event,
          orElse: () => Event(),
        );

    final profileFields =
        context.read<EventApplicationFormBloc>().state.fieldsState;
    final answers = context.read<EventApplicationFormBloc>().state.answers;

    final updateUserResult = await getIt<UserRepository>().updateUser(
      input: Input$UserInput.fromJson(profileFields),
    );
    if (updateUserResult.isLeft()) {
      AutoRouter.of(context).replace(const GuestEventApplicationFormRoute());
      return;
    }
    final submitAnswersResult =
        await getIt<EventRepository>().submitEventApplicationAnswers(
      answers: answers,
      eventId: event.id ?? '',
    );
    if (submitAnswersResult.isLeft()) {
      AutoRouter.of(context).pop();
      return;
    }
    // Refresh event detail
    context.read<GetEventDetailBloc>().add(
          GetEventDetailEvent.fetch(
            eventId: event.id ?? '',
          ),
        );
    final userId = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => '',
          authenticated: (session) => session.userId,
        );
    UserProfileBloc(getIt<UserRepository>()).add(
      UserProfileEvent.fetch(userId: userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: Spacing.smMedium),
          child: FutureBuilder(
            future: _mutationFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const GuestEventApplicationFormLoadingView();
              } else {
                return const GuestEventApplicationFormSuccessView();
              }
            },
          ),
        ),
      ),
    );
  }
}
