import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/get_event_currencies_builder.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
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
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    final eventId = context.read<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => '',
          fetched: (eventDetail) => eventDetail.id ?? '',
        );
    return Container(
      decoration: BoxDecoration(
        color: appColors.cardBg,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(Spacing.small),
            child: Row(
              children: [
                eventTicketType.photosExpanded?.isNotEmpty == true
                    ? SizedBox(
                        height: Sizing.mSmall,
                        width: Sizing.mSmall,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3.r),
                          child: CachedNetworkImage(
                            imageUrl: ImageUtils.generateUrl(
                              file: eventTicketType.photosExpanded?.first,
                            ),
                            fit: BoxFit.cover,
                            errorWidget: (_, __, ___) => Center(
                              child: ThemeSvgIcon(
                                color: appColors.textTertiary,
                                builder: (filter) => Assets.icons.icTicket.svg(
                                  colorFilter: filter,
                                  width: Sizing.xSmall,
                                  height: Sizing.xSmall,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : ThemeSvgIcon(
                        color: appColors.textTertiary,
                        builder: (filter) => Assets.icons.icTicket.svg(
                          colorFilter: filter,
                          width: Sizing.xSmall,
                          height: Sizing.xSmall,
                        ),
                      ),
                SizedBox(width: Spacing.xSmall),
                Expanded(
                  child: Text(
                    eventTicketType.title ?? '',
                    style: Typo.medium.copyWith(
                      color: appColors.textPrimary.withOpacity(0.87),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
                Text(
                  eventTicketType.isDefault == true
                      ? t.event.ticketTierSetting.defaultTicket
                      : eventTicketType.active == true
                          ? t.event.ticketTierSetting.active
                          : t.event.ticketTierSetting.disabled,
                  style: Typo.small.copyWith(
                    color: eventTicketType.active == true
                        ? appColors.textTertiary
                        : appColors.textError,
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
                _TicketTierItemActionButton(
                  eventTicketType: eventTicketType,
                  modifyTicket: modifyTicket,
                  onRefresh: onRefresh,
                ),
              ],
            ),
          ),
          DottedLine(
            dashLength: 5.w,
            dashColor: appColors.textTertiary,
            dashRadius: 2.w,
            lineThickness: 2.w,
          ),
          // Ticket tier description
          Padding(
            padding: EdgeInsets.all(Spacing.small),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetEventCurrenciesBuilder(
                  eventId: eventId,
                  builder: (context, loading, currencies) {
                    return Row(
                      children: (eventTicketType.prices ?? [])
                          .asMap()
                          .entries
                          .map((entry) {
                        final price = entry.value;
                        final index = entry.key;
                        final currencyInfo = EventTicketUtils.getEventCurrency(
                          currencies: currencies,
                          currency: price.currency ?? '',
                        );
                        // TODO: ticket setup
                        final isERC20 = price.isCrypto;

                        final decimals = currencyInfo?.decimals?.toInt() ?? 2;
                        String displayedAmount = "";
                        if (isERC20) {
                          displayedAmount = Web3Utils.formatCryptoCurrency(
                            BigInt.parse(price.cost ?? '0'),
                            currency: price.currency ?? '',
                            decimals: decimals,
                            decimalDigits: decimals,
                          );
                        } else {
                          displayedAmount = CurrencyTextInputFormatter.currency(
                            symbol: price.currency ?? '',
                            decimalDigits: decimals,
                          ).formatString(price.cost ?? '');
                        }
                        displayedAmount =
                            isFree ? t.event.free : displayedAmount;
                        return RichText(
                          text: TextSpan(
                            text: loading
                                ? '-'
                                : '${index == 0 ? '' : ' ${t.common.or}'} $displayedAmount',
                            style: Typo.medium.copyWith(
                              color: index == 0
                                  ? appColors.textPrimary
                                  : appColors.textTertiary,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
          // Edit icon
        ],
      ),
    );
  }
}

class _TicketTierItemActionButton extends StatelessWidget {
  final EventTicketType eventTicketType;
  final Future<void> Function(
    BuildContext context, {
    required String eventId,
    required Future<Either<Failure, dynamic>> apiCallUpdateTicket,
  }) modifyTicket;
  final Function()? onRefresh;
  const _TicketTierItemActionButton({
    required this.eventTicketType,
    required this.modifyTicket,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final eventId = context.read<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => '',
          fetched: (eventDetail) => eventDetail.id ?? '',
        );
    return FloatingFrostedGlassDropdown<TicketTierActions>(
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
      child: Center(
        child: ThemeSvgIcon(
          color: appColors.textTertiary,
          builder: (colorFilter) => Assets.icons.icEdit.svg(
            colorFilter: colorFilter,
            width: Sizing.xSmall,
            height: Sizing.xSmall,
          ),
        ),
      ),
    );
  }
}
