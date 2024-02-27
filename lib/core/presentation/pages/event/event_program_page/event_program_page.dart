import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_session.dart';
import 'package:app/core/presentation/pages/event/event_program_page/widgets/event_program_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_chip_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

@RoutePage()
class EventProgramPage extends StatefulWidget {
  const EventProgramPage({super.key});

  @override
  EventProgramPageState createState() => EventProgramPageState();
}

class EventProgramPageState extends State<EventProgramPage> {
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final eventDetailBloc = context.watch<GetEventDetailBloc>();
    Event event = eventDetailBloc.state.maybeWhen(
      fetched: (event) => event,
      orElse: () => Event(),
    );

    List<String> sessionDays = event.sessions!
        .map(
          (session) =>
              DateFormat('dd-MMM-yyyy').format(session.start ?? DateTime.now()),
        )
        .toSet()
        .toList();

    List<EventSession> filteredSessions = event.sessions
            ?.where(
              (session) =>
                  selectedDay == null || session.start?.day == selectedDay?.day,
            )
            .toList() ??
        [];

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: LemonAppBar(
        title: t.event.eventProgram,
      ),
      body: Column(
        children: [
          _buildSessionDaySelector(sessionDays),
          SizedBox(
            height: Spacing.medium,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                left: Spacing.smMedium,
                right: Spacing.smMedium,
                bottom: Spacing.large,
              ),
              itemCount: filteredSessions.length,
              itemBuilder: (context, index) {
                bool shouldShowDottedLine =
                    index != filteredSessions.length - 1;
                bool showGapBetween = index + 1 < filteredSessions.length
                    ? filteredSessions[index].start?.day !=
                        filteredSessions[index + 1].start?.day
                    : false;
                if (index == 0) {
                  return EventProgramWidget(
                    session: filteredSessions[index],
                    showDate: true,
                    index: index,
                    showDottedLine: shouldShowDottedLine,
                    showGapBetween: showGapBetween,
                  );
                }
                // Hide date if 2 start day similar each other
                if (filteredSessions[index].start?.day ==
                    filteredSessions[index - 1].start?.day) {
                  return EventProgramWidget(
                    session: filteredSessions[index],
                    showDate: false,
                    index: index,
                    showDottedLine: shouldShowDottedLine,
                    showGapBetween: showGapBetween,
                  );
                }
                return EventProgramWidget(
                  session: filteredSessions[index],
                  showDate: true,
                  index: index,
                  showDottedLine: shouldShowDottedLine,
                  showGapBetween: showGapBetween,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionDaySelector(List<String> sessionDays) {
    return Container(
      height: Sizing.medium,
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sessionDays.length,
        itemBuilder: (context, index) {
          final sessionDay = sessionDays[index];
          return _buildLemonChip(sessionDay, index, context);
        },
        separatorBuilder: (context, index) =>
            SizedBox(width: Spacing.extraSmall),
      ),
    );
  }

  Widget _buildLemonChip(String sessionDay, int index, BuildContext context) {
    final bool isFirstChip = index == 0;
    final bool isActive = (isFirstChip && selectedDay == null) ||
        (selectedDay != null &&
            selectedDay!.day ==
                DateFormat('dd-MMM-yyyy').parse(sessionDay).day);

    return LemonChip(
      label: isFirstChip
          ? t.event.allSessions
          : DateFormat('dd-MMM')
              .format(DateFormat('dd-MMM-yyyy').parse(sessionDay)),
      isActive: isActive,
      inactiveBackgroundColor: Colors.transparent,
      activeBackgroundColor: LemonColor.white09,
      activeTextColor: Theme.of(context).colorScheme.onPrimary,
      borderColor: isActive ? Colors.transparent : LemonColor.white09,
      icon: isFirstChip
          ? Assets.icons.icEventExclusive.svg(
              width: 15.w,
              height: 15.w,
              color: selectedDay == null ? LemonColor.paleViolet : null,
            )
          : null,
      onTap: () {
        setState(() {
          selectedDay =
              isFirstChip ? null : DateFormat('dd-MMM-yyyy').parse(sessionDay);
        });
      },
    );
  }
}
