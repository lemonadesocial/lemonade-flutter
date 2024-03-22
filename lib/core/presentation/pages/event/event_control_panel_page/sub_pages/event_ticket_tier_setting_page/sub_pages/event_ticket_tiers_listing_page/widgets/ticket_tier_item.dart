import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TicketTierActions {
  makeDefault,
  edit,
  inactivate,
  delete,
}

class TicketTierItem extends StatelessWidget {
  final EventTicketType eventTicketType;
  final Function()? onRefresh;
  final bool isFirst;
  final bool isLast;

  const TicketTierItem({
    super.key,
    required this.eventTicketType,
    this.onRefresh,
    this.isFirst = false,
    this.isLast = false,
  });

  Future<void> modifyTicket(
    BuildContext context, {
    required String eventId,
    required Future<Either<Failure, dynamic>> apiCallUpdateTicket,
  }) async {
    showFutureLoadingDialog(
      context: context,
      future: () async {
        final result = await apiCallUpdateTicket;
        if (result.isRight()) {
          context.read<GetEventDetailBloc>().add(
                GetEventDetailEvent.fetch(eventId: eventId),
              );
        }
        await onRefresh?.call();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFree =
        eventTicketType.prices?.any((element) => element.fiatCost == 0) ??
            false;
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final eventId = context.read<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => '',
          fetched: (eventDetail) => eventDetail.id ?? '',
        );
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            isFirst ? LemonRadius.medium : LemonRadius.extraSmall,
          ),
          topLeft: Radius.circular(
            isFirst ? LemonRadius.medium : LemonRadius.extraSmall,
          ),
          bottomRight: Radius.circular(
            isLast ? LemonRadius.medium : LemonRadius.extraSmall,
          ),
          bottomLeft: Radius.circular(
            isLast ? LemonRadius.medium : LemonRadius.extraSmall,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              border: Border.all(
                color: LemonColor.chineseBlack,
              ),
            ),
            child: eventTicketType.photosExpanded?.isNotEmpty == true
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                    child: CachedNetworkImage(
                      imageUrl: ImageUtils.generateUrl(
                        file: eventTicketType.photosExpanded?.first,
                      ),
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Center(
                        child: ThemeSvgIcon(
                          color: colorScheme.onSecondary,
                          builder: (filter) => Assets.icons.icTicket.svg(
                            colorFilter: filter,
                            width: Sizing.xSmall,
                            height: Sizing.xSmall,
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icTicket.svg(
                        colorFilter: filter,
                        width: Sizing.xSmall,
                        height: Sizing.xSmall,
                      ),
                    ),
                  ),
          ),
          SizedBox(width: Spacing.xSmall),
          // Ticket tier description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventTicketType.title ?? '',
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.87),
                  ),
                ),
                SizedBox(height: 2.w),
                RichText(
                  text: TextSpan(
                    text: eventTicketType.isDefault == true
                        ? t.event.ticketTierSetting.defaultTicket
                        : eventTicketType.active == true
                            ? t.event.ticketTierSetting.active
                            : t.event.ticketTierSetting.disabled,
                    style: Typo.small.copyWith(
                      color: eventTicketType.active == true
                          ? colorScheme.onSecondary
                          : LemonColor.errorRedBg,
                    ),
                    children: [
                      WidgetSpan(
                        child: SizedBox(
                          width: Spacing.superExtraSmall,
                        ),
                      ),
                      TextSpan(
                        text:
                            "• ${isFree ? t.event.free : t.event.ticketTierSetting.method(
                                n: eventTicketType.prices?.length ?? 1,
                                count: eventTicketType.prices?.length ?? 1,
                              )}",
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                      WidgetSpan(
                        child: SizedBox(
                          width: Spacing.superExtraSmall,
                        ),
                      ),
                      TextSpan(
                        text:
                            "• ${eventTicketType.ticketLimit == null ? t.event.ticketTierSetting.unlimitedGuests : t.event.ticketTierSetting.guestsCount(
                                n: (eventTicketType.ticketLimit ?? 0).toInt(),
                              )}",
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Edit icon
          FloatingFrostedGlassDropdown<TicketTierActions>(
            containerWidth: Sizing.xLarge * 2,
            items: [
              DropdownItemDpo(
                label: t.event.ticketTierSetting.actions.makeDefault,
                textStyle: Typo.small,
                value: TicketTierActions.makeDefault,
              ),
              DropdownItemDpo(
                label: t.event.ticketTierSetting.actions.edit,
                textStyle: Typo.small,
                value: TicketTierActions.edit,
              ),
              DropdownItemDpo(
                label: t.event.ticketTierSetting.actions.inactivate,
                textStyle: Typo.small,
                value: TicketTierActions.inactivate,
              ),
              DropdownItemDpo(
                label: t.event.ticketTierSetting.actions.delete,
                textStyle: Typo.small,
                value: TicketTierActions.delete,
              ),
            ],
            onItemPressed: (item) {
              switch (item?.value) {
                case TicketTierActions.makeDefault:
                  modifyTicket(
                    context,
                    eventId: eventId,
                    apiCallUpdateTicket:
                        getIt<EventTicketRepository>().updateEventTicketType(
                      input: Input$EventTicketTypeInput(
                        $default: true,
                        event: eventId,
                      ),
                      ticketTypeId: eventTicketType.id ?? '',
                    ),
                  );
                  break;
                case TicketTierActions.edit:
                  context.router.push(
                    EventCreateTicketTierRoute(
                      initialTicketType: eventTicketType,
                      onRefresh: onRefresh,
                    ),
                  );
                  break;
                case TicketTierActions.inactivate:
                  modifyTicket(
                    context,
                    eventId: eventId,
                    apiCallUpdateTicket:
                        getIt<EventTicketRepository>().updateEventTicketType(
                      input: Input$EventTicketTypeInput(
                        active: false,
                        event: eventId,
                      ),
                      ticketTypeId: eventTicketType.id ?? '',
                    ),
                  );
                  break;
                case TicketTierActions.delete:
                  modifyTicket(
                    context,
                    eventId: eventId,
                    apiCallUpdateTicket:
                        getIt<EventTicketRepository>().deleteEventTicketType(
                      eventId: eventId,
                      ticketTypeId: eventTicketType.id ?? '',
                    ),
                  );
                  break;
                default:
                  break;
              }
            },
            child: Container(
              width: Sizing.medium,
              height: Sizing.medium,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.onPrimary.withOpacity(0.1),
                ),
              ),
              child: Center(
                child: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (colorFilter) => Assets.icons.icEdit.svg(
                    colorFilter: colorFilter,
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
