import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event_tickets/modify_reward_bloc/modify_reward_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_reward_setting_page/sub_pages/event_create_reward_page/widgets/create_reward_basic_info_form.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_reward_setting_page/sub_pages/event_create_reward_page/widgets/event_reward_list_ticket_types.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

@RoutePage()
class EventCreateRewardPage extends StatelessWidget {
  final Reward? initialReward;
  const EventCreateRewardPage({super.key, this.initialReward});

  @override
  Widget build(BuildContext context) {
    Event? eventDetail = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event,
          orElse: () => Event(),
        );
    return BlocProvider(
      create: (context) => ModifyRewardBloc(initialReward, eventDetail),
      child: EventCreateRewardPageView(initialReward: initialReward),
    );
  }
}

class EventCreateRewardPageView extends StatelessWidget {
  final Reward? initialReward;
  const EventCreateRewardPageView({super.key, this.initialReward});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final eventId = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event.id ?? '',
          orElse: () => '',
        );
    List<EventTicketType> eventTicketTypes =
        context.watch<GetEventDetailBloc>().state.maybeWhen(
                  fetched: (event) => event.eventTicketTypes,
                  orElse: () => [],
                ) ??
            [];
    List<Reward> existingRewards =
        context.watch<GetEventDetailBloc>().state.maybeWhen(
                  fetched: (event) => event.rewards,
                  orElse: () => [],
                ) ??
            [];
    final modifyRewardBloc = context.read<ModifyRewardBloc>();
    final getEventDetailBloc = context.read<GetEventDetailBloc>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: const LemonAppBar(
          title: "",
        ),
        body: BlocListener<ModifyRewardBloc, ModifyRewardState>(
          listener: (context, state) {
            if (state.status == FormzSubmissionStatus.success) {
              AutoRouter.of(context).back();
              if (initialReward != null) {
                SnackBarUtils.showSuccessSnackbar(
                  t.event.rewardSetting.updateRewardSuccessfully,
                );
              } else {
                SnackBarUtils.showSuccessSnackbar(
                  t.event.rewardSetting.createRewardSuccessfully,
                );
              }
              getEventDetailBloc.add(
                GetEventDetailEvent.fetch(
                  eventId: eventId,
                ),
              );
            }
          },
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Text(
                        initialReward != null
                            ? t.event.rewardSetting.editReward
                            : t.event.rewardSetting.createNewReward,
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
                    SliverToBoxAdapter(
                      child: CreateRewardBasicInfoForm(
                        initialReward: initialReward,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: Spacing.medium,
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
                              ModifyRewardEvent.onToggleEventTicketType(
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
              BlocBuilder<ModifyRewardBloc, ModifyRewardState>(
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: colorScheme.background,
                      padding: EdgeInsets.all(Spacing.smMedium),
                      child: LinearGradientButton(
                        onTap: () async {
                          if (initialReward != null) {
                            modifyRewardBloc.add(
                              ModifyRewardEvent.onEditSubmitted(
                                eventId: eventId,
                                existingRewards: existingRewards,
                              ),
                            );
                          } else {
                            modifyRewardBloc.add(
                              ModifyRewardEvent.onCreateSubmitted(
                                eventId: eventId,
                                existingRewards: existingRewards,
                              ),
                            );
                          }
                        },
                        height: 42.w,
                        radius: BorderRadius.circular(LemonRadius.small * 2),
                        mode: GradientButtonMode.lavenderMode,
                        label: t.common.actions.saveChanges,
                        textStyle: Typo.medium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        loadingWhen:
                            state.status == FormzSubmissionStatus.inProgress,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
