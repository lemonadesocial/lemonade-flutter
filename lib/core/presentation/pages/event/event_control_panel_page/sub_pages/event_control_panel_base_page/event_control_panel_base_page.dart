import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_cohost_requests_bloc/get_event_cohost_requests_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_control_panel_base_page/widgets/edit_event_config_grid.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/event_config_card.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/event_date_time_setting_section.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_control_panel_base_page/widgets/event_tickets_grid_config.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_guest_settings_page/widgets/delete_event_confirmation_bottom_sheet.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

@RoutePage()
class EventControlPanelBasePage extends StatelessWidget {
  const EventControlPanelBasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // final eventUserRole = context.watch<GetEventUserRoleBloc>().state.maybeWhen(
    //       orElse: () => null,
    //       fetched: (eventUserRole) => eventUserRole,
    //     );
    // final canShowEventSettings = FeatureManager(
    //   EventRoleBasedEventFeatureVisibilityStrategy(
    //     eventUserRole: eventUserRole,
    //     featureCodes: [
    //       Enum$FeatureCode.EventSettings,
    //     ],
    //   ),
    // ).canShowFeature;
    // final canShowPromotionCodes = FeatureManager(
    //   EventRoleBasedEventFeatureVisibilityStrategy(
    //     eventUserRole: eventUserRole,
    //     featureCodes: [
    //       Enum$FeatureCode.PromotionCodes,
    //     ],
    //   ),
    // ).canShowFeature;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: LemonAppBar(
        title: t.event.editEvent,
      ),
      body: BlocBuilder<GetEventDetailBloc, GetEventDetailState>(
        builder: (context, state) => state.when(
          failure: () => Center(
            child: EmptyList(
              emptyText: t.common.somethingWrong,
            ),
          ),
          loading: () => Center(
            child: Loading.defaultLoading(context),
          ),
          fetched: (event) {
            return BlocListener<EditEventDetailBloc, EditEventDetailState>(
              listener: (context, state) {
                if (state.status == EditEventDetailBlocStatus.success) {
                  // final canUseEventCohosts = FeatureManager(
                  //   UserRoleFeatureVisibilityStrategy(
                  //     eventUserRole: eventUserRole,
                  //     roleCodes: [
                  //       Enum$RoleCode.Host,
                  //       Enum$RoleCode.Cohost,
                  //     ],
                  //   ),
                  // ).canShowFeature;
                  // if (canUseEventCohosts) {
                  context.read<GetEventCohostRequestsBloc>().add(
                        GetEventCohostRequestsEvent.fetch(
                          eventId: event.id ?? '',
                        ),
                      );
                  context.read<GetEventDetailBloc>().add(
                        GetEventDetailEvent.fetch(
                          eventId: state.event?.id ?? '',
                        ),
                      );
                }
              },
              child: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    // if (canShowEventSettings)
                    SliverPadding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                      sliver: SliverToBoxAdapter(
                        child: EventConfigCard(
                          title: t.event.eventCreation.titleAndDescription,
                          description: event.description,
                          maxLinesDescription: 1,
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                            size: 18,
                            color: LemonColor.white54,
                          ),
                          selected: false,
                          onTap: () {
                            AutoRouter.of(context).navigate(
                              const EventTitleDescriptionSettingRoute(),
                            );
                          },
                          paddingVertical: Spacing.xSmall,
                        ),
                      ),
                    ),
                    // if (canShowEventSettings)
                    SliverPadding(
                      padding: EdgeInsets.only(
                        top: Spacing.smMedium,
                      ),
                    ),
                    // if (canShowEventSettings)
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.smMedium,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: EventDateTimeSettingSection(
                          event: event,
                        ),
                      ),
                    ),
                    // if (canShowEventSettings)
                    SliverPadding(
                      padding: EdgeInsets.only(
                        top: 30.h,
                      ),
                    ),
                    // if (canShowEventSettings)
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.smMedium,
                      ),
                      sliver: EditEventConfigGrid(event: event),
                    ),
                    // if (canShowEventSettings)
                    SliverPadding(
                      padding: EdgeInsets.only(
                        left: Spacing.smMedium,
                        right: Spacing.smMedium,
                        top: Spacing.xLarge,
                        bottom: Spacing.xSmall,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          t.event.configuration.tickets,
                          style: Typo.medium.copyWith(),
                        ),
                      ),
                    ),
                    // if (canShowEventSettings || canShowPromotionCodes)
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.smMedium,
                      ),
                      sliver: EventTicketsGridConfig(
                        event: event,
                      ),
                    ),
                    // if (canShowEventSettings)
                    // SliverPadding(
                    //   padding: EdgeInsets.only(
                    //     left: Spacing.smMedium,
                    //     right: Spacing.smMedium,
                    //     top: Spacing.xLarge,
                    //     bottom: Spacing.xSmall,
                    //   ),
                    //   sliver: SliverToBoxAdapter(
                    //     child: Text(
                    //       t.event.collaborations,
                    //       style: Typo.medium.copyWith(),
                    //     ),
                    //   ),
                    // ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        vertical: Spacing.smMedium,
                        horizontal: Spacing.smMedium,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: InkWell(
                          onTap: () {
                            showCupertinoModalBottomSheet(
                              context: context,
                              barrierColor: Colors.black.withOpacity(0.8),
                              topRadius: Radius.circular(30.r),
                              builder: (mContext) {
                                return DeleteEventConfirmationBottomSheet(
                                  event: event,
                                );
                              },
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ThemeSvgIcon(
                                color: LemonColor.coralReef,
                                builder: (filter) {
                                  return Assets.icons.icDelete.svg(
                                    colorFilter: filter,
                                    width: 18,
                                    height: 18,
                                  );
                                },
                              ),
                              SizedBox(width: Spacing.extraSmall),
                              Text(
                                t.event.deleteEvent,
                                style: Typo.medium.copyWith(
                                  color: LemonColor.coralReef,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // if (canShowEventSettings)
                    // SliverPadding(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: Spacing.smMedium,
                    //   ),
                    //   sliver: EventCollaborationsGridConfig(event: event),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: SizedBox(
                    //     height: Spacing.xLarge,
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
