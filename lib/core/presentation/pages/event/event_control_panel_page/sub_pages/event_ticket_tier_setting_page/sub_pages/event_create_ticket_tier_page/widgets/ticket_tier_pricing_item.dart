import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/input/ticket_type_input/ticket_type_input.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/add_ticket_tier_pricing_form/add_ticket_tier_pricing_form.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

enum TicketPricingActions {
  makeDefault,
  edit,
  delete,
}

class TicketTierPricingItem extends StatelessWidget {
  final TicketPriceInput ticketPrice;
  final EventCurrency? currencyInfo;
  final int index;

  const TicketTierPricingItem({
    super.key,
    required this.ticketPrice,
    required this.index,
    this.currencyInfo,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final modifyTicketTypeBloc = context.watch<ModifyTicketTypeBloc>();
    final getEventDetailBloc = context.watch<GetEventDetailBloc>();
    final decimals = currencyInfo?.decimals?.toInt() ?? 0;
    final formatter = NumberFormat.currency(
      symbol: ticketPrice.currency,
      decimalDigits: decimals,
    );
    double? doubleAmount;
    String? erc20DisplayedAmount;
    // TODO: ticket setup
    final isERC20 = currencyInfo?.network?.isNotEmpty == true;
    if (isERC20) {
      erc20DisplayedAmount = Web3Utils.formatCryptoCurrency(
        BigInt.parse(ticketPrice.cost),
        currency: ticketPrice.currency,
        decimals: decimals,
        decimalDigits: decimals,
      );
    } else {
      final parsedAmount = int.parse(ticketPrice.cost).toString();
      doubleAmount = NumberUtils.getAmountByDecimals(
        BigInt.parse(parsedAmount),
        decimals: decimals,
      );
    }

    return FutureBuilder<Either<Failure, Chain?>>(
      future: currencyInfo?.network?.isNotEmpty == true
          ? getIt<Web3Repository>()
              .getChainById(chainId: currencyInfo!.network!)
          : Future.value(
              const Right(null),
            ),
      builder: (context, snapshot) {
        final chain = snapshot.data?.getOrElse(() => null);

        return FloatingFrostedGlassDropdown<TicketPricingActions>(
          containerWidth: Sizing.xLarge * 2,
          items: [
            DropdownItemDpo(
              label: t.event.ticketTierSetting.actions.makeDefault,
              textStyle: Typo.small,
              value: TicketPricingActions.makeDefault,
            ),
            DropdownItemDpo(
              label: t.event.ticketTierSetting.actions.edit,
              textStyle: Typo.small,
              value: TicketPricingActions.edit,
            ),
            DropdownItemDpo(
              label: t.event.ticketTierSetting.actions.delete,
              textStyle: Typo.small,
              value: TicketPricingActions.delete,
            ),
          ],
          onItemPressed: (item) {
            switch (item?.value) {
              case TicketPricingActions.makeDefault:
                modifyTicketTypeBloc.add(
                  ModifyTicketTypeEvent.onMarkDefault(
                    index: index,
                  ),
                );
                break;
              case TicketPricingActions.edit:
                BottomSheetUtils.showSnapBottomSheet(
                  context,
                  builder: (innerContext) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: getEventDetailBloc,
                      ),
                      BlocProvider.value(
                        value: modifyTicketTypeBloc,
                      ),
                    ],
                    child: AddTicketTierPricingForm(
                      initialTicketPrice: ticketPrice,
                      initialChain: chain,
                      onConfirm: (newTicketPrice) {
                        Navigator.of(innerContext).pop();
                        modifyTicketTypeBloc.add(
                          ModifyTicketTypeEvent.onPricesChanged(
                            index: index,
                            ticketPrice: newTicketPrice,
                          ),
                        );
                      },
                    ),
                  ),
                );
                break;
              case TicketPricingActions.delete:
                modifyTicketTypeBloc.add(
                  ModifyTicketTypeEvent.onDeletePrice(
                    index: index,
                  ),
                );
                break;
              default:
                break;
            }
          },
          child: Row(
            children: [
              Container(
                width: Sizing.medium,
                height: Sizing.medium,
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: chain != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(Sizing.medium),
                          child: CachedNetworkImage(
                            width: Sizing.medium / 2,
                            height: Sizing.medium / 2,
                            imageUrl: chain.logoUrl ?? '',
                            errorWidget: (_, __, ___) =>
                                ImagePlaceholder.ticketThumbnail(),
                            placeholder: (
                              _,
                              __,
                            ) =>
                                ImagePlaceholder.ticketThumbnail(),
                          ),
                        )
                      : ThemeSvgIcon(
                          color: colorScheme.onSecondary,
                          builder: (filter) =>
                              Assets.icons.icCash.svg(colorFilter: filter),
                        ),
                ),
              ),
              SizedBox(width: Spacing.small),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isERC20
                          ? erc20DisplayedAmount ?? ''
                          : formatter.format(doubleAmount),
                      style: Typo.small.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.w),
                    Row(
                      children: [
                        Text(
                          chain != null
                              ? chain.name ?? ''
                              : t.event.ticketTierSetting.creditDebit,
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                        if (ticketPrice.isDefault == true) ...[
                          Text(
                            " - ${t.event.ticketTierSetting.defaultTicket}",
                            style: Typo.small.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) =>
                    Assets.icons.icMoreHoriz.svg(colorFilter: filter),
              ),
            ],
          ),
        );
      },
    );
  }
}
