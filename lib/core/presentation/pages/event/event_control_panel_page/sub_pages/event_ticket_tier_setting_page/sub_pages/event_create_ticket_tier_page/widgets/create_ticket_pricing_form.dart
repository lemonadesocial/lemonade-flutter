import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/add_ticket_tier_pricing_form/add_ticket_tier_pricing_form.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/get_event_currencies_builder.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_pricing_item.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliver_tools/sliver_tools.dart';

enum PricingOption {
  free,
  paid,
}

class CreateTicketPricingForm extends StatefulWidget {
  const CreateTicketPricingForm({super.key});

  @override
  State<CreateTicketPricingForm> createState() =>
      _CreateTicketPricingFormState();
}

class _CreateTicketPricingFormState extends State<CreateTicketPricingForm> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final eventId = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => '',
          fetched: (event) => event.id ?? '',
        );
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.event.ticketTierSetting.pricingAndPaymentMethods,
                style: Typo.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: Spacing.xSmall),
              const _AddPaymentMethodButton(),
            ],
          ),
        ),
        SizedBox(height: Spacing.smMedium),
        GetEventCurrenciesBuilder(
          eventId: eventId,
          builder: (context, loading, currencies) {
            if (loading) {
              return Center(
                child: Loading.defaultLoading(context),
              );
            }
            return BlocBuilder<ModifyTicketTypeBloc, ModifyTicketTypeState>(
              builder: (context, state) => SliverList.separated(
                itemCount: state.prices.length,
                itemBuilder: (context, index) {
                  final ticketPrice = state.prices[index];
                  return TicketTierPricingItem(
                    index: index,
                    ticketPrice: ticketPrice,
                    currencyInfo: EventTicketUtils.getEventCurrency(
                      currencies: currencies,
                      currency: ticketPrice.currency,
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    SizedBox(height: Spacing.smMedium),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _AddPaymentMethodButton extends StatelessWidget {
  const _AddPaymentMethodButton();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final getEventDetailBloc = context.watch<GetEventDetailBloc>();
    final modifyTicketTypeBloc = context.watch<ModifyTicketTypeBloc>();

    return InkWell(
      onTap: () {
        showCupertinoModalBottomSheet(
          context: context,
          expand: true,
          backgroundColor: LemonColor.atomicBlack,
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
              onConfirm: (newTicketPrice) {
                Navigator.of(innerContext).pop();
                context.read<ModifyTicketTypeBloc>().add(
                      ModifyTicketTypeEvent.onPricesChanged(
                        ticketPrice: newTicketPrice,
                      ),
                    );
              },
            ),
          ),
        );
      },
      child: DottedBorder(
        dashPattern: [5.w],
        color: colorScheme.outline,
        borderType: BorderType.RRect,
        padding: EdgeInsets.all(Spacing.small),
        radius: Radius.circular(LemonRadius.xSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icAdd.svg(
                colorFilter: filter,
              ),
            ),
            SizedBox(width: Spacing.extraSmall),
            Text(
              t.event.ticketTierSetting.addPaymentMethod,
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PricingOptionItem extends StatelessWidget {
  final String label;
  final bool selected;
  final Widget Function(Color color)? leadingBuilder;

  const PricingOptionItem({
    super.key,
    required this.label,
    required this.selected,
    this.leadingBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: Sizing.large,
      decoration: BoxDecoration(
        color: selected ? LemonColor.paleViolet18 : LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingBuilder != null) ...[
            leadingBuilder!.call(
              selected ? LemonColor.paleViolet : colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: Spacing.xSmall),
          ],
          Text(
            label,
            style: Typo.mediumPlus.copyWith(
              color: selected
                  ? LemonColor.paleViolet
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
