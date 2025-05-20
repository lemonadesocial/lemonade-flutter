import 'package:app/app_theme/app_theme.dart';
import 'package:app/app_theme/colors/app_colors_extension.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

enum EventAttendanceStatus {
  hosting,
  going,
  pending,
}

class HomeEventCardFooter extends StatelessWidget {
  final EventAttendanceStatus status;

  const HomeEventCardFooter({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final appTextTheme = Theme.of(context).appTextTheme;

    return SizedBox(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.s2,
              vertical: Spacing.s1,
            ),
            decoration: BoxDecoration(
              color: _getBadgeColor(appColors),
              borderRadius: BorderRadius.circular(LemonRadius.xs),
            ),
            child: Text(
              _getBadgeText(),
              style: appTextTheme.sm.copyWith(
                color: _getTextColor(appColors),
              ),
            ),
          ),
          if (status != EventAttendanceStatus.pending) ...[
            SizedBox(width: Spacing.s2),
            Container(
              width: Spacing.s6,
              height: Spacing.s6,
              decoration: BoxDecoration(
                color: appColors.cardBg,
                borderRadius: BorderRadius.circular(LemonRadius.xs),
                border: Border.all(
                  color: appColors.cardBorder,
                ),
              ),
              child: Center(
                child: Icon(
                  status == EventAttendanceStatus.hosting
                      ? Icons.settings_outlined
                      : Icons.confirmation_number_outlined,
                  size: Spacing.s4,
                  color: appColors.textTertiary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getBadgeColor(AppColorsExtension colors) {
    switch (status) {
      case EventAttendanceStatus.hosting:
        return colors.chipPrimaryBg;
      case EventAttendanceStatus.going:
        return colors.buttonSuccessBg;
      case EventAttendanceStatus.pending:
        return colors.buttonWarningBg;
    }
  }

  Color _getTextColor(AppColorsExtension colors) {
    switch (status) {
      case EventAttendanceStatus.hosting:
        return colors.chipPrimary;
      case EventAttendanceStatus.going:
        return colors.buttonPrimary;
      case EventAttendanceStatus.pending:
        return colors.buttonPrimary;
    }
  }

  String _getBadgeText() {
    switch (status) {
      case EventAttendanceStatus.hosting:
        return 'Hosting';
      case EventAttendanceStatus.going:
        return 'Going';
      case EventAttendanceStatus.pending:
        return 'Pending';
    }
  }
}
