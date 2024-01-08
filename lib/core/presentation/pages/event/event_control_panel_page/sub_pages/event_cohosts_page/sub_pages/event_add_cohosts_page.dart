import 'package:app/core/application/event/event_detail_cohosts_bloc/event_detail_cohosts_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event/manage_event_cohost_requests_bloc/manage_event_cohost_requests_bloc.dart';
import 'package:app/core/application/user/get_users_bloc/get_users_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_cohosts_page/widgets/event_add_cohost_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:slang/builder/utils/string_extensions.dart';

@RoutePage()
class EventAddCohostsPage extends StatelessWidget {
  const EventAddCohostsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventProviderBloc>().event;
    return EventAddCohostsView(event: event);
  }
}

class EventAddCohostsView extends StatefulWidget {
  const EventAddCohostsView({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  State<EventAddCohostsView> createState() => _EventAddCohostsViewState();
}

class _EventAddCohostsViewState extends State<EventAddCohostsView> {
  List<String> selectedUserIds = [];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        backgroundColor: colorScheme.onPrimaryContainer,
        title: t.event.cohosts.addCohosts,
      ),
      backgroundColor: colorScheme.onPrimaryContainer,
      resizeToAvoidBottomInset: true,
      body: BlocListener<ManageEventCohostRequestsBloc,
          ManageEventCohostRequestsState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () => null,
            success: () {
              AutoRouter.of(context).back();
              context.read<GetUsersBloc>().add(GetUsersEvent.reset());
              context.read<EventDetailCohostsBloc>().add(
                    EventDetailCohostsEvent.fetch(
                      eventId: widget.event?.id ?? '',
                    ),
                  );
            },
          );
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
                      loading: () => Loading.defaultLoading(context),
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
              _buildAddCohostsButton(),
            ],
          ),
        ),
      ),
    );
  }

  _buildAddCohostsButton() {
    return BlocBuilder<ManageEventCohostRequestsBloc,
        ManageEventCohostRequestsState>(
      builder: (context, state) {
        final loading = state.maybeWhen(
          success: () => false,
          loading: () => true,
          orElse: () => false,
        );
        return LinearGradientButton(
          label: t.common.saveChanges,
          height: 48.h,
          radius: BorderRadius.circular(24),
          textStyle: Typo.medium.copyWith(),
          mode: GradientButtonMode.lavenderMode,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            Vibrate.feedback(FeedbackType.light);
            context.read<ManageEventCohostRequestsBloc>().add(
                  ManageEventCohostRequestsEvent.saveChanged(
                    eventId: widget.event?.id ?? '',
                    users: selectedUserIds,
                    decision: true,
                  ),
                );
          },
          loadingWhen: loading,
        );
      },
    );
  }
}
