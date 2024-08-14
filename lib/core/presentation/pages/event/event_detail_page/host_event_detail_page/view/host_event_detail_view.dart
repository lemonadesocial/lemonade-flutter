import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_user_role_bloc%20/get_event_user_role_bloc.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/post_guest_event_animated_app_bar.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_checkin_guests_action.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_event_basic_info_card.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_event_detail_config_grid.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_event_location.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_collectibles_section/host_collectibles_section.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/widgets/create_sub_side_event_button.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/widgets/event_detail_navigation_bar.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/cast_on_farcaster_button/cast_on_farcaster_button.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HostEventDetailView extends StatelessWidget {
  const HostEventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final eventUserRole = context.watch<GetEventUserRoleBloc>().state.maybeWhen(
          fetched: (eventUserRole) => eventUserRole,
          orElse: () => null,
        );
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: BlocBuilder<GetEventDetailBloc, GetEventDetailState>(
        builder: (context, state) => state.when(
          failure: () => Center(
            child: EmptyList(
              emptyText: t.common.somethingWrong,
            ),
          ),
          loading: () => Loading.defaultLoading(context),
          fetched: (event) {
            return SafeArea(
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
                          actions: event.published == false
                              ? [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: Spacing.smMedium,
                                    ),
                                    child: LinearGradientButton.primaryButton(
                                      onTap: () => AutoRouter.of(context).push(
                                        const HostEventPublishFlowRoute(),
                                      ),
                                      height: Sizing.medium,
                                      textStyle: Typo.small.copyWith(
                                        color: colorScheme.onPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      trailing: Assets.icons.icUpload.svg(),
                                      label: t.common.actions.publish,
                                    ),
                                  ),
                                ]
                              : null,
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
                            eventUserRole: eventUserRole,
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
                          eventUserRole: eventUserRole,
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
                                eventUserRole: eventUserRole,
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
                            eventUserRole: eventUserRole,
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
                        padding: EdgeInsets.symmetric(vertical: Spacing.medium),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: Spacing.xLarge * 2),
                      ),
                    ],
                  ),
                  EventDetailNavigationBar(
                    event: event,
                    eventUserRole: eventUserRole,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
