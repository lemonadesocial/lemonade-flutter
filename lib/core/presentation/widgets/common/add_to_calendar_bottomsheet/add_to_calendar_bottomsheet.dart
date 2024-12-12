import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/service/device_calendar/device_calendar_service.dart';
import 'package:app/core/utils/platform_infos.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddToCalendarBottomSheet extends StatelessWidget {
  const AddToCalendarBottomSheet({
    super.key,
    required this.event,
  });

  final DeviceCalendarEvent event;

  static void show(BuildContext context, DeviceCalendarEvent event) {
    showCupertinoModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      topRadius: Radius.circular(Sizing.small),
      builder: (context) => AddToCalendarBottomSheet(event: event),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: LemonColor.atomicBlack,
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.small,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.center,
              child: BottomSheetGrabber(),
            ),
            SizedBox(
              height: Spacing.medium,
            ),
            Text(
              t.common.deviceCalendar.addToCalendarTitle,
              style: Typo.extraLarge.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: Spacing.superExtraSmall,
            ),
            Text(
              t.common.deviceCalendar.addToCalendarDescription,
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            SizedBox(
              height: Spacing.medium,
            ),
            LinearGradientButton.secondaryButton(
              mode: GradientButtonMode.light,
              label: t.common.deviceCalendar.addToGoogleCalendar,
              onTap: () {
                DeviceCalendarService.addToGoogleCalendar(event: event);
              },
            ),
            if (PlatformInfos.isIOS) ...[
              SizedBox(
                height: Spacing.xSmall,
              ),
              LinearGradientButton.secondaryButton(
                mode: GradientButtonMode.defaultMode,
                label: t.common.deviceCalendar.addToAppleCalendar,
                onTap: () {
                  DeviceCalendarService.addToAppleCalendar(event: event);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
