import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_basic_info_form/ticket_tier_basic_info_form.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_pricing_form_v2/ticket_tier_pricing_form_v2.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_setting_form/ticket_tier_setting_form.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventCreateTicketTierPage extends StatelessWidget {
  final EventTicketType? initialTicketType;
  final Function()? onRefresh;

  const EventCreateTicketTierPage({
    super.key,
    this.initialTicketType,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ModifyTicketTypeBloc(
        initialTicketType: initialTicketType,
      ),
      child: EventCreateTicketTierPagerView(
        initialTicketType: initialTicketType,
        onRefresh: onRefresh,
      ),
    );
  }
}

class EventCreateTicketTierPagerView extends StatelessWidget {
  final EventTicketType? initialTicketType;
  final Function()? onRefresh;

  const EventCreateTicketTierPagerView({
    super.key,
    this.initialTicketType,
    this.onRefresh,
  });

  Future<Either<Failure, EventTicketType>> submitModifyTicket(
    ModifyTicketTypeState state, {
    required String eventId,
  }) async {
    final input = Input$EventTicketTypeInput(
      event: eventId,
      title: state.title.value,
      description: state.description.value,
      prices: state.prices
          .map(
            (item) => Input$EventTicketPriceInput(
              currency: item.currency,
              cost: item.cost,
              $default: item.isDefault,
              payment_accounts: item.paymentAccounts,
            ),
          )
          .toList(),
      ticket_limit: state.ticketLimit,
      ticket_limit_per: state.ticketLimitPer,
      active: state.active,
      private: state.private,
      limited: state.limited,
      added_whitelist_emails: state.addedWhitelistEmails,
      removed_whitelist_emails: state.removedWhitelistEmails,
      category: state.category,
    );
    if (initialTicketType != null) {
      return await getIt<EventTicketRepository>().updateEventTicketType(
        ticketTypeId: initialTicketType?.id ?? '',
        input: input,
      );
    }
    return await getIt<EventTicketRepository>().createEventTicketType(
      input: input,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event,
          orElse: () => null,
        );
    final eventId = event?.id ?? '';
    final eventLevelPaymentAccounts = event?.paymentAccountsExpanded ?? [];
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: LemonAppBar(
        title: initialTicketType != null
            ? t.event.ticketTierSetting.editTicket
            : t.event.ticketTierSetting.createTicket,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: TicketTierBasicInforForm(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.smMedium * 2),
                ),
                SliverToBoxAdapter(
                  child: TicketTierPricingFormV2(
                    eventLevelPaymentAccounts: eventLevelPaymentAccounts,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.smMedium * 2),
                ),
                SliverToBoxAdapter(
                  child: TicketTierSettingForm(
                    ticketType: initialTicketType,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Spacing.xLarge * 3,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(
                top: Spacing.smMedium,
                left: Spacing.smMedium,
                right: Spacing.smMedium,
              ),
              decoration: BoxDecoration(
                color: colorScheme.background,
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outline,
                  ),
                ),
              ),
              child: SafeArea(
                child: BlocBuilder<ModifyTicketTypeBloc, ModifyTicketTypeState>(
                  builder: (context, state) => Opacity(
                    opacity: state.isValid ? 1 : 0.5,
                    child: LinearGradientButton.primaryButton(
                      onTap: () async {
                        if (!state.isValid) return;
                        final futureResult = await showFutureLoadingDialog<
                            Either<Failure, EventTicketType>>(
                          context: context,
                          future: () =>
                              submitModifyTicket(state, eventId: eventId),
                        );
                        if (futureResult.result?.isRight() == true) {
                          onRefresh?.call();
                          context.router.pop();
                        }
                      },
                      label: initialTicketType != null
                          ? t.common.actions.saveChanges
                          : t.event.ticketTierSetting.addTicket,
                    ),
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
