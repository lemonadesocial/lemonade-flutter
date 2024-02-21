// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/event_join_request_ticket_info_builder.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventJoinRequestTicketInfo extends StatelessWidget {
  final EventJoinRequest eventJoinRequest;
  final bool showPrice;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? radius;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final Function()? onPress;

  const EventJoinRequestTicketInfo({
    super.key,
    required this.eventJoinRequest,
    this.showPrice = true,
    this.backgroundColor,
    this.borderColor,
    this.radius,
    this.textStyle,
    this.padding,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final _borderColor = borderColor ?? colorScheme.outline;
    final _radius = radius ?? LemonRadius.xSmall;
    final _textStyle = textStyle ?? Typo.small;
    final _padding = padding ?? EdgeInsets.all(Spacing.xSmall);

    return EventJoinRequestTicketInfoBuilder(
      eventJoinRequest: eventJoinRequest,
      builder: ({
        required totalTicketCount,
        required displayedTotalCost,
        required isLoading,
      }) =>
          InkWell(
        onTap: () {
          onPress?.call();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: _borderColor),
                borderRadius: BorderRadius.circular(_radius),
              ),
              padding: _padding,
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
              if (isLoading) Loading.defaultLoading(context),
              if (!isLoading)
                Container(
                  constraints: BoxConstraints(maxWidth: 120.w),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    border: Border.all(color: _borderColor),
                    borderRadius: BorderRadius.circular(_radius),
                  ),
                  padding: _padding,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (colorFilter) =>
                            Assets.icons.icCashVariant.svg(
                          colorFilter: colorFilter,
                          width: Sizing.xSmall,
                          height: Sizing.xSmall,
                        ),
                      ),
                      SizedBox(width: Spacing.superExtraSmall),
                      Flexible(
                        child: Text(
                          displayedTotalCost,
                          style: _textStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
