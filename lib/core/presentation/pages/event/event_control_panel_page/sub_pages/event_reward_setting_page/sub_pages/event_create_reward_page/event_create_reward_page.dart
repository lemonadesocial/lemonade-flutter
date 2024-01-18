import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event_tickets/modify_reward_bloc/modify_reward_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_reward_setting_page/sub_pages/event_create_reward_page/widgets/create_reward_basic_info_form.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_reward_setting_page/sub_pages/event_create_reward_page/widgets/event_reward_list_ticket_types.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventCreateRewardPage extends StatelessWidget {
  const EventCreateRewardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ModifyRewardBloc(),
      child: const EventCreateRewardPageView(),
    );
  }
}

class EventCreateRewardPageView extends StatelessWidget {
  const EventCreateRewardPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    List<EventTicketType> eventTicketTypes =
        context.watch<GetEventDetailBloc>().state.maybeWhen(
                  fetched: (event) => event.eventTicketTypes,
                  orElse: () => [],
                ) ??
            [];
    final modifyRewardBloc = context.read<ModifyRewardBloc>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: const LemonAppBar(
          title: "",
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Text(
                      t.event.rewardSetting.createNewReward,
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
                  const SliverToBoxAdapter(child: CreateRewardBasicInfoForm()),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Spacing.large,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      t.event.rewardSetting.selectTicketTiers,
                      style: Typo.extraMedium,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Spacing.small,
                    ),
                  ),
                  BlocBuilder<ModifyRewardBloc, ModifyRewardState>(
                    builder: (context, state) {
                      return EventRewardListTicketTypes(
                        eventTicketTypes: eventTicketTypes,
                        onTapTicketType: (eventTicketType) {
                          modifyRewardBloc.add(
                            ModifyRewardEvent.onSelectEventTicketType(
                              eventTicketTypeId: eventTicketType.id ?? '',
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: Spacing.xLarge * 3),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: colorScheme.background,
                padding: EdgeInsets.all(Spacing.smMedium),
                child: LinearGradientButton(
                  onTap: () async {},
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
          ],
        ),
      ),
    );
  }
}
