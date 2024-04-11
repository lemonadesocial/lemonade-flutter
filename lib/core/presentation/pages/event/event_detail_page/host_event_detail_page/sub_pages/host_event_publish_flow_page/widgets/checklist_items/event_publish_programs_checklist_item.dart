import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/checklist_item_base_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventPublishProgramsChecklistItem extends StatelessWidget {
  final bool fulfilled;
  final Event event;

  const EventPublishProgramsChecklistItem({
    super.key,
    required this.fulfilled,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final eventSessions = (event.sessions ?? [])
        .map(
          (session) => session.copyWith(
            start: session.start?.toLocal(),
            end: session.end?.toLocal(),
          ),
        )
        .toList()
      ..sort((a, b) {
        if (a.start != null && b.start != null) {
          return a.start!.compareTo(b.start!);
        }
        return -1;
      });

    final sessionDays = eventSessions.map(
      (session) => DateFormat('MMMM dd')
          .format(session.start?.toLocal() ?? DateTime.now()),
    );

    Map<String, int?> sessionCountPerDayMap =
        sessionDays.fold<Map<String, int?>>(
      {},
      (previousValue, element) {
        previousValue.update(
          element,
          (value) => value != null ? value + 1 : 1,
          ifAbsent: () => 1,
        );

        return previousValue;
      },
    );

    return CheckListItemBaseWidget(
      onTap: () => SnackBarUtils.showComingSoon(),
      title: t.event.eventPublish.addProgram,
      icon: Assets.icons.icProgram,
      fulfilled: fulfilled,
      child: sessionCountPerDayMap.isNotEmpty
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...sessionCountPerDayMap.entries.map((entry) {
                  final isLast = sessionDays.toSet().last == entry.key;
                  return _ProgramItem(
                    label: entry.key,
                    count: entry.value.toString(),
                    isLast: isLast,
                  );
                }),
              ],
            )
          : null,
    );
  }
}

class _ProgramItem extends StatelessWidget {
  final String label;
  final String count;
  final bool isLast;
  const _ProgramItem({
    required this.label,
    required this.count,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: isLast ? 0 : Spacing.small,
        ),
        child: Row(
          children: [
            Icon(
              Icons.arrow_right_rounded,
              color: colorScheme.onSecondary,
            ),
            Expanded(
              flex: 1,
              child: Text.rich(
                TextSpan(
                  text: label,
                  style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                ),
              ),
            ),
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (colorFilter) => Assets.icons.icCalendar.svg(
                colorFilter: colorFilter,
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Text(
              count,
              style: Typo.medium.copyWith(color: colorScheme.onSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
