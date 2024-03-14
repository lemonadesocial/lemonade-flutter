// ignore_for_file: dead_code

import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_detail_page/widgets/escrow_first_deposit_amount_builder.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_detail_page/widgets/escrow_refund_builder.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_detail_page/widgets/event_join_request_status_history_step.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class EventJoinRequestEscrowPaymentStatusWidget extends StatelessWidget {
  final EventJoinRequest eventJoinRequest;
  const EventJoinRequestEscrowPaymentStatusWidget({
    super.key,
    required this.eventJoinRequest,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final isPendingPayment =
        eventJoinRequest.paymentExpanded?.state == PaymentState.created ||
            eventJoinRequest.paymentExpanded?.state == PaymentState.initialized;
    final isSuccessPayment =
        eventJoinRequest.paymentExpanded?.state == PaymentState.succeeded;

    if (eventJoinRequest.isDeclined) {
      // TODO: will need to call escrow contract to get refund status
      const isRefundInProcess = true;
      return EscrowRefundBuilder(
        eventJoinRequest: eventJoinRequest,
        builder: ({
          required formattedRefundAmount,
          required isLoading,
        }) {
          return EventJoinRequestStatusHistoryStep(
            leading: const EventJoinrequestStatusHistoryIcon(
              status: isRefundInProcess
                  ? EventJoinRequestHistoryStatus.pending
                  : EventJoinRequestHistoryStatus.done,
            ),
            //TODO: need to call escrow contract to know if refund or refund complete
            title: StringUtils.capitalize(
              isRefundInProcess
                  ? t.event.eventApproval.payment.refund
                  : t.event.eventApproval.payment.refundComplete,
            ),
            subTitle: isRefundInProcess
                ? t.event.eventApproval.payment.inProcess
                : '',
            more: isLoading
                ? Loading.defaultLoading(context)
                : RichText(
                    text: TextSpan(
                      text: '$formattedRefundAmount ',
                      style: Typo.small.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                      children: [
                        TextSpan(
                          text: isRefundInProcess
                              ? t.event.eventApproval.payment.refund
                              : t.event.eventApproval.payment.refunded,
                          // style: Typo
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      );
    }

    if (eventJoinRequest.isApproved) {
      final successPaymentDate =
          eventJoinRequest.paymentExpanded?.stamps?.tryGet<DateTime>(
        PaymentState.succeeded.name,
      );

      return EscrowFirstDepositAmountBuilder(
        eventJoinRequest: eventJoinRequest,
        builder: ({
          required formattedFirstDepositAmount,
          required formattedFirstDueAmount,
          required isLoading,
        }) {
          return EventJoinRequestStatusHistoryStep(
            leading: EventJoinrequestStatusHistoryIcon(
              status: isSuccessPayment
                  ? EventJoinRequestHistoryStatus.done
                  : EventJoinRequestHistoryStatus.pending,
            ),
            title: StringUtils.capitalize(
              t.event.eventApproval.payment.fullPayment,
            ),
            subTitle: StringUtils.capitalize(
              isPendingPayment
                  ? t.event.eventApproval.payment.pending
                  : isSuccessPayment
                      ? DateFormatUtils.custom(
                          successPaymentDate,
                          pattern: 'dd, MMM, HH:mm',
                        )
                      : '',
            ),
            more: isLoading
                ? Loading.defaultLoading(context)
                : RichText(
                    text: TextSpan(
                      text: '$formattedFirstDueAmount ',
                      style: Typo.small.copyWith(
                        color: isSuccessPayment
                            ? LemonColor.malachiteGreen
                            : LemonColor.coralReef,
                      ),
                      children: [
                        TextSpan(
                          text: isSuccessPayment
                              ? t.event.eventApproval.payment.paid
                              : t.event.eventApproval.payment.pending,
                          // style: Typo
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      );
    }

    return const SizedBox.shrink();
  }
}
