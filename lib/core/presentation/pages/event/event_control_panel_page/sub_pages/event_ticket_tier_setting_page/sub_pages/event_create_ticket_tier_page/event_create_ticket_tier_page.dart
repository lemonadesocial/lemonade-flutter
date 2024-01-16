import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/create_ticket_basic_info_form.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/create_ticket_guest_form.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/create_ticket_pricing_form.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/graphql/backend/event/mutation/create_event_ticket_type.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventCreateTicketTierPage extends StatelessWidget {
  const EventCreateTicketTierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ModifyTicketTypeBloc(),
      child: const EventCreateTicketTierPagerView(),
    );
  }
}

class EventCreateTicketTierPagerView extends StatelessWidget {
  const EventCreateTicketTierPagerView({
    super.key,
  });

  Future<Either<Failure, EventTicketType>> submitModifyTicket(
    ModifyTicketTypeState state, {
    required String eventId,
  }) async {
    return await getIt<EventTicketRepository>().createEventTicketType(
      input: Variables$Mutation$CreateEventTicketType(
        input: Input$EventTicketTypeInput(
          event: eventId,
          title: state.title.value,
          description: state.description.value,
          prices: state.prices
              .map(
                (item) => Input$EventTicketPriceInput(
                  currency: item.currency,
                  cost: item.cost,
                  $default: item.isDefault,
                  network: item.network,
                ),
              )
              .toList(),
          ticket_limit: state.limit,
          active: state.active,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final eventId = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event.id ?? '',
          orElse: () => '',
        );
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const LemonAppBar(
        title: "",
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Text(
                    t.event.ticketTierSetting.createTicket,
                    style: Typo.extraLarge.copyWith(
                      fontWeight: FontWeight.w800,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Spacing.large,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: CreateTicketBasicInfoForm(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Spacing.medium * 2,
                  ),
                ),
                const CreateTicketPricingForm(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Spacing.smMedium,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: CreateTicketGuestForm(),
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
              color: colorScheme.background,
              padding: EdgeInsets.all(Spacing.smMedium),
              child: SafeArea(
                child: BlocBuilder<ModifyTicketTypeBloc, ModifyTicketTypeState>(
                  builder: (context, state) => Opacity(
                    opacity: state.isValid ? 1 : 0.5,
                    child: LinearGradientButton(
                      onTap: () async {
                        if (!state.isValid) return;
                        final futureResult = await showFutureLoadingDialog<
                            Either<Failure, EventTicketType>>(
                          context: context,
                          future: () =>
                              submitModifyTicket(state, eventId: eventId),
                        );
                        if (futureResult.result?.isRight() == true) {
                          context.router.pop();
                          context.read<GetEventDetailBloc>().add(
                                GetEventDetailEvent.fetch(
                                  eventId: eventId,
                                ),
                              );
                        }
                      },
                      height: 42.w,
                      radius: BorderRadius.circular(LemonRadius.small * 2),
                      mode: GradientButtonMode.lavenderMode,
                      label: t.event.ticketTierSetting.addTicket,
                      textStyle: Typo.medium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
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
