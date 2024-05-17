import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_spotlight_events/widgets/collaborator_add_sppotlight_events_bottomsheet/select_spotlight_event_list.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorAddSpotlightEventBottomSheet extends StatefulWidget {
  const CollaboratorAddSpotlightEventBottomSheet({super.key});

  @override
  State<CollaboratorAddSpotlightEventBottomSheet> createState() =>
      _CollaboratorAddSpotlightEventBottomSheetState();
}

class _CollaboratorAddSpotlightEventBottomSheetState
    extends State<CollaboratorAddSpotlightEventBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedTabIndex = 0;
  List<String> selectedEventIds = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    final loggedInUser = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    if (loggedInUser != null && loggedInUser.eventsExpanded != null) {
      setState(() {
        selectedEventIds =
            loggedInUser.eventsExpanded!.map((item) => item.id ?? '').toList();
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void onToggleEvent(Event event) {
    final isSelected = selectedEventIds.contains(event.id);
    setState(() {
      if (isSelected == false) {
        selectedEventIds = List.from(selectedEventIds)..add(event.id ?? '');
      } else {
        selectedEventIds = List.from(selectedEventIds)..remove(event.id ?? '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: LemonColor.atomicBlack,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const BottomSheetGrabber(),
              LemonAppBar(
                title: t.event.events,
                backgroundColor: LemonColor.atomicBlack,
              ),
              TabBar(
                onTap: (index) {
                  setState(() {
                    selectedTabIndex = index;
                  });
                },
                controller: _tabController,
                labelStyle: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: Typo.medium.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
                indicatorColor: LemonColor.paleViolet,
                dividerHeight: 1.w,
                dividerColor: colorScheme.outline,
                tabs: [
                  Tab(text: StringUtils.capitalize(t.event.hosting)),
                  Tab(text: StringUtils.capitalize(t.event.attending)),
                  Tab(text: StringUtils.capitalize(t.discover.discover)),
                ],
              ),
              SizedBox(height: Spacing.extraSmall),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SelectSpotlightEventList(
                      futureRequest: getIt<EventRepository>().getHostingEvents(
                        input: GetHostingEventsInput(
                          id: AuthUtils.getUserId(context),
                          limit: 100,
                        ),
                      ),
                      selectedEventIds: selectedEventIds,
                      onToggleEvent: onToggleEvent,
                    ),
                    SelectSpotlightEventList(
                      futureRequest: getIt<EventRepository>().getEvents(
                        input: GetEventsInput(
                          accepted: AuthUtils.getUserId(context),
                          limit: 100,
                        ),
                      ),
                      selectedEventIds: selectedEventIds,
                      onToggleEvent: onToggleEvent,
                    ),
                    SelectSpotlightEventList(
                      futureRequest: getIt<EventRepository>().getEvents(
                        input: const GetEventsInput(
                          limit: 100,
                        ),
                      ),
                      selectedEventIds: selectedEventIds,
                      onToggleEvent: onToggleEvent,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: LemonColor.atomicBlack,
                border: Border(top: BorderSide(color: colorScheme.outline)),
              ),
              padding: EdgeInsets.all(Spacing.smMedium),
              child: SafeArea(
                child: LinearGradientButton.primaryButton(
                  label: t.collaborator.editProfile.addToSpotlight,
                  onTap: () async {
                    await showFutureLoadingDialog(
                      context: context,
                      future: () {
                        return getIt<UserRepository>().updateUser(
                          input: Input$UserInput(events: selectedEventIds),
                        );
                      },
                    );
                    context.read<AuthBloc>().add(const AuthEvent.refreshData());
                    AutoRouter.of(context).pop();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
