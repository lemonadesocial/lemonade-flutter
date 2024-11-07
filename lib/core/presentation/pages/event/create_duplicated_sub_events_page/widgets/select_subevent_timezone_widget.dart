import 'package:app/core/presentation/widgets/common/search_timezone_bottomsheet/search_timezone_bottomsheet.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timezone/timezone.dart' as tz;

class SelectSubEventTimezoneWidget extends StatelessWidget {
  final String timezone;
  final Function(String)? onTimezoneChanged;
  const SelectSubEventTimezoneWidget({
    super.key,
    required this.timezone,
    this.onTimezoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        showCupertinoModalBottomSheet(
          context: context,
          builder: (mContext) => SearchTimezoneBottomSheet(
            onTimezoneSelected: (timezoneValue) {
              onTimezoneChanged?.call(timezoneValue);
              Navigator.pop(mContext);
            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          border: Border.all(
            color: colorScheme.outline,
          ),
        ),
        child: Row(
          children: [
            Assets.icons.icGlobe.svg(
              width: 18.w,
              height: 18.w,
            ),
            SizedBox(
              width: Spacing.xSmall,
            ),
            Text(
              tz.getLocation(timezone).toString(),
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
            SizedBox(
              width: Spacing.extraSmall,
            ),
            Text(
              date_utils.DateUtils.getGMTOffsetText(timezone),
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            const Spacer(),
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (colorFilter) => Assets.icons.icDoubleArrowUpDown.svg(
                width: 18.w,
                height: 18.w,
                colorFilter: colorFilter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
