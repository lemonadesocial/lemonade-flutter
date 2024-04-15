import 'package:app/core/application/event_tickets/get_my_tickets_bloc/get_my_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/ticket_qr_code_popup.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class GuestEventDetailBasicInfo extends StatelessWidget {
  const GuestEventDetailBasicInfo({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _EventCountDown(
          event: event,
        ),
        SizedBox(height: Spacing.extraSmall),
        const _CheckinButton(),
        SizedBox(height: Spacing.extraSmall),
        _AssignTicketsButton(event: event),
      ],
    );
  }
}

class _EventCountDown extends StatelessWidget {
  const _EventCountDown({
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

    return InkWell(
      onTap: () {
        Vibrate.feedback(FeedbackType.light);
        AutoRouter.of(context).navigate(
          MyEventTicketRoute(
            event: event,
          ),
        );
      },
      child: Container(
        height: 78.w,
        decoration: BoxDecoration(
          color: colorScheme.onPrimary.withOpacity(0.06),
          borderRadius: BorderRadius.circular(
            LemonRadius.medium,
          ),
        ),
        child: Stack(
          children: [
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
                                border: Border.all(
                                  color: colorScheme.outline,
                                ),
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
                                  imageUrl: event.newNewPhotosExpanded
                                              ?.isNotEmpty ==
                                          true
                                      ? ImageUtils.generateUrl(
                                          file:
                                              event.newNewPhotosExpanded?.first,
                                        )
                                      : '',
                                  errorWidget: (context, url, error) =>
                                      ImagePlaceholder.defaultPlaceholder(),
                                  placeholder: (context, url) =>
                                      ImagePlaceholder.defaultPlaceholder(),
                                ),
                              ),
                            ),
                            SizedBox(width: Spacing.small),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.title ?? '',
                                    style: Typo.small.copyWith(
                                      color: colorScheme.onSecondary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: Spacing.smMedium,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary.withOpacity(0.06),
                          borderRadius: BorderRadius.all(Radius.circular(9.r)),
                        ),
                        width: Sizing.medium,
                        height: Sizing.medium,
                        child: Center(
                          child: ThemeSvgIcon(
                            color: colorScheme.onSecondary,
                            builder: (filter) => Assets.icons.icTicket.svg(
                              colorFilter: filter,
                              width: 15.w,
                              height: 15.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckinButton extends StatelessWidget {
  const _CheckinButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return InkWell(
      onTap: () {
        Vibrate.feedback(FeedbackType.light);
        showDialog(
          context: context,
          builder: (context) => const TicketQRCodePopup(),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Spacing.smMedium,
          horizontal: Spacing.smMedium,
        ),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary.withOpacity(0.06),
          borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ThemeSvgIcon(
              builder: (filter) => Assets.icons.icCheckin.svg(
                width: Sizing.mSmall,
                height: Sizing.mSmall,
              ),
            ),
            SizedBox(width: Spacing.small),
            Expanded(
              child: Text(
                t.event.configuration.checkIn,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icArrowRight.svg(
                colorFilter: filter,
                width: Sizing.mSmall,
                height: Sizing.mSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssignTicketsButton extends StatelessWidget {
  final Event event;

  const _AssignTicketsButton({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(
          MyEventTicketAssignmentRoute(
            event: event,
            onAssignSuccess: () {
              context.read<GetMyTicketsBloc>().add(
                    GetMyTicketsEvent.fetch(),
                  );
            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Spacing.smMedium,
          horizontal: Spacing.smMedium,
        ),
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(LemonRadius.medium),
            bottomLeft: Radius.circular(LemonRadius.medium),
            topLeft: Radius.circular(LemonRadius.extraSmall),
            topRight: Radius.circular(LemonRadius.extraSmall),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ThemeSvgIcon(
              color: colorScheme.onPrimary,
              builder: (filter) => Assets.icons.icTicket.svg(
                colorFilter: filter,
                width: Sizing.mSmall,
                height: Sizing.mSmall,
              ),
            ),
            SizedBox(width: Spacing.small),
            Expanded(
              child: Text(
                t.event.eventBuyAdditionalTickets.assignTickets,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            BlocBuilder<GetMyTicketsBloc, GetMyTicketsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  success: (tickets) {
                    final remainingTickets = tickets
                        .where(
                          (ticket) =>
                              EventTicketUtils.isTicketNotAssigned(ticket),
                        )
                        .toList();
                    if (remainingTickets.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.xSmall,
                        vertical: Spacing.superExtraSmall,
                      ),
                      decoration: BoxDecoration(
                        color: LemonColor.coralReef.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(LemonRadius.medium),
                      ),
                      child: Center(
                        child: Text(
                          remainingTickets.length.toString(),
                          style: Typo.small.copyWith(
                            color: LemonColor.coralReef,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(width: Spacing.extraSmall),
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icArrowRight.svg(
                colorFilter: filter,
                width: Sizing.mSmall,
                height: Sizing.mSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
