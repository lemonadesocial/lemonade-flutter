import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/event_join_request_ticket_info.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/join_request_user_avatar.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
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

  bool get isPending =>
      eventJoinRequest.approvedBy == null &&
      eventJoinRequest.declinedBy == null;

  bool get isRejected => eventJoinRequest.declinedBy != null;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            const _Background(length: 3),
            const Positioned.fill(
              child: _DashLine(),
            ),
            Positioned.fill(
              child: _StepContainer(
                children: [
                  _Step(
                    leading: JoinRequestUserAvatar(
                      user: eventJoinRequest.userExpanded,
                    ),
                    title: '',
                    subTitle: '',
                    more: EventJoinRequestTicketInfo(
                      eventJoinRequest: eventJoinRequest,
                      showPrice: false,
                      padding: EdgeInsets.all(Spacing.extraSmall),
                      backgroundColor: LemonColor.darkBackground,
                      borderColor: Colors.transparent,
                    ),
                  ),
                  _Step(
                    leading: const _StatusIcon(
                      status: _Status.done,
                    ),
                    title: t.event.eventApproval.appliedForReservation,
                    subTitle: DateFormatUtils.custom(
                      eventJoinRequest.createdAt,
                      pattern: 'dd, MMM, HH:mm',
                    ),
                  ),
                  _Step(
                    leading: _StatusIcon(
                      status: isPending
                          ? _Status.pending
                          : isRejected
                              ? _Status.rejected
                              : _Status.done,
                    ),
                    title: isPending
                        ? t.event.eventApproval.pendingApproval
                        : isRejected
                            ? t.event.eventApproval.declinedBy(
                                name:
                                    '@${eventJoinRequest.declinedByExpanded?.username ?? ''}',
                              )
                            : t.event.eventApproval.approvedBy(
                                name:
                                    '@${eventJoinRequest.approvedByExpanded?.username ?? ''}',
                              ),
                    subTitle: isPending
                        ? t.event.eventApproval.approveToLetThemIn
                        : DateFormatUtils.custom(
                            isRejected
                                ? eventJoinRequest.declinedAt
                                : eventJoinRequest.approvedAt,
                            pattern: 'dd, MMM, HH:mm',
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Step extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subTitle;
  final Widget? more;
  const _Step({
    required this.leading,
    required this.title,
    required this.subTitle,
    this.more,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        leading,
        SizedBox(width: Spacing.xSmall),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Typo.small.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 2.w),
            Text(
              subTitle,
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ],
        ),
        const Spacer(),
        if (more != null) more!,
      ],
    );
  }
}

enum _Status {
  pending,
  done,
  rejected,
}

class _StatusIcon extends StatelessWidget {
  final _Status status;
  const _StatusIcon({
    required this.status,
  });

  Widget getIcon(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (status == _Status.pending) {
      return Container(
        height: 9.w,
        width: 9.w,
        decoration: ShapeDecoration(
          color: colorScheme.onSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LemonRadius.xSmall),
          ),
        ),
      );
    }

    if (status == _Status.done) {
      return ThemeSvgIcon(
        color: colorScheme.onSecondary,
        builder: (filter) => Assets.icons.icDone.svg(
          width: Sizing.xSmall,
          height: Sizing.xSmall,
          colorFilter: filter,
        ),
      );
    }

    if (status == _Status.rejected) {
      return ThemeSvgIcon(
        color: colorScheme.onSecondary,
        builder: (filter) => Assets.icons.icClose.svg(
          width: Sizing.xSmall,
          height: Sizing.xSmall,
          colorFilter: filter,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizing.medium,
      width: Sizing.medium,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizing.medium),
        color: status == _Status.pending
            ? LemonColor.atomicBlack
            : LemonColor.darkBackground,
        border: Border.all(
          color: status == _Status.pending
              ? LemonColor.darkBackground
              : Colors.transparent,
          width: 2.w,
        ),
      ),
      child: Center(
        child: getIcon(context),
      ),
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
