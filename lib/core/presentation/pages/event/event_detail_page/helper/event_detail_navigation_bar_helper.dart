import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/ticket_qr_code_popup.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/feature_manager/feature_manager.dart';
import 'package:app/core/service/feature_manager/event_role_based_feature_visibility_strategy.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class FeatureItem {
  final String label;
  final ThemeSvgIcon? iconData;
  final Function onTap;
  final Color? backgroundColor;
  final Color? textColor;

  FeatureItem({
    required this.label,
    required this.iconData,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
  });

  factory FeatureItem.empty() => FeatureItem(
        label: '',
        iconData: null,
        onTap: () {},
        backgroundColor: Colors.transparent,
      );
}

class EventDetailNavigationBarHelper {
  static List<FeatureItem> getEventFeaturesForGuest({
    required BuildContext context,
    required Event event,
    bool? isSmallIcon = true,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconSize = isSmallIcon == true ? 18.w : 24.w;
    final shouldShowProgram = (event.sessions ?? []).isNotEmpty;
    final List<FeatureItem> features = [
      FeatureItem(
        label: t.event.configuration.checkIn,
        iconData: ThemeSvgIcon(
          color: LemonColor.paleViolet,
          builder: (filter) => Assets.icons.icCheckin.svg(
            colorFilter: filter,
            width: iconSize,
            height: iconSize,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          showDialog(
            context: context,
            builder: (context) => const TicketQRCodePopup(),
          );
        },
        backgroundColor: LemonColor.paleViolet18,
        textColor: colorScheme.onPrimary,
      ),
      FeatureItem(
        label: t.event.configuration.rewards,
        iconData: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icReward.svg(
            colorFilter: filter,
            width: iconSize,
            height: iconSize,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          AutoRouter.of(context).navigate(const GuestEventRewardUsesRoute());
        },
      ),
      if (event.subeventParent == null && event.subeventEnabled == true)
        FeatureItem(
          label: t.event.subEvent.subEvents,
          iconData: ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icSessions.svg(
              colorFilter: filter,
              width: iconSize,
              height: iconSize,
            ),
          ),
          onTap: () {
            Vibrate.feedback(FeedbackType.light);
            AutoRouter.of(context).navigate(
              SubEventsListingRoute(parentEventId: event.id ?? ''),
            );
          },
        ),
      FeatureItem(
        label: t.event.configuration.lounge,
        iconData: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icLounge.svg(
            colorFilter: filter,
            width: iconSize,
            height: iconSize,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          AutoRouter.of(context).navigate(const GuestEventStoriesRoute());
        },
      ),
      if (shouldShowProgram)
        FeatureItem(
          label: t.event.configuration.program,
          iconData: ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icProgram.svg(
              colorFilter: filter,
              width: iconSize,
              height: iconSize,
            ),
          ),
          onTap: () {
            Vibrate.feedback(FeedbackType.light);
            AutoRouter.of(context).navigate(const EventProgramRoute());
          },
        ),
      // FeatureItem(
      //   label: t.event.configuration.faq,
      //   iconData: ThemeSvgIcon(
      //     builder: (filter) => Assets.icons.icFaq.svg(
      //       colorFilter: filter,
      //       width: iconSize,
      //       height: iconSize,
      //     ),
      //   ),
      //   onTap: () {
      //     Vibrate.feedback(FeedbackType.light);
      //     SnackBarUtils.showComingSoon();
      //   },
      // ),
      // FeatureItem(
      //   label: t.event.configuration.info,
      //   iconData: ThemeSvgIcon(
      //     color: colorScheme.onSecondary,
      //     builder: (filter) => Assets.icons.icInfo
      //         .svg(colorFilter: filter, width: iconSize, height: iconSize),
      //   ),
      //   onTap: () {
      //     Vibrate.feedback(FeedbackType.light);
      //     SnackBarUtils.showComingSoon();
      //   },
      // ),
    ];
    return features;
  }

