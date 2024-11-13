import 'package:app/core/application/event_tickets/issue_tickets_bloc/issue_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';

class EventIssueTicketsSummary extends StatelessWidget {
  const EventIssueTicketsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocBuilder<IssueTicketsBloc, IssueTicketsBlocState>(
      builder: (context, state) {
        final totalTicketCount = state.ticketAssignments.isEmpty
            ? 0
            : state.ticketAssignments
                .map((item) => item.count)
                .reduce((a, b) => a + b)
                .toInt();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TicketTierInfo(
              ticketType: state.selectedTicketType,
            ),
            SizedBox(height: Spacing.superExtraSmall),
            if (state.ticketAssignments.isNotEmpty)
              Container(
                padding: EdgeInsets.all(Spacing.smMedium),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(Spacing.superExtraSmall),
                ),
                child: Column(
                  children:
                      state.ticketAssignments.asMap().entries.map((entry) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _SummaryRow(
                          label: entry.value.email,
                          value: entry.value.count.toInt().toString(),
                        ),
                        if (entry.key != state.ticketAssignments.length - 1)
                          SizedBox(
                            height: Spacing.superExtraSmall,
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            SizedBox(height: Spacing.superExtraSmall),
            Container(
              padding: EdgeInsets.all(Spacing.smMedium),
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(LemonRadius.medium),
                  bottomRight: Radius.circular(LemonRadius.medium),
                  topLeft: Radius.circular(LemonRadius.extraSmall),
                  topRight: Radius.circular(LemonRadius.extraSmall),
                ),
              ),
              child: Column(
                children: [
                  _SummaryRow(
                    label: t.event.issueTickets.totalTickets,
                    textColor: colorScheme.onPrimary,
                    textStyle: Typo.medium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimary,
                    ),
                    value: totalTicketCount.toString(),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TicketTierInfo extends StatelessWidget {
  final EventTicketType? ticketType;
  const _TicketTierInfo({
    this.ticketType,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(LemonRadius.medium),
          topRight: Radius.circular(LemonRadius.medium),
          bottomLeft: Radius.circular(LemonRadius.extraSmall),
          bottomRight: Radius.circular(LemonRadius.extraSmall),
        ),
        color: colorScheme.secondaryContainer,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            child: CachedNetworkImage(
              imageUrl: ImageUtils.generateUrl(
                file: ticketType?.photosExpanded?.firstOrNull,
              ),
              errorWidget: (_, __, ___) => ImagePlaceholder.ticketThumbnail(),
              placeholder: (_, __) => ImagePlaceholder.ticketThumbnail(),
              width: Sizing.small,
              height: Sizing.small,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            flex: 1,
            child: Text(
              ticketType?.title ?? '',
              style: Typo.mediumPlus.copyWith(
                color: colorScheme.onPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.textColor,
    this.textStyle,
  });

  final String label;
  final String value;
  final Color? textColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final customTextStyle = textStyle ??
        Typo.mediumPlus.copyWith(
          color: textColor ?? colorScheme.onSecondary,
        );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: customTextStyle,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 3.w),
            child: DottedLine(
              dashColor: colorScheme.onPrimary.withOpacity(0.06),
            ),
          ),
        ),
        Text(
          value,
          style: customTextStyle,
        ),
      ],
    );
  }
}
