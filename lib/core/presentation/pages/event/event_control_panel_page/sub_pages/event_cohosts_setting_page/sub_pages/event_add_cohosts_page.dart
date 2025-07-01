import 'package:app/core/application/event/get_event_cohost_requests_bloc/get_event_cohost_requests_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/manage_event_cohost_requests_bloc/manage_event_cohost_requests_bloc.dart';
import 'package:app/core/application/user/get_users_bloc/get_users_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_cohosts_setting_page/widgets/event_add_cohost_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

@RoutePage()
class EventAddCohostsPage extends StatelessWidget {
  const EventAddCohostsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          fetched: (eventDetail) => eventDetail,
          orElse: () => null,
        );
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
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        backgroundColor: appColors.pageBg,
        title: t.event.cohosts.addCohosts,
      ),
      backgroundColor: appColors.pageBg,
      resizeToAvoidBottomInset: true,
      body: BlocListener<ManageEventCohostRequestsBloc,
          ManageEventCohostRequestsState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () => null,
            success: () {
              AutoRouter.of(context).back();
              context.read<GetUsersBloc>().add(GetUsersEvent.reset());
              context.read<GetEventCohostRequestsBloc>().add(
                    GetEventCohostRequestsEvent.fetch(
                      eventId: widget.event?.id ?? '',
                    ),
                  );
            },
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.small,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LemonTextField(
                controller: searchController,
                leadingIcon: ThemeSvgIcon(
                  color: appColors.textTertiary,
                  builder: (filter) => Assets.icons.icSearch.svg(
                    colorFilter: filter,
                    width: 18.w,
                    height: 18.w,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                filled: true,
                fillColor: appColors.inputBg,
                borderColor: appColors.inputBorder,
                hintText: t.common.search.capitalize(),
                placeholderStyle: Typo.medium.copyWith(
                  color: appColors.textTertiary,
                ),
                contentPadding: EdgeInsets.all(Spacing.small),
                onChange: (value) {
                  if (value.isEmpty) {
                    context.read<GetUsersBloc>().add(
                          GetUsersEvent.reset(),
                        );
                    return;
                  }
                  context.read<GetUsersBloc>().add(
                        GetUsersEvent.fetch(
                          limit: 5,
                          skip: 0,
                          search: value,
                        ),
                      );
                },
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
                        if (users.isEmpty) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              EmptyList(
                                emptyText: searchController.text.isEmpty
                                    ? t.event.eventCohost
                                        .searchCoHostsDescription
                                    : t.event.eventCohost.noCohostsDescription,
                              ),
                            ],
                          );
                        }
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
              // Button
              BlocBuilder<ManageEventCohostRequestsBloc,
                  ManageEventCohostRequestsState>(
                builder: (context, state) {
                  final loading = state.maybeWhen(
                    success: () => false,
                    loading: () => true,
                    orElse: () => false,
                  );
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      child: LinearGradientButton.primaryButton(
                        label: t.event.eventCohost.sendInvites,
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
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
