import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/create_event_config_grid.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventControlPanelPage extends StatelessWidget {
  const EventControlPanelPage({
    super.key,
  });

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
                state.maybeWhen(
                  success: (eventDetail) {
                    context.read<GetEventDetailBloc>().add(
                          GetEventDetailEvent.replace(event: eventDetail),
                        );
                  },
                  orElse: () {},
                );
              },
              child: SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.smMedium,
                      ),
                      sliver: CreateEventConfigGrid(event: event),
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
