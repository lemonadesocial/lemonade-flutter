import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_list_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/map_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTicketCard extends StatelessWidget {
  final Event event;
  final EventTicket? eventTicket;
  final PurchasableTicketType? ticketType;

  const MyTicketCard({
    super.key,
    required this.event,
    this.eventTicket,
    this.ticketType,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        TicketCardTop(
          event: event,
          eventTicket: eventTicket,
          ticketType: ticketType,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w),
          child: DottedLine(
            lineThickness: 2.w,
            dashRadius: 10,
            dashLength: 8.w,
            dashGapColor: colorScheme.onPrimary.withOpacity(0.06),
            dashColor: colorScheme.background,
          ),
        ),
        TicketCardBottom(
          event: event,
          eventTicket: eventTicket,
          ticketType: ticketType,
        ),
      ],
    );
  }
}

class TicketCardTop extends StatelessWidget {
  final Event event;
  final EventTicket? eventTicket;
  final PurchasableTicketType? ticketType;

  const TicketCardTop({
    super.key,
    required this.event,
    this.eventTicket,
    this.ticketType,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withOpacity(0.06),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        ),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(Spacing.medium),
            child: Row(
              children: [
                Container(
                  width: 42.w,
                  height: 42.w,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                  ),
                  child: CachedNetworkImage(
                    // TODO: ticketType.photosExpanded
                    imageUrl: '',
                    errorWidget: (_, __, ___) =>
                        ImagePlaceholder.defaultPlaceholder(),
                    placeholder: (_, __) =>
                        ImagePlaceholder.defaultPlaceholder(),
                  ),
                ),
                SizedBox(width: Spacing.small),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title ?? '',
                      style: Typo.mediumPlus.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 2.w,
                    ),
                    Text(
                      ticketType?.title ?? '',
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                )
              ],
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
      ),
    );
  }
}

class TicketCardBottom extends StatelessWidget {
  final Event event;
  final EventTicket? eventTicket;
  final PurchasableTicketType? ticketType;

  const TicketCardBottom({
    super.key,
    required this.event,
    this.eventTicket,
    this.ticketType,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final labelTextStyle = Typo.small.copyWith(
      color: colorScheme.onSurfaceVariant,
    );
    final valueTextStyle = Typo.medium.copyWith(
      color: colorScheme.onPrimary.withOpacity(0.87),
    );
    final t = Translations.of(context);

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withOpacity(0.06),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r),
        ),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(Spacing.medium),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 80.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.common.date,
                                  style: labelTextStyle,
                                ),
                                SizedBox(height: 2.w),
                                Text(
                                  '${DateFormatUtils.custom(event.start, pattern: 'dd MMM yy')} -\n${DateFormatUtils.custom(event.end, pattern: 'dd MMM yy')}',
                                  style: valueTextStyle,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: Spacing.xSmall),
                          SizedBox(
                            width: 80.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.common.time,
                                  style: labelTextStyle,
                                ),
                                SizedBox(height: 2.w),
                                Text(
                                  DateFormatUtils.timeOnly(event.start),
                                  style: valueTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Spacing.xSmall),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.common.location,
                            style: labelTextStyle,
                          ),
                          SizedBox(height: 2.w),
                          FutureBuilder(
                            future: MapUtils.getLocationName(
                              lat: event.latitude ?? 0,
                              lng: event.longitude ?? 0,
                            ),
                            builder: (context, snapshot) => Text(
                              snapshot.data ?? '',
                              style: valueTextStyle,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                //TODO: Fake QR code
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(LemonRadius.extraSmall),
                    ),
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
      ),
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
        borderRadius: BorderRadius.circular(30.r),
      ),
    );
  }
}
