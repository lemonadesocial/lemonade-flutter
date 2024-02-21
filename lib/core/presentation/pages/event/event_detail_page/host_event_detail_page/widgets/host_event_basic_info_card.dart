import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:slang/builder/utils/string_extensions.dart';

class HostEventBasicInfoCard extends StatelessWidget {
  const HostEventBasicInfoCard({
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
        return Column(
          children: [
            Container(
              height: 78.w,
              decoration: BoxDecoration(
                color: colorScheme.onPrimary.withOpacity(0.06),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.r),
                  topLeft: Radius.circular(15.r),
                  bottomLeft: Radius.circular(6.r),
                  bottomRight: Radius.circular(6.r),
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.r),
                        topLeft: Radius.circular(15.r),
                        bottomLeft: Radius.circular(6.r),
                        bottomRight: Radius.circular(6.r),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              colorScheme.onPrimary.withOpacity(0.03),
                              colorScheme.onPrimary.withOpacity(0.01),
                            ],
                            begin: Alignment.topLeft,
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
                                      border: Border.all(
                                          color: colorScheme.outline),
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
                                        imageUrl:
                                            EventUtils.getEventThumbnailUrl(
                                          event: event,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            ImagePlaceholder
                                                .defaultPlaceholder(),
                                        placeholder: (context, url) =>
                                            ImagePlaceholder
                                                .defaultPlaceholder(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Spacing.small),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event.title ?? '',
                                        style: Typo.small.copyWith(
                                          color: colorScheme.onSecondary,
                                          fontWeight: FontWeight.w400,
                                          fontFamily:
                                              FontFamily.switzerVariable,
                                        ),
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
                                                      ? (durationToEvent
                                                                      ?.inHours ??
                                                                  0) >=
                                                              1
                                                          ? DurationTersity.hour
                                                          : DurationTersity
                                                              .minute
                                                      : DurationTersity.day,
                                                  upperTersity:
                                                      DurationTersity.day,
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.smMedium,
                        ),
                        child: Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: ShapeDecoration(
                            color: LemonColor.white06,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(LemonRadius.xSmall),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Vibrate.feedback(FeedbackType.light);
                              AutoRouter.of(context)
                                  .navigate(const EventControlPanelRoute());
                            },
                            child: Center(
                              child: ThemeSvgIcon(
                                color: colorScheme.onSecondary,
                                builder: (filter) => Assets.icons.icEdit.svg(
                                  width: 15.w,
                                  height: 15.w,
                                  colorFilter: filter,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Spacing.extraSmall,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 73.w,
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary.withOpacity(0.06),
                      borderRadius: BorderRadius.all(Radius.circular(6.r)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: Spacing.smMedium),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TODO: Will fill ? with real value after confirm with Designer
                          Text(
                            '?',
                            style: Typo.extraMedium
                                .copyWith(color: colorScheme.onPrimary),
                          ),
                          Text(t.event.scanQR.checkedIn,
                              style: Typo.small
                                  .copyWith(color: colorScheme.onSecondary)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Spacing.extraSmall,
                ),
                Expanded(
                  child: Container(
                    height: 73.w,
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary.withOpacity(0.06),
                      borderRadius: BorderRadius.all(Radius.circular(6.r)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: Spacing.smMedium),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TODO: Will fill ? with real value after confirm with Designer
                          Text(
                            '?',
                            style: Typo.extraMedium
                                .copyWith(color: colorScheme.onPrimary),
                          ),
                          Text(
                            t.event.attending,
                            style: Typo.small
                                .copyWith(color: colorScheme.onSecondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Spacing.extraSmall,
                ),
                Expanded(
                  child: Container(
                    height: 73.w,
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary.withOpacity(0.06),
                      borderRadius: BorderRadius.all(Radius.circular(6.r)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: Spacing.smMedium),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.invitedCount?.toString() ?? '',
                            style: Typo.extraMedium
                                .copyWith(color: colorScheme.onPrimary),
                          ),
                          Text(
                            t.event.invited.capitalize(),
                            style: Typo.small
                                .copyWith(color: colorScheme.onSecondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Spacing.extraSmall,
            ),
            InkWell(
              onTap: () {
                Vibrate.feedback(FeedbackType.light);
                showComingSoonDialog(context);
              },
              child: Container(
                height: 54.w,
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.06),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15.r),
                    bottomLeft: Radius.circular(15.r),
                    topLeft: Radius.circular(6.r),
                    topRight: Radius.circular(6.r),
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
                                    Center(
                                      child: Assets.icons.icError.svg(
                                        width: Sizing.small,
                                        height: Sizing.small,
                                      ),
                                    ),
                                    SizedBox(width: Spacing.small),
                                    Text(
                                      t.event.eventApproval.pendingRequests(
                                        n: event.pending?.length ?? 0,
                                        count: event.pending?.length ?? 0,
                                      ),
                                      style: Typo.medium.copyWith(
                                        color: colorScheme.onSecondary,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            SizedBox(
                              width: Sizing.xLarge,
                              child: Center(
                                child: Assets.icons.icArrowBack.svg(
                                  width: 25.w,
                                  height: 25.w,
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
            ),
          ],
        );
      },
    );
  }
}
