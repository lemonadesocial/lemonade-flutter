import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/other_ticket_item.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherPaymentMethodTicketTypesList extends StatelessWidget {
  final List<PurchasableTicketType> ticketTypes;
  final String? networkFilter;
  final String? selectedCurrency;
  final String? selectedNetwork;
  final SelectTicketsPaymentMethod selectedPaymentMethod;

  const OtherPaymentMethodTicketTypesList({
    super.key,
    required this.ticketTypes,
    required this.selectedPaymentMethod,
    this.networkFilter,
    this.selectedCurrency,
    this.selectedNetwork,
  });

  @override
  Widget build(BuildContext context) {
    final otherPaymentMethod =
        selectedPaymentMethod == SelectTicketsPaymentMethod.card
            ? SelectTicketsPaymentMethod.wallet
            : SelectTicketsPaymentMethod.card;
    final otherPaymentMethodTicketTypes = selectedPaymentMethod ==
            SelectTicketsPaymentMethod.card
        ? EventTicketUtils.getTicketTypesSupportCrypto(ticketTypes: ticketTypes)
        : EventTicketUtils.getTicketTypesSupportStripe(
            ticketTypes: ticketTypes,
          );

    if (otherPaymentMethodTicketTypes.isEmpty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final event = context.read<EventProviderBloc>().event;

    return _ExpandableList(
      title: Row(
        children: [
          ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icTicket.svg(
              colorFilter: filter,
              width: Sizing.xSmall,
              height: Sizing.xSmall,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Text(
            '${otherPaymentMethodTicketTypes.length} ${t.event.tickets(n: otherPaymentMethodTicketTypes.length)} ${t.event.eventBuyTickets.viaOtherPaymentMethod}',
            style: Typo.small.copyWith(
              color: colorScheme.onPrimary.withOpacity(0.72),
            ),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: Spacing.medium),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return OtherTicketItem(
            ticketType: otherPaymentMethodTicketTypes[index],
            event: event,
            selectedPaymentMethod: otherPaymentMethod,
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: Spacing.xSmall),
        itemCount: otherPaymentMethodTicketTypes.length,
      ),
    );
  }
}

class OtherChainTicketTypesList extends StatelessWidget {
  final List<PurchasableTicketType> ticketTypes;
  final String? networkFilter;
  final String? selectedCurrency;
  final String? selectedNetwork;
  final SelectTicketsPaymentMethod selectedPaymentMethod;

  const OtherChainTicketTypesList({
    super.key,
    required this.ticketTypes,
    required this.selectedPaymentMethod,
    this.networkFilter,
    this.selectedCurrency,
    this.selectedNetwork,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedPaymentMethod == SelectTicketsPaymentMethod.card ||
        networkFilter == null) {
      return const SizedBox.shrink();
    }

    final otherChainsTicketTypes =
        EventTicketUtils.getTicketTypesSupportCrypto(ticketTypes: ticketTypes)
            .where((type) {
      return (type.prices ?? []).any(
        (element) =>
            element.network?.isNotEmpty == true &&
            element.network != networkFilter,
      );
    }).toList();

    if (otherChainsTicketTypes.isEmpty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final event = context.read<EventProviderBloc>().event;
    final ticketTypeCount = otherChainsTicketTypes.length;

    return _ExpandableList(
      title: Row(
        children: [
          ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icTicket.svg(
              colorFilter: filter,
              width: Sizing.xSmall,
              height: Sizing.xSmall,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Text(
            '$ticketTypeCount ${t.event.tickets(n: ticketTypeCount)} ${t.event.eventBuyTickets.onOtherChain}',
            style: Typo.small.copyWith(
              color: colorScheme.onPrimary.withOpacity(0.72),
            ),
          ),
        ],
      ),
      child: ListView.separated(
        padding: EdgeInsets.only(top: Spacing.medium),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return OtherTicketItem(
            networkFilter: networkFilter,
            ticketType: otherChainsTicketTypes[index],
            event: event,
            selectedPaymentMethod: selectedPaymentMethod,
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: Spacing.xSmall),
        itemCount: otherChainsTicketTypes.length,
      ),
    );
  }
}

class _ExpandableList extends StatelessWidget {
  final ExpandableController controller = ExpandableController();
  final Widget title;
  final Widget child;

  _ExpandableList({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        color: LemonColor.chineseBlack,
        borderRadius: BorderRadius.circular(
          LemonRadius.small,
        ),
      ),
      child: ExpandablePanel(
        theme: ExpandableThemeData(
          iconPadding: EdgeInsets.zero,
          iconColor: LemonColor.paleViolet,
          iconSize: Sizing.xSmall,
        ),
        header: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title,
            Padding(
              padding: EdgeInsets.only(right: Spacing.extraSmall),
              child: Text(
                t.common.actions.view,
                style: Typo.small.copyWith(
                  color: LemonColor.paleViolet,
                ),
              ),
            ),
          ],
        ),
        collapsed: const SizedBox.shrink(),
        expanded: child,
      ),
    );
  }
}
