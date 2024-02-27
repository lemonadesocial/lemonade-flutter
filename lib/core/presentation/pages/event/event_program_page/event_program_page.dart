import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_program_page/widgets/event_program_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventProgramPage extends StatelessWidget {
  const EventProgramPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    Event event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event,
          orElse: () => Event(),
        );
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: LemonAppBar(
        title: t.event.eventProgram,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: Spacing.smMedium, vertical: Spacing.smMedium),
        itemCount: event.sessions?.length,
        itemBuilder: (context, index) {
          final shouldShowDottedLine = index != event.sessions!.length - 1;
          bool showGapBetween = index + 1 < event.sessions!.length
              ? event.sessions![index].start?.day !=
                  event.sessions![index + 1].start?.day
              : false;
          if (index == 0) {
            return EventProgramWidget(
              session: event.sessions![index],
              showDate: true,
              index: index,
              showDottedLine: shouldShowDottedLine,
              showGapBetween: showGapBetween,
            );
          }
          // Hide date if 2 start day similar each other
          if (event.sessions![index].start?.day ==
              event.sessions![index - 1].start?.day) {
            return EventProgramWidget(
              session: event.sessions![index],
              showDate: false,
              index: index,
              showDottedLine: shouldShowDottedLine,
              showGapBetween: showGapBetween,
            );
          }
          return EventProgramWidget(
            session: event.sessions![index],
            showDate: true,
            index: index,
            showDottedLine: shouldShowDottedLine,
            showGapBetween: showGapBetween,
          );
        },
      ),
    );
  }
}
