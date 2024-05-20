import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/cast_on_farcaster_button/cast_on_farcaster_button.dart';
import 'package:app/core/presentation/widgets/common/readmore/readmore_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class GuestEventDetailGeneralInfo extends StatelessWidget {
  const GuestEventDetailGeneralInfo({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          event.title ?? '',
          style: Typo.extraLarge.copyWith(
            fontFamily: FontFamily.nohemiVariable,
            color: colorScheme.onPrimary,
          ),
        ),
        SizedBox(height: Spacing.superExtraSmall / 2),
        Text(
          DateFormatUtils.fullDateWithTime(event.start),
          style: Typo.medium.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        if (event.description != null && event.description!.isNotEmpty) ...[
          SizedBox(
            height: Spacing.smMedium,
          ),
          ReadMoreWidget(
            body: event.description ?? '',
            isMarkdown: true,
          ),
        ],
        SizedBox(
          height: Spacing.smMedium,
        ),
        CastOnFarcasterButton(event: event),
      ],
    );
  }
}
