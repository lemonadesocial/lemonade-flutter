import 'package:app/core/domain/event/entities/event_guest_detail/event_guest_detail.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:intl/intl.dart';

class EventGuestDetailTimelineInfoWidget extends StatelessWidget {
  final EventGuestDetail eventGuestDetail;

  const EventGuestDetailTimelineInfoWidget({
    super.key,
    required this.eventGuestDetail,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final joinRequest = eventGuestDetail.joinRequest;
    if (joinRequest == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.eventGuestDetail.timeline,
          style: Typo.mediumPlus.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.small),
        _TimelineItem(
          title: t.event.eventGuestDetail.requestSubmitted,
          date: joinRequest.createdAt,
          isFirst: true,
          isLast: joinRequest.isPending,
          status: _TimelineStatus.done,
        ),
        if (!joinRequest.isPending)
          _TimelineItem(
            title: joinRequest.isApproved
                ? t.event.eventGuestDetail.requestApproved
                : t.event.eventGuestDetail.requestDeclined,
            date: joinRequest.createdAt,
            isFirst: false,
            isLast: true,
            status: joinRequest.isApproved
                ? _TimelineStatus.approved
                : _TimelineStatus.declined,
          ),
      ],
    );
  }
}

enum _TimelineStatus { done, approved, declined }

class _TimelineItem extends StatelessWidget {
  final String title;
  final DateTime? date;
  final bool isFirst;
  final bool isLast;
  final _TimelineStatus status;

  const _TimelineItem({
    required this.title,
    required this.date,
    required this.isFirst,
    required this.isLast,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Spacing.extraSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  if (date != null)
                    Text(
                      DateFormat('dd MMM, HH:mm').format(date!),
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
