// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class EventJoinRequestTicketInfo extends StatelessWidget {
  final EventJoinRequest eventJoinRequest;
  final bool showPrice;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? radius;
  final TextStyle? textStyle;

  const EventJoinRequestTicketInfo({
    super.key,
    required this.eventJoinRequest,
    this.showPrice = true,
    this.backgroundColor,
    this.borderColor,
    this.radius,
    this.textStyle,
  });

  int get totalTicketCount => (eventJoinRequest.ticketInfo ?? [])
      .map((item) => item.count ?? 0)
      .reduce((a, b) => a + b)
      .toInt();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final _borderColor = borderColor ?? colorScheme.outline;
    final _radius = radius ?? LemonRadius.xSmall;
    final _textStyle = textStyle ?? Typo.small;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: _borderColor),
            borderRadius: BorderRadius.circular(_radius),
          ),
          padding: EdgeInsets.all(Spacing.xSmall),
          child: Row(
            children: [
              ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (colorFilter) => Assets.icons.icTicket.svg(
                  colorFilter: colorFilter,
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                ),
              ),
              SizedBox(width: Spacing.superExtraSmall),
              Text('$totalTicketCount', style: _textStyle),
            ],
          ),
        ),
        if (showPrice) ...[
          SizedBox(width: Spacing.superExtraSmall),
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: _borderColor),
              borderRadius: BorderRadius.circular(_radius),
            ),
            padding: EdgeInsets.all(Spacing.xSmall),
            child: Row(
              children: [
                ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (colorFilter) => Assets.icons.icCashVariant.svg(
                    colorFilter: colorFilter,
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                  ),
                ),
                SizedBox(width: Spacing.superExtraSmall),
                // TODO: will calculate total cost here
                Text('\$300', style: _textStyle),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
