import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_export.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/mutation/update_event_checkin.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:timeago/timeago.dart' as timeago;

enum _GuestAction { checkIn, cancelTicket }

class EventAcceptedExportItem extends StatelessWidget {
  final Event? event;
  final EventTicketExport eventAccepted;
  final Function()? refetch;
  final Function(String ticketId)? onTapCancelTicket;
  final bool? isFirst;
  final bool? isLast;
  const EventAcceptedExportItem({
    super.key,
    this.event,
    required this.eventAccepted,
    this.refetch,
    this.onTapCancelTicket,
    this.isFirst,
    this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(Spacing.small),
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                isFirst == true ? LemonRadius.medium : LemonRadius.extraSmall,
              ),
              topRight: Radius.circular(
                isFirst == true ? LemonRadius.medium : LemonRadius.extraSmall,
              ),
              bottomLeft: Radius.circular(
                isLast == true ? LemonRadius.medium : LemonRadius.extraSmall,
              ),
              bottomRight: Radius.circular(
                isLast == true ? LemonRadius.medium : LemonRadius.extraSmall,
              ),
            ),
          ),
          // color: LemonColor.white03,
          child: Row(
            children: [
              _GuestInfo(eventAccepted: eventAccepted),
              const Spacer(),
              if (eventAccepted.checkinDate != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      StringUtils.capitalize(t.event.checkedIn),
                      style: Typo.small.copyWith(
                        color: LemonColor.malachiteGreen,
                      ),
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      timeago.format(eventAccepted.checkinDate!),
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _GuestInfo extends StatelessWidget {
  const _GuestInfo({
    required this.eventAccepted,
  });

  final EventTicketExport eventAccepted;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        LemonNetworkImage(
          borderRadius: BorderRadius.circular(Sizing.medium),
          width: Sizing.medium,
          height: Sizing.medium,
          imageUrl: eventAccepted.buyerAvatar ?? '',
          placeholder: ImagePlaceholder.avatarPlaceholder(),
        ),
        SizedBox(width: Spacing.xSmall),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Sizing.xLarge * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eventAccepted.buyerName ??
                    eventAccepted.buyerEmail ??
                    t.common.anonymous,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.w),
              Text(
                eventAccepted.buyerEmail ?? '',
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
  const _GuestActions({
    this.event,
    required this.eventAccepted,
    this.onTapCancelTicket,
    this.refetch,
  });

  final Event? event;
  final EventTicketExport eventAccepted;
  final Function(String ticketId)? onTapCancelTicket;
  final void Function()? refetch;

  Future<void> _checkIn(BuildContext context) async {
    Vibrate.feedback(FeedbackType.light);
    if (event != null) {
      final response = await showFutureLoadingDialog(
        context: context,
        future: () => getIt<AppGQL>().client.mutate$UpdateEventCheckin(
              Options$Mutation$UpdateEventCheckin(
                variables: Variables$Mutation$UpdateEventCheckin(
                  input: Input$UpdateEventCheckinInput(
                    active: true,
                    shortid: eventAccepted.shortId ?? '',
                  ),
                ),
              ),
            ),
      );
      if (response.result?.parsedData?.updateEventCheckin != null) {
        SnackBarUtils.showSuccess(
          message: t.event.eventApproval.checkedinSuccessfully,
        );
        refetch?.call();
      }
    }
  }

  void _cancelTicket(BuildContext context) async {
    final ticketId = eventAccepted.id;
    if (onTapCancelTicket != null) {
      onTapCancelTicket!(ticketId ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final alreadyCheckedIn = eventAccepted.checkinDate != null;
    final ableToCheckIn =
        eventAccepted.assignedEmail != null || eventAccepted.assignedTo != null;
    return FloatingFrostedGlassDropdown(
      containerWidth: 170.w,
      items: [
        if (!alreadyCheckedIn && ableToCheckIn)
          DropdownItemDpo(
            value: _GuestAction.checkIn,
            label: t.event.configuration.checkIn,
            leadingIcon: ThemeSvgIcon(
              color: colorScheme.onSecondary,
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

class _InfoTag extends StatelessWidget {
  const _InfoTag({required this.icon, required this.label});

  final Widget? icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.xSmall),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.w,
            color: colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(LemonRadius.xSmall),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) icon!,
          SizedBox(width: Spacing.superExtraSmall),
          Container(
            constraints: BoxConstraints(maxWidth: 170.w),
            child: Text(
              maxLines: 2,
              label,
              overflow: TextOverflow.ellipsis,
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
