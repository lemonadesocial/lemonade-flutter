import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class HostCheckinGuestsAction extends StatelessWidget {
  const HostCheckinGuestsAction({
    super.key,
    required this.event,
  });

  final Event event;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Container(
      height: 54.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: InkWell(
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          AutoRouter.of(context).navigate(
            ScanQRCheckinRewardsRoute(
              event: event,
            ),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.smMedium,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Center(
                          child: Assets.icons.icScanLineGradient.svg(
                            width: Sizing.medium / 2,
                            height: Sizing.medium / 2,
                          ),
                        ),
                        SizedBox(width: Spacing.small),
                        Text(
                          t.event.checkinGuests,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                SizedBox(
                  width: Sizing.xLarge,
                  child: Center(
                    child: Assets.icons.icArrowBack.svg(
                      width: 25.w,
                      height: 25.w,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
