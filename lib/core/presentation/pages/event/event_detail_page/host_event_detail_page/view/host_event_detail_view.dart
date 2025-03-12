import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/post_guest_event_animated_app_bar.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_checkin_guests_action.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_event_basic_info_card.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_event_detail_config_grid.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_event_location.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_collectibles_section/host_collectibles_section.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_event_manage_space_widget/host_event_manage_space_widget.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/widgets/create_sub_side_event_button.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/widgets/event_detail_floating_menu_button.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/widgets/event_detail_navigation_bar.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/cast_on_farcaster_button/cast_on_farcaster_button.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HostEventDetailView extends StatelessWidget {
  const HostEventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    // final eventUserRole = context.watch<GetEventUserRoleBloc>().state.maybeWhen(
    //       fetched: (eventUserRole) => eventUserRole,
    //       orElse: () => null,
    //     );

    return BlocBuilder<GetEventDetailBloc, GetEventDetailState>(
      builder: (context, state) => state.when(
        failure: () => Scaffold(
          backgroundColor: colorScheme.primary,
          body: Center(
            child: EmptyList(
              emptyText: t.common.somethingWrong,
            ),
          ),
        ),
        loading: () => Scaffold(
          backgroundColor: colorScheme.primary,
          body: Loading.defaultLoading(context),
        ),
        fetched: (event) {
          return Scaffold(
            floatingActionButton: EventDetailFloatingMenuButton(
              onTap: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  expand: false,
                  barrierColor: Colors.black.withOpacity(0.5),
                  backgroundColor: LemonColor.atomicBlack,
                  topRadius: Radius.circular(LemonRadius.normal),
                  useRootNavigator: true,
                  builder: (context) {
                    return EventDetailNavigationBar(
                      event: event,
                      // eventUserRole: eventUserRole,
                    );
                  },
                );
              },
            ),
            body: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: PostGuestEventAnimatedAppBar(
                          event: event,
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(top: 6.h),
                      ),
                      SliverPadding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                        sliver: SliverToBoxAdapter(
                          child: HostEventBasicInfoCard(
                            event: event,
                            // eventUserRole: eventUserRole,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(top: Spacing.large),
                      ),
                      SliverPadding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                        sliver: HostEventDetailConfigGrid(
                          event: event,
                          // eventUserRole: eventUserRole,
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(top: Spacing.large),
                      ),
                      SliverPadding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              HostCheckinGuestsAction(
                                event: event,
                                // eventUserRole: eventUserRole,
                              ),
                              SizedBox(
                                height: Spacing.extraSmall,
                              ),
                              CastOnFarcasterButton(
                                event: event,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(top: Spacing.xLarge),
                      ),
                      if (event.subeventEnabled == true) ...[
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacing.smMedium,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: CreateSubSideEventButton(
                              event: event,
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.only(top: Spacing.xLarge),
                        ),
                      ],
                      SliverPadding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                        sliver: SliverToBoxAdapter(
                          child: HostCollectiblesSection(
                            event: event,
                            // eventUserRole: eventUserRole,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(top: Spacing.medium),
                      ),
                      if (event.latitude != null &&
                          event.longitude != null) ...[
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            vertical: Spacing.smMedium,
                            horizontal: Spacing.smMedium,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: HostEventLocation(event: event),
                          ),
                        ),
                      ],
                      SliverPadding(
                        padding: EdgeInsets.only(top: Spacing.smMedium),
                      ),
                      if (event.space != null)
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacing.smMedium,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: HostEventManageSpaceWidget(
                              eventId: event.id ?? "",
                            ),
                          ),
                        ),
                      const SliverToBoxAdapter(
                        child: SafeArea(
                          top: false,
                          child: SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
