import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/user/get_users_bloc/get_users_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_cohosts_setting_page/widgets/event_add_cohost_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

@RoutePage()
class EventAddSpeakersPage extends StatelessWidget {
  const EventAddSpeakersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          fetched: (eventDetail) => eventDetail,
          orElse: () => null,
        );
    return EventAddSpeakersView(event: event);
  }
}

class EventAddSpeakersView extends StatefulWidget {
  const EventAddSpeakersView({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  State<EventAddSpeakersView> createState() => _EventAddSpeakersViewState();
}

class _EventAddSpeakersViewState extends State<EventAddSpeakersView> {
  List<String> selectedUserIds = [];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        backgroundColor: colorScheme.background,
        title: t.event.speakers.addSpeakers,
      ),
      backgroundColor: colorScheme.background,
      resizeToAvoidBottomInset: true,
      body: BlocListener<EditEventDetailBloc, EditEventDetailState>(
        listener: (context, state) {
          if (state.status == EditEventDetailBlocStatus.success) {
            AutoRouter.of(context).back();
            context.read<GetUsersBloc>().add(GetUsersEvent.reset());
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
              LemonTextField(
                leadingIcon: ThemeSvgIcon(
                  color: colorScheme.onSurfaceVariant,
                  builder: (filter) => Assets.icons.icSearch.svg(
                    colorFilter: filter,
                    width: 18.w,
                    height: 18.w,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                hintText: t.common.search.capitalize(),
                contentPadding: EdgeInsets.all(Spacing.small),
                onChange: (value) => context.read<GetUsersBloc>().add(
                      GetUsersEvent.fetch(
                        limit: 5,
                        skip: 0,
                        search: value,
                      ),
                    ),
              ),
              SizedBox(
                height: Spacing.medium,
              ),
              Expanded(
                child: BlocBuilder<GetUsersBloc, GetUsersState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      success: (users) {
                        return ListView.separated(
                          padding: EdgeInsets.only(bottom: Spacing.medium),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            String userId = users[index].userId;
                            final selected =
                                selectedUserIds.contains(userId) == true;
                            return EventAddCohostItem(
                              user: users[index],
                              selected: selected,
                              onPressItem: () {
                                final userId = users[index].userId;
                                setState(() {
                                  if (!selectedUserIds.contains(userId)) {
                                    selectedUserIds = [
                                      ...selectedUserIds,
                                      userId,
                                    ];
                                  } else {
                                    selectedUserIds = selectedUserIds
                                        .where((id) => id != userId)
                                        .toList();
                                  }
                                });
                              },
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: Spacing.small,
                          ),
                          itemCount: users.length,
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ),
              _buildAddSpeakersButton(),
            ],
          ),
        ),
      ),
    );
  }

  _buildAddSpeakersButton() {
    return BlocBuilder<EditEventDetailBloc, EditEventDetailState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: LinearGradientButton(
              label: t.common.actions.saveChanges,
              height: 48.h,
              radius: BorderRadius.circular(24),
              textStyle: Typo.medium.copyWith(),
              mode: GradientButtonMode.lavenderMode,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                List<User?> speakerUsers =
                    context.read<GetEventDetailBloc>().state.maybeWhen(
                          fetched: (eventDetail) =>
                              eventDetail.speakerUsersExpanded ?? [],
                          orElse: () => [],
                        );
                List<String> speakerUsersIds =
                    speakerUsers.map((user) => user!.userId).toList();
                // Included old speakers and with new selected speakers
                List<String> newSpeakerUsers =
                    (speakerUsersIds + selectedUserIds).toSet().toList();
                Vibrate.feedback(FeedbackType.light);
                context.read<EditEventDetailBloc>().add(
                      EditEventDetailEvent.update(
                        eventId: widget.event?.id ?? '',
                        speakerUsers: newSpeakerUsers,
                      ),
                    );
              },
              loadingWhen: state.status == EditEventDetailBlocStatus.loading,
            ),
          ),
        );
      },
    );
  }
}
