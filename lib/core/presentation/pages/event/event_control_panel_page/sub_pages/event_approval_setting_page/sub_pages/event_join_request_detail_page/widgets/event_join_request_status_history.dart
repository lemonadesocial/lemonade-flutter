import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_detail_page/widgets/escrow_first_deposit_amount_builder.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_detail_page/widgets/event_join_request_escrow_payment_status_widget.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_detail_page/widgets/event_join_request_payment_amount_builder.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_detail_page/widgets/event_join_request_payment_status_widget.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_detail_page/widgets/event_join_request_status_history_step.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/event_join_request_ticket_info.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/join_request_user_avatar.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/modal_utils.dart';
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

  Widget _declinedBadge(BuildContext context) => InkWell(
        onTap: () => showComingSoonDialog(context),
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
    final colorScheme = Theme.of(context).colorScheme;

    final steps = [
      EventJoinRequestStatusHistoryStep(
        leading: JoinRequestUserAvatar(
          user: eventJoinRequest.userExpanded,
        ),
        title: '',
        subTitle: '',
        more: isRejected
            ? _declinedBadge(context)
            : EventJoinRequestTicketInfo(
                eventJoinRequest: eventJoinRequest,
                showPrice: false,
                padding: EdgeInsets.all(Spacing.extraSmall),
                backgroundColor: LemonColor.darkBackground,
                borderColor: Colors.transparent,
              ),
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
        more: EventJoinRequestPaymentAmountsBuilder(
          eventId: eventJoinRequest.eventExpanded?.id ?? '',
          eventJoinRequest: eventJoinRequest,
          builder: ({
            required formattedTotalAmount,
            required formattedDueAmount,
            required formattedDepositAmount,
          }) {
            final isEscrow =
                eventJoinRequest.paymentExpanded?.accountExpanded?.type ==
                    PaymentAccountType.ethereumEscrow;
            if (!isEscrow &&
                eventJoinRequest.paymentExpanded?.state !=
                    PaymentState.succeeded) {
              return const SizedBox.shrink();
            }

            if (formattedTotalAmount.isEmpty ||
                formattedDepositAmount.isEmpty) {
              return const SizedBox.shrink();
            }
            return EscrowFirstDepositAmountBuilder(
              eventJoinRequest: eventJoinRequest,
              builder: ({
                required formattedFirstDepositAmount,
                required formattedFirstDueAmount,
                required isLoading,
              }) {
                if (isEscrow) {
                  if (isLoading) {
                    return Loading.defaultLoading(context);
                  }
                  return RichText(
                    text: TextSpan(
                      text: '$formattedFirstDepositAmount ',
                      style: Typo.small.copyWith(
                        color: LemonColor.malachiteGreen,
                      ),
                      children: [
                        TextSpan(
                          text: t.event.eventApproval.payment.paid,
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RichText(
                  text: TextSpan(
                    text: '$formattedTotalAmount ',
                    style: Typo.small.copyWith(
                      color: LemonColor.malachiteGreen,
                    ),
                    children: [
                      TextSpan(
                        text: t.event.eventApproval.payment.paid,
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
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
      if (eventJoinRequest.paymentExpanded != null &&
          eventJoinRequest.paymentExpanded?.accountExpanded?.type ==
              PaymentAccountType.ethereumEscrow &&
          !eventJoinRequest.isPending)
        EventJoinRequestEscrowPaymentStatusWidget(
          eventJoinRequest: eventJoinRequest,
        ),
      if (eventJoinRequest.paymentExpanded != null &&
          eventJoinRequest.paymentExpanded?.accountExpanded?.type !=
              PaymentAccountType.ethereumEscrow &&
          eventJoinRequest.isApproved)
        EventJoinRequestPaymentStatusWidget(eventJoinRequest: eventJoinRequest),
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
