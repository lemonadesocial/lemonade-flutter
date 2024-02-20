import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventJoinRequestTickesList extends StatelessWidget {
  final EventJoinRequest eventJoinRequest;
  final Event? event;

  const EventJoinRequestTickesList({
    super.key,
    required this.eventJoinRequest,
    this.event,
  });

  bool get isApproved => eventJoinRequest.approvedBy != null;

  @override
  Widget build(BuildContext context) {
    final ticketTypes = event?.eventTicketTypes ?? [];
    final ticketInfos = eventJoinRequest.ticketInfo ?? [];
    if (isApproved) {
      return FutureBuilder(
        future: getIt<EventTicketRepository>().getTickets(
          input: GetTicketsInput(
            event: event?.id,
            user: eventJoinRequest.user,
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SliverToBoxAdapter(
              child: Loading.defaultLoading(context),
            );
          }
          List<EventTicket> allTickets =
              snapshot.data?.fold((l) => [], (r) => r) ?? [];
          return SliverList.separated(
            itemCount: ticketInfos.length,
            itemBuilder: (context, index) {
              final ticketType = ticketTypes.firstWhereOrNull(
                (ticketType) => ticketType.id == ticketInfos[index].ticketType,
              );
              final sameTypeTickets = allTickets
                  .where(
                    (ticket) => ticket.type == ticketInfos[index].ticketType,
                  )
                  .toList();
              return _ApprovedTicketItem(
                ticketType: ticketType,
                ticketInfo: ticketInfos[index],
                tickets: sameTypeTickets,
                eventJoinRequest: eventJoinRequest,
                isFirst: index == 0,
                isLast: index == ticketInfos.length - 1,
              );
            },
            separatorBuilder: (context, index) =>
                SizedBox(height: Spacing.superExtraSmall),
          );
        },
      );
    }

    return SliverList.separated(
      itemCount: ticketInfos.length,
      itemBuilder: (context, index) {
        final ticketType = ticketTypes.firstWhereOrNull(
          (ticketType) => ticketType.id == ticketInfos[index].ticketType,
        );
        return _TicketItem(
          ticketType: ticketType,
          ticketInfo: ticketInfos[index],
          isFirst: index == 0,
          isLast: index == ticketInfos.length - 1,
        );
      },
      separatorBuilder: (context, index) =>
          SizedBox(height: Spacing.superExtraSmall),
    );
  }
}

