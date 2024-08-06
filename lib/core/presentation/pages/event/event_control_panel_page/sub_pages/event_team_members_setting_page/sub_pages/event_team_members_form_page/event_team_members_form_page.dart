import 'package:app/core/application/event/get_event_roles_bloc/get_event_roles_bloc.dart';
import 'package:app/core/application/event/event_team_members_form_bloc/event_team_members_form_bloc.dart';
import 'package:app/core/domain/event/entities/event_role.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/sub_pages/event_team_members_form_page/widgets/choose_role_dropdown.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
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
class EventTeamMembersFormPage extends StatefulWidget {
  const EventTeamMembersFormPage({super.key});

  @override
  State<EventTeamMembersFormPage> createState() =>
      _EventTeamMembersFormPageState();
}

class _EventTeamMembersFormPageState extends State<EventTeamMembersFormPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const LemonAppBar(),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
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
                              LemonTextField(
                                borderColor: LemonColor.white09,
                                hintText: t.event.teamMembers
                                    .searchProfileOrEnterEmail,
                                contentPadding:
                                    EdgeInsets.all(Spacing.smMedium),
                                onChange: (value) {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
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
                    opacity: 0.5,
                    child: LinearGradientButton.primaryButton(
                      onTap: () {},
                      label: t.common.actions.sendInvite,
                      textColor: colorScheme.onPrimary,
                    ),
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
