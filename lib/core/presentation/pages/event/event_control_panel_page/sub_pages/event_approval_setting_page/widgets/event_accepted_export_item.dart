import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_accepted_export.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

enum _GuestAction { checkIn, cancelTicket }

class EventAcceptedExportItem extends StatelessWidget {
  final Event? event;
  final EventAcceptedExport eventAccepted;
  const EventAcceptedExportItem({
    super.key,
    this.event,
    required this.eventAccepted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(Spacing.small),
          decoration: BoxDecoration(
            color: LemonColor.atomicBlack,
            borderRadius: BorderRadius.circular(
              LemonRadius.extraSmall,
            ),
          ),
          child: Row(
            children: [
              _GuestInfo(eventAccepted: eventAccepted),
              const Spacer(),
              if ((eventAccepted.ticketCount ?? 0) > 0)
                _TicketCount(
                  eventAccepted: eventAccepted,
                ),
              SizedBox(
                width: Spacing.xSmall,
              ),
              _GuestActions(event: event, eventAccepted: eventAccepted),
            ],
          ),
        ),
      ],
    );
  }
}

class _TicketCount extends StatelessWidget {
  const _TicketCount({
    required this.eventAccepted,
  });

  final EventAcceptedExport eventAccepted;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.xSmall),
      decoration: BoxDecoration(
        color: LemonColor.darkBackground,
        borderRadius: BorderRadius.circular(LemonRadius.normal),
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
            eventAccepted.ticketCount?.toInt().toString() ?? '',
            style: Typo.small.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _GuestInfo extends StatelessWidget {
  const _GuestInfo({
    required this.eventAccepted,
  });

  final EventAcceptedExport eventAccepted;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Sizing.medium),
          child: CachedNetworkImage(
            width: Sizing.medium,
            height: Sizing.medium,
            // TODO: wait for BE to support
            // imageUrl: eventAccepted.assigneeImageAvatar ?? '',
            imageUrl: '',
            placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
            errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Sizing.xLarge * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eventAccepted.assigneeName ??
                    eventAccepted.assigneeEmail ??
                    t.common.anonymous,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.w),
              Text(
                eventAccepted.assigneeUsername != null
                    ? '@${eventAccepted.assigneeUsername}'
                    : eventAccepted.assigneeEmail ?? '',
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GuestActions extends StatelessWidget {
  const _GuestActions({this.event, required this.eventAccepted});

  final Event? event;
  final EventAcceptedExport eventAccepted;

  void _checkIn(BuildContext context) {
    Vibrate.feedback(FeedbackType.light);
    if (event != null) {
      AutoRouter.of(context).navigate(ScanQRCheckinRewardsRoute(event: event!));
    }
  }

  void _cancelTicket(BuildContext context) async {
    final ticketIds =
        event?.tickets?.map((ticket) => ticket.id ?? '').toList() ?? [];
    await showFutureLoadingDialog(
      context: context,
      future: () {
        return getIt<EventTicketRepository>().cancelTickets(
          eventId: event?.id ?? '',
          ticketIds: ticketIds,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return FloatingFrostedGlassDropdown(
      containerWidth: 170.w,
      items: [
        DropdownItemDpo(
          value: _GuestAction.checkIn,
          label: t.event.configuration.checkIn,
          leadingIcon: ThemeSvgIcon(
            color: colorScheme.onPrimary,
            builder: (colorFilter) => Assets.icons.icCheckin.svg(
              colorFilter: colorFilter,
            ),
          ),
        ),
        DropdownItemDpo(
          value: _GuestAction.cancelTicket,
          label: t.event.cancelTicket,
          customColor: LemonColor.coralReef,
          leadingIcon: ThemeSvgIcon(
            color: LemonColor.coralReef,
            builder: (colorFilter) => Assets.icons.icClose.svg(
              width: 18.w,
              height: 18.w,
              colorFilter: colorFilter,
            ),
          ),
        ),
      ],
      onItemPressed: (item) {
        Vibrate.feedback(FeedbackType.light);
        if (item?.value == _GuestAction.checkIn) {
          _checkIn(context);
        }
        if (item?.value == _GuestAction.cancelTicket) {
          _cancelTicket(context);
        }
      },
      child: ThemeSvgIcon(
        color: colorScheme.onSecondary,
        builder: (filter) => Assets.icons.icMoreVertical.svg(
          colorFilter: filter,
          width: 18.w,
          height: 18.w,
        ),
      ),
    );
  }
}
