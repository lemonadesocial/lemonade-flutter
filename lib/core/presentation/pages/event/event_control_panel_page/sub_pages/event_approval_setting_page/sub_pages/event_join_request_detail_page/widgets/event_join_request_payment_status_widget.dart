import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_detail_page/widgets/event_join_request_payment_amount_builder.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_detail_page/widgets/event_join_request_status_history_step.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class EventJoinRequestPaymentStatusWidget extends StatelessWidget {
  final EventJoinRequest eventJoinRequest;
  const EventJoinRequestPaymentStatusWidget({
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

    return EventJoinRequestPaymentAmountsBuilder(
      eventJoinRequest: eventJoinRequest,
      eventId: eventJoinRequest.eventExpanded?.id ?? '',
      builder: ({
        required formattedDueAmount,
        required formattedDepositAmount,
        required formattedTotalAmount,
      }) {
        if (eventJoinRequest.isApproved) {
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
                      ? ''
                      : '',
            ),
            more: RichText(
              text: TextSpan(
                text: '$formattedTotalAmount ',
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
        }

        return const SizedBox.shrink();
      },
    );
  }
}