class _TicketItem extends StatelessWidget {
  final EventTicketType? ticketType;
  final TicketInfo ticketInfo;
  final bool isFirst;
  final bool isLast;
  const _TicketItem({
    required this.ticketType,
    required this.ticketInfo,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            child: CachedNetworkImage(
              width: Sizing.medium,
              height: Sizing.medium,
              imageUrl: ticketType?.photosExpanded?.isNotEmpty == true
                  ? ticketType?.photosExpanded?.first.url ?? ''
                  : '',
              placeholder: (_, __) => ImagePlaceholder.ticketThumbnail(
                backgroundColor: LemonColor.darkBackground,
              ),
              errorWidget: (_, __, ___) => ImagePlaceholder.ticketThumbnail(
                backgroundColor: LemonColor.darkBackground,
              ),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ticketType?.title ?? '',
                style: Typo.small.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              // TODO: will show total amount here
            ],
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.extraSmall,
              vertical: Spacing.superExtraSmall,
            ),
            decoration: BoxDecoration(
              color: LemonColor.darkBackground,
              borderRadius: BorderRadius.circular(LemonRadius.xSmall),
            ),
            child: Row(
              children: [
                ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icTicket.svg(
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                    colorFilter: filter,
                  ),
                ),
                SizedBox(width: Spacing.superExtraSmall),
                Text(
                  '${ticketInfo.count?.toInt() ?? 0}',
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ApprovedTicketItem extends StatelessWidget {
  final EventTicketType? ticketType;
  final TicketInfo ticketInfo;
  final List<EventTicket> tickets;
  final EventJoinRequest eventJoinRequest;
  final bool isFirst;
  final bool isLast;

  const _ApprovedTicketItem({
    required this.ticketType,
    required this.ticketInfo,
    required this.tickets,
    required this.eventJoinRequest,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              borderRadius: BorderRadius.circular(LemonRadius.medium),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3.r),
                  child: CachedNetworkImage(
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                    imageUrl: ticketType?.photosExpanded?.isNotEmpty == true
                        ? ticketType?.photosExpanded?.first.url ?? ''
                        : '',
                    placeholder: (_, __) => ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icTicket.svg(
                        width: Sizing.xSmall,
                        height: Sizing.xSmall,
                        colorFilter: filter,
                      ),
                    ),
                    errorWidget: (_, __, ___) => ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icTicket.svg(
                        width: Sizing.xSmall,
                        height: Sizing.xSmall,
                        colorFilter: filter,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
                Text(
                  '${ticketType?.title ?? ''} (${ticketInfo.count?.toInt() ?? 0})',
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                const Spacer(),
                ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icArrowUp.svg(
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                    colorFilter: filter,
                  ),
                ),
              ],
            ),
          ),
          if (tickets.isNotEmpty)
            Container(
              color: colorScheme.onSecondary.withOpacity(0.03),
              padding: EdgeInsets.all(Spacing.small),
              child: Column(
                children: tickets
                    .asMap()
                    .entries
                    .map(
                      (entry) => _TicketAssignmentItem(
                        eventTicket: entry.value,
                        eventJoinRequest: eventJoinRequest,
                        isLast: entry.key == tickets.length - 1,
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class _TicketAssignmentItem extends StatelessWidget {
  final EventTicket eventTicket;
  final EventJoinRequest eventJoinRequest;
  final bool isLast;

  const _TicketAssignmentItem({
    required this.eventTicket,
    required this.eventJoinRequest,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return FutureBuilder(
      future: getIt<UserRepository>().getUserProfile(
        GetProfileInput(
          id: eventTicket.assignedTo ?? eventJoinRequest.user,
        ),
      ),
      builder: (context, snapshot) {
        User? user = snapshot.data?.fold((l) => null, (r) => r);
        final imagePlaceholder = Container(
          decoration: BoxDecoration(
            color: LemonColor.darkBackground,
            borderRadius: BorderRadius.circular(Sizing.medium),
          ),
          child: Center(
            child: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icProfile.svg(
                width: Sizing.xSmall,
                height: Sizing.xSmall,
                colorFilter: filter,
              ),
            ),
          ),
        );
        return Container(
          margin: EdgeInsets.only(bottom: isLast ? 0 : Spacing.small),
          child: IntrinsicHeight(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Sizing.medium),
                  child: CachedNetworkImage(
                    width: Sizing.medium,
                    height: Sizing.medium,
                    imageUrl: user?.imageAvatar?.isNotEmpty == true
                        ? user?.imageAvatar ?? ''
                        : '',
                    placeholder: (_, __) => imagePlaceholder,
                    errorWidget: (_, __, ___) => imagePlaceholder,
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user?.displayName ?? '',
                        style: Typo.small.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.w),
                      if (eventTicket.invitedBy == null)
                        Text(
                          '@${user?.username ?? ''}',
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        )
                      else
                        FutureBuilder(
                          future: getIt<UserRepository>().getUserProfile(
                            GetProfileInput(
                              id: eventTicket.assignedTo,
                            ),
                          ),
                          builder: (context, snapshot) {
                            User? inviteUser =
                                snapshot.data?.fold((l) => null, (r) => r);
                            return Text(
                              t.event.eventApproval.assignedBy(
                                name: inviteUser?.displayName ?? '',
                              ),
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
                SizedBox(width: Spacing.small),
                InkWell(
                  onTap: () => showComingSoonDialog(context),
                  child: ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (filter) => Assets.icons.icMoreHoriz.svg(
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                      colorFilter: filter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
