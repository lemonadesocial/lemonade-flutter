import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/get_event_list_ticket_types_bloc/get_event_list_ticket_types_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/select_tickets_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SelectTicketsPage extends StatelessWidget {
  const SelectTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventProviderBloc>().event;
    return SelectTicketView(event: event);
  }
}

class SelectTicketView extends StatelessWidget {
  const SelectTicketView({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const LemonAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.event.eventBuyTickets.selectTickets,
                    style: Typo.extraLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontFamily: FontFamily.nohemiVariable,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "${event.title}  •  ${DateFormatUtils.dateOnly(event.start)}",
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Spacing.smMedium),
            BlocBuilder<GetEventListTicketTypesBloc,
                GetEventListTicketTypesState>(
              builder: (context, state) => state.when(
                loading: () => Loading.defaultLoading(context),
                failure: () => EmptyList(emptyText: t.common.somethingWrong),
                success: (listTicketTypes) => SelectTicketsList(
                  event: event,
                  listTicketTypes: listTicketTypes,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: SizedBox(
                height: Sizing.large,
                child: LinearGradientButton(
                  radius: BorderRadius.circular(LemonRadius.small * 2),
                  label: t.common.next,
                  mode: GradientButtonMode.lavenderMode,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
