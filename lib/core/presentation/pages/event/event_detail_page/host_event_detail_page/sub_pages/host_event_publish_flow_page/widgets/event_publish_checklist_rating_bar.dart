import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/helper/event_publish_helper.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/host_event_publish_flow_page.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventPublishChecklistRatingBar extends StatelessWidget {
  final EventPublishRating rating;
  const EventPublishChecklistRatingBar({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final currentProgress = EventPublishHelper.progressByRating[rating] ??
        EventPublishHelper.progressByRating[EventPublishRating.average]!;
    final progressColor = EventPublishHelper.colorByRating[rating] ??
        EventPublishHelper.colorByRating[EventPublishRating.average]!;
    return SizedBox(
      child: Stack(
        children: [
          Positioned.fill(
            top: 2.w,
            child: _Line(
              progress: currentProgress,
              progressColor: progressColor,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _Dot(
                label: t.event.eventPublish.ratingBar.average,
                active: rating == EventPublishRating.average,
              ),
              _Dot(
                label: t.event.eventPublish.ratingBar.good,
                active: rating == EventPublishRating.good,
              ),
              _Dot(
                label: t.event.eventPublish.ratingBar.great,
                active: rating == EventPublishRating.great,
              ),
              _Dot(
                label: t.event.eventPublish.ratingBar.awesome,
                active: rating == EventPublishRating.awesome,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final String label;
  final bool? active;
  const _Dot({
    required this.label,
    this.active,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6.w,
          height: 9.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              3.r,
            ),
          ),
        ),
        SizedBox(height: Spacing.extraSmall),
        Text(
          label.toUpperCase(),
          style: Typo.xSmall.copyWith(
            color: active == true
                ? colorScheme.onPrimary
                : colorScheme.onSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _Line extends StatelessWidget {
  final double progress;
  final Color progressColor;
  const _Line({
    required this.progress,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 3.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.r),
            color: colorScheme.secondaryContainer,
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: progress * maxWidth - 6.w,
              height: 3.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.r),
                color: progressColor,
              ),
            );
          },
        ),
      ],
    );
  }
}
