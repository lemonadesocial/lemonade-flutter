import 'dart:ui';

import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';

class GuestEventDetailClock extends StatelessWidget {
  const GuestEventDetailClock({
    super.key,
    required this.event,
  });

  final Event event;

  Duration? get durationToEvent {
    if (event.start == null) return null;
    var now = DateTime.now();

    if (event.start!.isBefore(now)) return null;

    return event.start!.difference(now);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final userId = AuthUtils.getUserId(context);

    return FutureBuilder<Either<Failure, List<EventTicket>>>(
      future: getIt<EventTicketRepository>().getTickets(
        input: GetTicketsInput(
          event: event.id,
          user: userId,
        ),
      ),
      builder: (context, snapshot) {
        final eventTickets = snapshot.data?.getOrElse(() => []) ?? [];
        final myTicket = eventTickets.isNotEmpty
            ? eventTickets.firstWhereOrNull(
                (ticket) => EventTicketUtils.isTicketAssignedToMe(
                  ticket,
                  userId: userId,
                ),
              )
            : null;
        final ticketType = event.eventTicketTypes?.firstWhereOrNull(
          (type) => type.id == myTicket?.type,
        );

        return Container(
          height: 78.w,
          decoration: BoxDecoration(
            color: colorScheme.onPrimary.withOpacity(0.06),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Stack(
            children: [
              Positioned(
                left: Spacing.superExtraSmall,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: SizedBox(
                    width: 72.w,
                    height: 72.w,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: ticketType?.photosExpanded?.isNotEmpty == true
                          ? ImageUtils.generateUrl(
                              file: ticketType?.photosExpanded?.first,
                            )
                          : '',
                      errorWidget: (context, url, error) =>
                          ImagePlaceholder.ticketThumbnail(),
                      placeholder: (context, url) =>
                          ImagePlaceholder.ticketThumbnail(),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.onPrimary.withOpacity(0.02),
                          colorScheme.onPrimary.withOpacity(0.06),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Spacing.smMedium,
                            horizontal: Spacing.smMedium,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 42.w,
                                height: 42.w,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: colorScheme.outline),
                                  borderRadius: BorderRadius.circular(
                                    LemonRadius.extraSmall,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    LemonRadius.extraSmall,
                                  ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: ticketType
                                                ?.photosExpanded?.isNotEmpty ==
                                            true
                                        ? ImageUtils.generateUrl(
                                            file: ticketType
                                                ?.photosExpanded?.first,
                                          )
                                        : '',
                                    errorWidget: (context, url, error) =>
                                        ImagePlaceholder.ticketThumbnail(),
                                    placeholder: (context, url) =>
                                        ImagePlaceholder.ticketThumbnail(),
                                  ),
                                ),
                              ),
                              SizedBox(width: Spacing.small),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    durationToEvent != null
                                        ? t.event.eventStartIn(
                                            time: prettyDuration(
                                              durationToEvent!,
                                              tersity: (durationToEvent
                                                              ?.inDays ??
                                                          0) <
                                                      1
                                                  ? (durationToEvent?.inHours ??
                                                              0) >=
                                                          1
                                                      ? DurationTersity.hour
                                                      : DurationTersity.minute
                                                  : DurationTersity.day,
                                              upperTersity: DurationTersity.day,
                                            ),
                                          )
                                        : t.event.eventEnded,
                                    style: Typo.mediumPlus.copyWith(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: FontFamily.nohemiVariable,
                                    ),
                                  ),
                                  SizedBox(height: 2.w),
                                  Text(
                                    ticketType?.title ?? '',
                                    style: Typo.small.copyWith(
                                      color: colorScheme.onSecondary,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 3.w),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: SizedBox(
                            height: 80.w,
                            child: DottedLine(
                              lineThickness: 2.w,
                              direction: Axis.vertical,
                              dashColor: colorScheme.background,
                            ),
                          ),
                        ),
                        Positioned(
                          top: -9.w,
                          right: -9.w,
                          child: const _Circle(),
                        ),
                        Positioned(
                          bottom: -9.w,
                          right: -9.w,
                          child: const _Circle(),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        // color: Colors.red,
                        width: Sizing.xLarge,
                        child: InkWell(
                          onTap: () {
                            AutoRouter.of(context).navigate(
                              MyEventTicketRoute(
                                event: event,
                              ),
                            );
                          },
                          child: Center(
                            child: ThemeSvgIcon(
                              color: colorScheme.onSecondary,
                              builder: (filter) => Assets.icons.icQr.svg(
                                colorFilter: filter,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -9.w,
                        left: -9.w,
                        child: const _Circle(),
                      ),
                      Positioned(
                        bottom: -9.w,
                        left: -9.w,
                        child: const _Circle(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 18.w,
      height: 18.w,
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: BorderRadius.circular(LemonRadius.normal),
      ),
    );
  }
}
