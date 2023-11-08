import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_payment.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTicketCard extends StatelessWidget {
  final Event event;
  final EventPayment? eventPayment;

  const MyTicketCard({
    super.key,
    required this.event,
    this.eventPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TicketCardTop(
          event: event,
          eventPayment: eventPayment,
        ),
        TicketCardBottom(
          event: event,
        ),
      ],
    );
  }
}

class TicketCardTop extends StatelessWidget {
  final Event event;
  final EventPayment? eventPayment;

  const TicketCardTop({
    super.key,
    required this.event,
    this.eventPayment,
  });

  String get ticketTitle {
    if (eventPayment == null) {
      return t.event.free.toUpperCase();
    }
    PurchasableTicketType? ticketType =
        List.from(event.eventTicketTypes ?? []).firstWhere(
      (item) => item.id == eventPayment?.ticketType,
      orElse: () => null,
    );

    return '${ticketType?.title ?? ''} - ${NumberUtils.formatCurrency(
      amount: ticketType?.defaultPrice?.fiatCost?.toDouble() ?? 0,
      currency: event.currency,
    )}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        ClipRRect(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: colorScheme.outline,
                  width: 1.w,
                ),
                right: BorderSide(
                  color: colorScheme.outline,
                  width: 1.w,
                ),
                left: BorderSide(
                  color: colorScheme.outline,
                  width: 1.w,
                ),
                bottom: BorderSide(
                  color: colorScheme.outline,
                  width: 0.w,
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              ),
            ),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(Spacing.medium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        ticketTitle.toUpperCase(),
                        style: Typo.mediumPlus.copyWith(
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.spaceGrotesk,
                        ),
                      ),
                      SizedBox(height: Spacing.smMedium),
                      Text(
                        event.title?.toUpperCase() ?? '',
                        style: Typo.mediumPlus.copyWith(
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.spaceGrotesk,
                        ),
                      ),
                      SizedBox(
                        height: 2.w,
                      ),
                      Text(
                        DateFormatUtils.custom(
                          event.start,
                          pattern: 'EEEE, HH:mma',
                        ),
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -15.w,
          left: -15.w,
          child: const _Circle(),
        ),
        Positioned(
          bottom: -15.w,
          right: -15.w,
          // alignment: Alignment.bottomLeft,
          child: const _Circle(),
        ),
      ],
    );
  }
}

class TicketCardBottom extends StatelessWidget {
  final Event event;

  const TicketCardBottom({
    super.key,
    required this.event,
  });

  String get eventDetailAddress {
    return [event.address?.title, event.address?.city, event.address?.region]
        .where((item) => item != null)
        .join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(Spacing.medium),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outline, width: 1.w),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.r),
              bottomRight: Radius.circular(15.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Assets.icons.icLocationPin.svg(),
                  Assets.icons.icQr.svg(),
                ],
              ),
              SizedBox(height: Spacing.extraSmall),
              Text(
                event.address?.title ?? '',
                style: Typo.mediumPlus.copyWith(
                  color: colorScheme.onPrimary.withOpacity(0.87),
                ),
              ),
              Text(
                eventDetailAddress,
                style: Typo.medium.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -15.w,
          left: -15.w,
          child: const _Circle(),
        ),
        Positioned(
          top: -15.w,
          right: -15.w,
          // alignment: Alignment.bottomLeft,
          child: const _Circle(),
        ),
      ],
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 30.w,
      height: 30.w,
      decoration: BoxDecoration(
        color: colorScheme.background,
        border: Border.all(color: colorScheme.outline, width: 1.w),
        borderRadius: BorderRadius.circular(30.r),
      ),
    );
  }
}