  static List<FeatureItem> getEventFeaturesForHost({
    required BuildContext context,
    required Event event,
    bool? isSmallIcon = true,
    required EventUserRole? eventUserRole,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconSize = isSmallIcon == true ? 18.w : 24.w;
    final shouldShowProgram = (event.sessions ?? []).isNotEmpty;
    final featureManager =
        FeatureManager(EventRoleBasedEventFeatureVisibilityStrategy());
    final canShowCheckIn =
        featureManager.canShowCheckin(eventUserRole: eventUserRole);
    final canShowGuestList =
        featureManager.canShowGuestList(eventUserRole: eventUserRole);
    final canShowEventSettings =
        featureManager.canShowEventSettings(eventUserRole: eventUserRole);
    final canShowDashboard =
        featureManager.canShowDashboard(eventUserRole: eventUserRole);
    final List<FeatureItem> features = [
      if (canShowCheckIn)
        FeatureItem(
          label: t.event.configuration.checkIn,
          iconData: ThemeSvgIcon(
            color: LemonColor.paleViolet,
            builder: (filter) => Assets.icons.icCheckin.svg(
              colorFilter: filter,
              width: iconSize,
              height: iconSize,
            ),
          ),
          onTap: () {
            Vibrate.feedback(FeedbackType.light);
            AutoRouter.of(context).navigate(
              ScanQRCheckinRewardsRoute(
                event: event,
              ),
            );
          },
          backgroundColor: LemonColor.paleViolet18,
          textColor: colorScheme.onPrimary,
        ),
      FeatureItem(
        label: t.event.configuration.rewards,
        iconData: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icReward.svg(
            colorFilter: filter,
            width: iconSize,
            height: iconSize,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          AutoRouter.of(context).navigate(
            const EventRewardSettingRoute(),
          );
        },
      ),
      if (event.subeventParent == null && event.subeventEnabled == true)
        FeatureItem(
          label: t.event.subEvent.subEvents,
          iconData: ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icSessions.svg(
              colorFilter: filter,
              width: iconSize,
              height: iconSize,
            ),
          ),
          onTap: () {
            Vibrate.feedback(FeedbackType.light);
            AutoRouter.of(context).navigate(
              SubEventsListingRoute(parentEventId: event.id ?? ''),
            );
          },
        ),
      FeatureItem(
        label: t.event.configuration.lounge,
        iconData: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icLounge.svg(
            colorFilter: filter,
            width: iconSize,
            height: iconSize,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          AutoRouter.of(context).navigate(const GuestEventStoriesRoute());
        },
      ),
      if (canShowGuestList)
        FeatureItem(
          label: t.event.configuration.guests,
          iconData: ThemeSvgIcon(
            builder: (filter) => Assets.icons.icGuests.svg(
              colorFilter: filter,
              width: iconSize,
              height: iconSize,
            ),
          ),
          onTap: () {
            Vibrate.feedback(FeedbackType.light);
            AutoRouter.of(context).push(
              EventApprovalSettingRoute(),
            );
          },
        ),
      if (shouldShowProgram)
        FeatureItem(
          label: t.event.configuration.program,
          iconData: ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icProgram.svg(
              colorFilter: filter,
              width: iconSize,
              height: iconSize,
            ),
          ),
          onTap: () {
            Vibrate.feedback(FeedbackType.light);
            AutoRouter.of(context).navigate(const EventProgramRoute());
          },
        ),
      // FeatureItem(
      //   label: t.event.configuration.faq,
      //   iconData: ThemeSvgIcon(
      //     builder: (filter) => Assets.icons.icFaq.svg(
      //       colorFilter: filter,
      //       width: iconSize,
      //       height: iconSize,
      //     ),
      //   ),
      //   onTap: () {
      //     Vibrate.feedback(FeedbackType.light);
      //     SnackBarUtils.showComingSoon();
      //   },
      // ),
      // FeatureItem(
      //   label: t.event.configuration.info,
      //   iconData: ThemeSvgIcon(
      //     color: colorScheme.onSecondary,
      //     builder: (filter) => Assets.icons.icInfo.svg(
      //       colorFilter: filter,
      //       width: iconSize,
      //       height: iconSize,
      //     ),
      //   ),
      //   onTap: () {
      //     Vibrate.feedback(FeedbackType.light);
      //     SnackBarUtils.showComingSoon();
      //   },
      // ),
      if (canShowEventSettings)
        FeatureItem(
          label: t.event.configuration.controlPanel,
          iconData: ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icSettings.svg(
              colorFilter: filter,
              width: iconSize,
              height: iconSize,
            ),
          ),
          onTap: () {
            Vibrate.feedback(FeedbackType.light);
            AutoRouter.of(context).push(
              const EventControlPanelRoute(),
            );
          },
        ),
      if (canShowDashboard)
        FeatureItem(
          label: t.event.configuration.dashboard,
          iconData: ThemeSvgIcon(
            builder: (filter) => Assets.icons.icDashboard.svg(
              colorFilter: filter,
              width: iconSize,
              height: iconSize,
            ),
          ),
          onTap: () {
            Vibrate.feedback(FeedbackType.light);
            AutoRouter.of(context).push(
              EventDashboardRoute(
                eventId: event.id ?? '',
              ),
            );
          },
        ),
    ];
    return features;
  }
}
