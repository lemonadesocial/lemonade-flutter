import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class HostCheckinGuestsAction extends StatelessWidget {
  const HostCheckinGuestsAction({
    super.key,
    required this.event,
    // required this.eventUserRole,
  });

  final Event event;
  // final EventUserRole? eventUserRole;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    // final canShowCheckIn = FeatureManager(
    //   EventRoleBasedEventFeatureVisibilityStrategy(
    //     eventUserRole: eventUserRole,
    //     featureCodes: [Enum$FeatureCode.CheckIn],
    //   ),
    // ).canShowFeature;
    // if (!canShowCheckIn) return const SizedBox();
    return InkWell(
      onTap: () {
        Vibrate.feedback(FeedbackType.light);
        AutoRouter.of(context).navigate(
          ScanQRCheckinRewardsRoute(
            event: event,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.smMedium),
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.circular(LemonRadius.medium),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Assets.icons.icScanLineGradient.svg(
                  width: Sizing.medium / 2,
                  height: Sizing.medium / 2,
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
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icArrowRight.svg(
                colorFilter: filter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
