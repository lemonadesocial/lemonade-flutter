import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_speakers_page/widgets/event_speaker_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

@RoutePage()
class EventSpeakersPage extends StatelessWidget {
  const EventSpeakersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          fetched: (eventDetail) => eventDetail,
          orElse: () => null,
        );
    return EventSpeakersPageView(event: event);
  }
}

class EventSpeakersPageView extends StatefulWidget {
  const EventSpeakersPageView({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  State<EventSpeakersPageView> createState() => _EventSpeakersPageViewState();
}

class _EventSpeakersPageViewState extends State<EventSpeakersPageView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        backgroundColor: colorScheme.onPrimaryContainer,
        title: t.event.configuration.speakers,
      ),
      backgroundColor: colorScheme.onPrimaryContainer,
      resizeToAvoidBottomInset: true,
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    List<User?> speakerUsers =
        context.watch<GetEventDetailBloc>().state.maybeWhen(
              fetched: (eventDetail) => eventDetail.speakerUsersExpanded ?? [],
              orElse: () => [],
            );
    final loadingGetEventDetail =
        context.watch<GetEventDetailBloc>().state.maybeWhen(
              loading: () => true,
              fetched: (eventCohostsRequests) => false,
              failure: () => false,
              orElse: () => false,
            );
    final loadingEditEventDetail =
        context.watch<EditEventDetailBloc>().state.status ==
            EditEventDetailBlocStatus.loading;
    return BlocListener<EditEventDetailBloc, EditEventDetailState>(
      listener: (context, state) {
        if (state.status == EditEventDetailBlocStatus.success) {
          context.read<GetEventDetailBloc>().add(
                GetEventDetailEvent.fetch(
                  eventId: widget.event!.id ?? '',
                ),
              );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.small,
          vertical: Spacing.small,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: loadingEditEventDetail || loadingGetEventDetail
                  ? Loading.defaultLoading(context)
                  : SpeakersList(
                      users: speakerUsers,
                      event: widget.event,
                    ),
            ),
            _buildAddSpeakersButton(),
          ],
        ),
      ),
    );
  }

  _buildAddSpeakersButton() {
    return LinearGradientButton(
      label: t.event.speakers.addSpeakers,
      height: 48.h,
      radius: BorderRadius.circular(24),
      textStyle: Typo.medium.copyWith(),
      mode: GradientButtonMode.lavenderMode,
      onTap: () {
        AutoRouter.of(context).navigate(const EventAddSpeakersRoute());
      },
    );
  }
}

class SpeakersList extends StatelessWidget {
  const SpeakersList({
    super.key,
    required this.users,
    required this.event,
  });

  final List<User?> users;
  final Event? event;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: Spacing.medium),
      shrinkWrap: true,
      itemBuilder: (context, index) => EventSpeakerItem(
        user: users[index],
        onTapRemove: () {
          List<String> newSpeakerUsers = users
              .map((user) => user!.userId)
              .toList()
              .where((speaker) => speaker != users[index]!.userId)
              .toSet()
              .toList();
          Vibrate.feedback(FeedbackType.light);
          context.read<EditEventDetailBloc>().add(
                EditEventDetailEvent.update(
                  eventId: event?.id ?? '',
                  speakerUsers: newSpeakerUsers,
                ),
              );
        },
      ),
      separatorBuilder: (context, index) => SizedBox(
        height: Spacing.small,
      ),
      itemCount: users.length,
    );
  }
}
