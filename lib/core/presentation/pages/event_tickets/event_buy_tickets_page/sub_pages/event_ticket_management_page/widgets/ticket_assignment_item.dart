import 'package:app/core/domain/event/entities/event_list_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketAssignmentItem extends StatelessWidget {
  const TicketAssignmentItem({
    super.key,
    required this.eventTicket,
    this.ticketType,
    this.currency,
    this.onPressedAssign,
  });

  final EventTicket eventTicket;
  final PurchasableTicketType? ticketType;
  final Currency? currency;
  final Function()? onPressedAssign;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isTicketAccepted = EventTicketUtils.isTicketAccepted(eventTicket);
    final isTicketUnassigned =
        EventTicketUtils.isTicketNotAssigned(eventTicket);
    final isTicketPending = EventTicketUtils.isTicketPending(eventTicket);

    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.small),
        color: colorScheme.onPrimary.withOpacity(0.06),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
            child: CachedNetworkImage(
              width: Sizing.medium,
              height: Sizing.medium,
              // TODO: photo expanded
              imageUrl: "",
              errorWidget: (_, __, ___) =>
                  ImagePlaceholder.defaultPlaceholder(),
              placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${ticketType?.title}   •   ${NumberUtils.formatCurrency(
                  amount: ticketType?.cost?.toDouble() ?? 0,
                  currency: currency ?? Currency.USD,
                  freeText: t.event.free,
                )}",
                style: Typo.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onPrimary.withOpacity(0.87),
                ),
              ),
              SizedBox(height: 2.w),
              if (isTicketUnassigned)
                Text(
                  t.event.eventTicketManagement.ticketUnassigned,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              if (isTicketAccepted || isTicketPending)
                FutureBuilder(
                  future: eventTicket.assignedEmail == null
                      ? getIt<UserRepository>().getUserProfile(
                          GetProfileInput(id: eventTicket.assignedTo),
                        )
                      : null,
                  builder: (context, snapshot) {
                    final user =
                        snapshot.data?.fold((l) => null, (user) => user);
                    return Text(
                      eventTicket.assignedEmail ??
                          user?.email ??
                          user?.username ??
                          user?.displayName ??
                          '',
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    );
                  },
                ),
              if (isTicketAccepted || isTicketPending)
                Container(
                  margin: EdgeInsets.only(top: Spacing.xSmall),
                  padding: EdgeInsets.symmetric(
                    vertical: Spacing.superExtraSmall,
                    horizontal: Spacing.extraSmall,
                  ),
                  decoration: BoxDecoration(
                    color: isTicketAccepted
                        ? colorScheme.onPrimary.withOpacity(0.06)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(Spacing.extraSmall),
                    border: Border.all(
                      color: isTicketAccepted
                          ? Colors.transparent
                          : colorScheme.onPrimary.withOpacity(0.09),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => isTicketAccepted
                            ? Assets.icons.icDone.svg(
                                colorFilter: filter,
                                width: Sizing.small / 2,
                                height: Sizing.small / 2,
                              )
                            : Assets.icons.icInfo.svg(
                                colorFilter: filter,
                                width: Sizing.small / 2,
                                height: Sizing.small / 2,
                              ),
                      ),
                      SizedBox(width: Spacing.superExtraSmall),
                      Text(
                        isTicketAccepted
                            ? t.event.eventTicketManagement
                                .ticketAssignmentClaimed
                            : t.event.eventTicketManagement
                                .ticketAssignmentPending,
                        style: Typo.xSmall.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
          const Spacer(),
          if (isTicketUnassigned)
            InkWell(
              onTap: () => onPressedAssign?.call(),
              child: Container(
                width: Sizing.medium * 2,
                height: Sizing.medium,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LemonRadius.button),
                  color: LemonColor.lavender18,
                ),
                child: Center(
                  child: Text(
                    t.event.eventTicketManagement.assignTicket,
                    style: Typo.small.copyWith(
                      color: LemonColor.paleViolet,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          if (isTicketPending)
            LemonOutlineButton(
              onTap: () => onPressedAssign?.call(),
              radius: BorderRadius.circular(LemonRadius.button),
              label: t.event.eventTicketManagement.reassignTicket,
            ),
        ],
      ),
    );
  }
}
