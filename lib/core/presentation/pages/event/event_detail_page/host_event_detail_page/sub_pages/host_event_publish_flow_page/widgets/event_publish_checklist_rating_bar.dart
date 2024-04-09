import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const position = [0.15, 0.4, 0.625, 1];

class EventPublishChecklistRatingBar extends StatelessWidget {
  const EventPublishChecklistRatingBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return SizedBox(
      child: Stack(
        children: [
          Positioned.fill(
            top: 2.w,
            child: const _Line(),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _Dot(
                label: t.event.eventPublish.ratingBar.average,
              ),
              _Dot(
                active: true,
                label: t.event.eventPublish.ratingBar.good,
              ),
              _Dot(
                label: t.event.eventPublish.ratingBar.great,
              ),
              _Dot(
                label: t.event.eventPublish.ratingBar.awesome,
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
  const _Line();

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
              // TODO: use position
              width: 0.625 * maxWidth - 6.w,
              height: 3.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.r),
                color: LemonColor.snackBarSuccess,
              ),
            );
          },
        ),
      ],
    );
  }
}
