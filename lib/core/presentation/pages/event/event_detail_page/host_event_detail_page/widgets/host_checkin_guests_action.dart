import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:app/app_theme/app_theme.dart';

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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
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
          color: appColors.cardBg,
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          border: Border.all(
            color: appColors.cardBorder,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ThemeSvgIcon(
                  color: appColors.textAccent,
                  builder: (filter) => Assets.icons.icScanLineGradient.svg(
                    colorFilter: filter,
                    width: Sizing.medium / 2,
                    height: Sizing.medium / 2,
                  ),
                ),
                SizedBox(width: Spacing.extraSmall),
                Text(
                  t.event.checkinGuests,
                  style: appText.md.copyWith(
                    color: appColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            ThemeSvgIcon(
              color: appColors.textTertiary,
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
