import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_detail_page/widgets/event_join_request_status_history_step.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/join_request_user_avatar.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventJoinRequestStatusHistory extends StatelessWidget {
  final EventJoinRequest eventJoinRequest;
  const EventJoinRequestStatusHistory({
    super.key,
    required this.eventJoinRequest,
  });

  bool get isPending => eventJoinRequest.isPending;

  bool get isRejected => eventJoinRequest.isDeclined;

  Widget _declinedBadge(BuildContext context) => InkWell(
        onTap: () => SnackBarUtils.showComingSoon(),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: Spacing.superExtraSmall,
            horizontal: Spacing.extraSmall,
          ),
          decoration: BoxDecoration(
            color: LemonColor.darkBackground,
            borderRadius: BorderRadius.circular(LemonRadius.xSmall),
          ),
          child: Row(
            children: [
              Text(
                t.event.eventApproval.declined,
                style: Typo.small.copyWith(
                  color: LemonColor.coralReef,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: Spacing.superExtraSmall),
              ThemeSvgIcon(
                color: Theme.of(context).colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icArrowDown.svg(
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                  colorFilter: filter,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final steps = [
      EventJoinRequestStatusHistoryStep(
        leading: JoinRequestUserAvatar(
          eventJoinRequest: eventJoinRequest,
        ),
        title: '',
        subTitle: '',
        more: isRejected ? _declinedBadge(context) : null,
      ),
      EventJoinRequestStatusHistoryStep(
        leading: const EventJoinrequestStatusHistoryIcon(
          status: EventJoinRequestHistoryStatus.done,
        ),
        title: t.event.eventApproval.appliedForReservation,
        subTitle: DateFormatUtils.custom(
          eventJoinRequest.createdAt,
          pattern: 'dd, MMM, HH:mm',
        ),
      ),
      EventJoinRequestStatusHistoryStep(
        leading: EventJoinrequestStatusHistoryIcon(
          status: isPending
              ? EventJoinRequestHistoryStatus.pending
              : isRejected
                  ? EventJoinRequestHistoryStatus.rejected
                  : EventJoinRequestHistoryStatus.done,
        ),
        title: isPending
            ? t.event.eventApproval.pendingApproval
            : isRejected
                ? t.event.eventApproval.declinedBy(
                    name:
                        '@${eventJoinRequest.decidedByExpanded?.username ?? ''}',
                  )
                : t.event.eventApproval.approvedBy(
                    name:
                        '@${eventJoinRequest.decidedByExpanded?.username ?? ''}',
                  ),
        subTitle: isPending
            ? t.event.eventApproval.approveToLetThemIn
            : DateFormatUtils.custom(
                eventJoinRequest.decidedAt,
                pattern: 'dd, MMM, HH:mm',
              ),
      ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            _Background(length: steps.length),
            const Positioned.fill(
              child: _DashLine(),
            ),
            Positioned.fill(
              child: _StepContainer(
                children: steps,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Background extends StatelessWidget {
  final int length;
  const _Background({
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(length, (index) {
        final isFirst = index == 0;
        final isLast = index == length - 1;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Spacing.small + Sizing.medium,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.onPrimary.withOpacity(0.06),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    isFirst ? LemonRadius.medium : LemonRadius.extraSmall,
                  ),
                  topRight: Radius.circular(
                    isFirst ? LemonRadius.medium : LemonRadius.extraSmall,
                  ),
                  bottomLeft: Radius.circular(
                    isLast ? LemonRadius.medium : LemonRadius.extraSmall,
                  ),
                  bottomRight: Radius.circular(
                    isLast ? LemonRadius.medium : LemonRadius.extraSmall,
                  ),
                ),
              ),
            ),
            if (!isLast) SizedBox(height: Spacing.extraSmall),
          ],
        );
      }),
    );
  }
}

class _StepContainer extends StatelessWidget {
  final List<Widget> children;
  const _StepContainer({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Spacing.small,
                top: Spacing.small / 2,
                bottom: Spacing.small / 2,
                right: Spacing.small,
              ),
              height: constraints.maxHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: children,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DashLine extends StatelessWidget {
  const _DashLine();

  double get thickness => 2.w;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: Spacing.small + (Sizing.medium / 2) - (thickness / 2),
                    top: Spacing.small,
                  ),
                  height: constraints.maxHeight - Spacing.small,
                  child: DottedLine(
                    direction: Axis.vertical,
                    lineThickness: thickness,
                    dashColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
