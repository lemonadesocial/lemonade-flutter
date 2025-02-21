import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class PaymentDetailUserInfoWidget extends StatelessWidget {
  final Payment payment;
  const PaymentDetailUserInfoWidget({
    super.key,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      children: [
        Row(
          children: [
            LemonNetworkImage(
              imageUrl: payment.buyerAvatar,
              width: Sizing.medium,
              height: Sizing.medium,
              borderRadius: BorderRadius.circular(Sizing.medium),
              placeholder: ImagePlaceholder.avatarPlaceholder(),
            ),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment.buyerName,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    payment.buyerEmail,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (payment.joinRequest != null)
              _ApprovalStatus(
                joinRequest: payment.joinRequest!,
              ),
          ],
        ),
        SizedBox(
          height: Spacing.medium,
        ),
        Row(
          children: [
            if (payment.stamps?['initialized'] != null) ...[
              _InfoItem(
                title: 'Registered on',
                value: DateFormatUtils.custom(
                  payment.stamps?['initialized']!,
                  pattern: 'dd MMM, hh:mm a',
                ),
              ),
              SizedBox(
                height: Sizing.medium,
                child: VerticalDivider(
                  color: colorScheme.outline,
                  thickness: 1,
                  width: Spacing.large,
                ),
              ),
            ],
            _InfoItem(
              title: 'Tickets',
              value:
                  '${payment.tickets?.length} ${t.event.tickets(n: payment.tickets?.length ?? 0)}',
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String value;
  const _InfoItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Typo.small.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        Text(
          value,
          style: Typo.medium.copyWith(
            color: colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}

class _ApprovalStatus extends StatelessWidget {
  final EventJoinRequest joinRequest;
  const _ApprovalStatus({
    required this.joinRequest,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Color? color = LemonColor.malachiteGreen;
    String displayText = 'Peding';
    if (joinRequest.isPending) {
      displayText = 'Pending';
      color = colorScheme.onSecondary;
    } else if (joinRequest.isDeclined) {
      displayText = 'Declined';
      color = LemonColor.coralReef;
    } else if (joinRequest.isApproved) {
      displayText = 'Going';
      color = LemonColor.malachiteGreen;
    }

    return Container(
      padding: EdgeInsets.all(
        Spacing.superExtraSmall,
      ),
      decoration: BoxDecoration(
        color: LemonColor.chineseBlack,
        borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        border: Border.all(
          color: colorScheme.outline,
        ),
      ),
      child: Text(
        displayText,
        style: Typo.small.copyWith(
          color: color,
        ),
      ),
    );
  }
}
