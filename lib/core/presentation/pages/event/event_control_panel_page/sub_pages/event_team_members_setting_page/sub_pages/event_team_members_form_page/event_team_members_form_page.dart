import 'package:app/core/application/event/event_team_members_form_bloc/event_team_members_form_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_roles_bloc/get_event_roles_bloc.dart';
import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/sub_pages/event_team_members_form_page/widgets/choose_role_dropdown.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/sub_pages/event_team_members_form_page/widgets/event_search_members_input.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/sub_pages/event_team_members_form_page/widgets/visible_on_event_card.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventTeamMembersFormPage extends StatelessWidget {
  final EventUserRole? initialEventUserRole;
  final Function()? refetch;

  const EventTeamMembersFormPage({
    super.key,
    this.initialEventUserRole,
    this.refetch,
  });

  @override
  Widget build(BuildContext context) {
    return EventTeamMembersFormView(refetch: refetch);
  }
}

class EventTeamMembersFormView extends StatelessWidget {
  final _scrollController = ScrollController();
  final Function()? refetch;

  EventTeamMembersFormView({super.key, this.refetch});

  scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    String eventId = context.watch<GetEventDetailBloc>().state.maybeWhen(
              fetched: (event) => event.id,
              orElse: () => "",
            ) ??
        "";
    return Scaffold(
      appBar: const LemonAppBar(),
      resizeToAvoidBottomInset: false,
      body:
          BlocListener<EventTeamMembersFormBloc, EventTeamMembersFormBlocState>(
        listener: (context, state) {
          if (state.status == EventTeamMembersFormStatus.success) {
            context
                .read<EventTeamMembersFormBloc>()
                .add(EventTeamMembersFormBlocEvent.reset());
            SnackBarUtils.showSuccess(
              message: t.event.teamMembers.addTeamMemberSuccessfully,
            );
            if (refetch != null) refetch?.call();
            AutoRouter.of(context).pop();
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Spacing.smMedium,
                  right: Spacing.smMedium,
                  top: Spacing.xSmall,
                ),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.event.teamMembers.addTeamMember,
                            style: Typo.extraLarge.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w800,
                              fontFamily: FontFamily.nohemiVariable,
                              height: 0,
                            ),
                          ),
                          SizedBox(height: Spacing.superExtraSmall),
                          Text(
                            t.event.teamMembers.addTeamMemberDescription,
                            style: Typo.medium.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: Spacing.large),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _CircleNumber(label: '1'),
                          SizedBox(
                            width: Spacing.small,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.event.teamMembers.chooseRole,
                                  style: Typo.medium.copyWith(
                                    color: colorScheme.onSecondary,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(
                                  height: Spacing.xSmall,
                                ),
                                BlocBuilder<GetEventRolesBloc,
                                    GetEventRolesState>(
                                  builder: (context, state) {
                                    return ChooseRoleDropdown(
                                      eventRoles: state.eventRoles,
                                      onChanged: (value) {
                                        context
                                            .read<EventTeamMembersFormBloc>()
                                            .add(
                                              EventTeamMembersFormBlocEvent
                                                  .selectRole(
                                                role:
                                                    state.eventRoles.firstWhere(
                                                  (element) =>
                                                      element.id == value,
                                                ),
                                              ),
                                            );
                                      },
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: Spacing.xSmall,
                                ),
                                BlocBuilder<EventTeamMembersFormBloc,
                                    EventTeamMembersFormBlocState>(
                                  builder: (context, state) {
                                    return VisibleOnEventCard(
                                      enabledSwitch:
                                          state.visibleOnEvent ?? false,
                                      onToggleSwitch: (bool? value) {
                                        context
                                            .read<EventTeamMembersFormBloc>()
                                            .add(
                                              EventTeamMembersFormBlocEventChangeVisibleOnEvent(
                                                visibleOnEvent: value,
                                              ),
                                            );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 30.w,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _CircleNumber(label: '2'),
                          SizedBox(
                            width: Spacing.small,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.event.teamMembers.selectTeamMembers,
                                  style: Typo.medium.copyWith(
                                    color: colorScheme.onSecondary,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(
                                  height: Spacing.xSmall,
                                ),
                                Focus(
                                  onFocusChange: (isFocused) {
                                    if (isFocused) {
                                      scrollToEnd();
                                    } else {
                                      scrollToTop();
                                    }
                                  },
                                  child: const EventSearchMembersInput(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: 500.w),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BlocBuilder<EventTeamMembersFormBloc,
                    EventTeamMembersFormBlocState>(
                  builder: (context, state) {
                    return Container(
                      decoration: BoxDecoration(
                        color: colorScheme.background,
                        border: Border(
                          top: BorderSide(
                            color: colorScheme.outline,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(Spacing.smMedium),
                      child: SafeArea(
                        child: Opacity(
                          opacity: state.isValid == true ? 1 : 0.5,
                          child: LinearGradientButton.primaryButton(
                            loadingWhen: state.status ==
                                EventTeamMembersFormStatus.loading,
                            onTap: () {
                              context.read<EventTeamMembersFormBloc>().add(
                                    EventTeamMembersFormBlocEvent.submitForm(
                                      eventId: eventId,
                                    ),
                                  );
                            },
                            label: t.common.actions.sendInvite,
                            textColor: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleNumber extends StatelessWidget {
  const _CircleNumber({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: Sizing.medium,
      height: Sizing.medium,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2.w,
            color: LemonColor.white09,
          ),
          borderRadius: BorderRadius.circular(LemonRadius.normal),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: Typo.small.copyWith(
              color: colorScheme.onSecondary,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
