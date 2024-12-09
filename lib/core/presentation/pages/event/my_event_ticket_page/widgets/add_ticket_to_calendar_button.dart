import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/common/add_to_calendar_bottomsheet/add_to_calendar_bottomsheet.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTicketToCalendarButton extends StatelessWidget {
  const AddTicketToCalendarButton({
    super.key,
    required this.event,
  });

  final Event event;

  void _addToCalendar(BuildContext context) {
    AddToCalendarBottomSheet.show(
      context,
      EventUtils.generateDeviceCalendarEvent(
        context,
        event: event,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return InkWell(
      onTap: () {
        _addToCalendar(context);
      },
      child: Container(
        height: 54.w,
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.smMedium,
          vertical: Spacing.smMedium,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outline, width: 1.w),
          borderRadius: BorderRadius.circular(LemonRadius.small),
          color: colorScheme.onPrimary.withOpacity(0.06),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.icons.icCalendarAlt.svg(
              width: Sizing.xSmall,
              height: Sizing.xSmall,
            ),
            SizedBox(width: Spacing.xSmall),
            Text(
              '${t.common.addTo} ${t.common.calendar}'.toUpperCase(),
              style: Typo.medium.copyWith(
                fontFamily: FontFamily.spaceGrotesk,
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
