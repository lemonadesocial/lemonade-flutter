import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartDateRangePicker extends StatelessWidget {
  final DateTimeRange timeRange;
  final Function()? onSelectStartDate;
  final Function()? onSelectEndDate;
  const ChartDateRangePicker({
    super.key,
    required this.timeRange,
    this.onSelectStartDate,
    this.onSelectEndDate,
  });

  DateFormat get dateFormat => DateFormat('dd MMM yyyy');

  DateFormat get noYearDateFormat => DateFormat('dd MMM');

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: Sizing.medium,
      padding: EdgeInsets.symmetric(
        vertical: Spacing.extraSmall,
        horizontal: Spacing.small,
      ),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(LemonRadius.normal),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onSelectStartDate,
            child: Text(
              timeRange.start.year == timeRange.end.year
                  ? '${noYearDateFormat.format(timeRange.start)} - '
                  : '${dateFormat.format(timeRange.start)} - ',
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ),
          InkWell(
            onTap: onSelectEndDate,
            child: Text(
              dateFormat.format(timeRange.end),
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ),
          SizedBox(width: Spacing.superExtraSmall),
          ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icArrowDown.svg(
              colorFilter: filter,
            ),
          ),
        ],
      ),
    );
  }
}
