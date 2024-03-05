import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/modal_utils.dart';
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
  final ThemeSvgIcon iconData;
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
}

class EventDetailNavigationBarHelper {
  static List<FeatureItem> getEventFeaturesForGuest(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final List<FeatureItem> features = [
      FeatureItem(
        label: t.event.configuration.checkIn,
        iconData: ThemeSvgIcon(
          color: LemonColor.paleViolet,
          builder: (filter) => Assets.icons.icCheckin.svg(
            colorFilter: filter,
            width: 18.w,
            height: 18.w,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          showComingSoonDialog(context);
        },
        backgroundColor: LemonColor.paleViolet18,
        textColor: colorScheme.onPrimary,
      ),
      FeatureItem(
        label: t.event.configuration.rewards,
        iconData: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icReward.svg(
            colorFilter: filter,
            width: 18.w,
            height: 18.w,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          showComingSoonDialog(context);
        },
      ),
      FeatureItem(
        label: t.event.configuration.lounge,
        iconData: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icLounge.svg(
            colorFilter: filter,
            width: 18.w,
            height: 18.w,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          showComingSoonDialog(context);
        },
      ),
      FeatureItem(
        label: t.event.configuration.program,
        iconData: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icProgram.svg(
            colorFilter: filter,
            width: 18.w,
            height: 18.w,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          AutoRouter.of(context).navigate(const EventProgramRoute());
        },
      ),
      FeatureItem(
        label: t.event.configuration.faq,
        iconData: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icFaq.svg(
            colorFilter: filter,
            width: 18.w,
            height: 18.w,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          showComingSoonDialog(context);
        },
      ),
      FeatureItem(
        label: t.event.configuration.info,
        iconData: ThemeSvgIcon(
          color: colorScheme.onSecondary,
          builder: (filter) => Assets.icons.icInfo.svg(
            colorFilter: filter,
            width: 18.w,
            height: 18.w,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          showComingSoonDialog(context);
        },
      ),
    ];
    return features;
  }

  static List<FeatureItem> getEventFeaturesForHost(
    BuildContext context,
    bool isSmallIcon,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconSize = isSmallIcon ? 18.w : 24.w;
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
          showComingSoonDialog(context);
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
          showComingSoonDialog(context);
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
          showComingSoonDialog(context);
        },
      ),
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
          showComingSoonDialog(context);
        },
      ),
      FeatureItem(
        label: t.event.configuration.program,
        iconData: ThemeSvgIcon(
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
      FeatureItem(
        label: t.event.configuration.faq,
        iconData: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icFaq.svg(
            colorFilter: filter,
            width: iconSize,
            height: iconSize,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          showComingSoonDialog(context);
        },
      ),
      FeatureItem(
        label: t.event.configuration.info,
        iconData: ThemeSvgIcon(
          color: colorScheme.onSecondary,
          builder: (filter) => Assets.icons.icInfo.svg(
            colorFilter: filter,
            width: iconSize,
            height: iconSize,
          ),
        ),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          showComingSoonDialog(context);
        },
      ),
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
          showComingSoonDialog(context);
        },
      ),
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
          showComingSoonDialog(context);
        },
      ),
    ];
    return features;
  }
}
