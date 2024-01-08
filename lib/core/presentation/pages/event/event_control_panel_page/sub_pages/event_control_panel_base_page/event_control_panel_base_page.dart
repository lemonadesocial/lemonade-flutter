import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/event_detail_cohosts_bloc/event_detail_cohosts_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/create_event_config_grid.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_control_panel_base_page/widgets/event_collaborations_grid_config.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventControlPanelBasePage extends StatelessWidget {
  const EventControlPanelBasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
                  context.read<EventDetailCohostsBloc>().add(
                        EventDetailCohostsEvent.fetch(
                          eventId: event.id ?? '',
                        ),
                      );
                  context.read<GetEventDetailBloc>().add(
                        GetEventDetailEvent.replace(
                          event: state.event ?? Event(),
                        ),
                      );
                }
              },
              child: SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.only(
                        left: Spacing.smMedium,
                        right: Spacing.smMedium,
                        top: Spacing.extraSmall,
                        bottom: Spacing.xSmall,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          t.event.eventDetails,
                          style: Typo.medium.copyWith(),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.smMedium,
                      ),
                      sliver: CreateEventConfigGrid(event: event),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(
                        left: Spacing.smMedium,
                        right: Spacing.smMedium,
                        top: Spacing.xLarge,
                        bottom: Spacing.xSmall,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          t.event.collaborations,
                          style: Typo.medium.copyWith(),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.smMedium,
                      ),
                      sliver: EventCollaborationsGridConfig(event: event),
                    ),
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
