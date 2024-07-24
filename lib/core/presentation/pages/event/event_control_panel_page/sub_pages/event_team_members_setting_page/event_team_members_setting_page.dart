import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/widgets/event_team_members_search_bar.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventTeamMembersSettingPage extends StatelessWidget {
  const EventTeamMembersSettingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          fetched: (eventDetail) => eventDetail,
          orElse: () => null,
        );
    return EventTeamMembersSettingPageView(event: event);
  }
}

class EventTeamMembersSettingPageView extends StatefulWidget {
  const EventTeamMembersSettingPageView({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  State<EventTeamMembersSettingPageView> createState() =>
      _EventTeamMembersSettingPageViewState();
}

class _EventTeamMembersSettingPageViewState
    extends State<EventTeamMembersSettingPageView> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        backgroundColor: colorScheme.background,
        title: t.event.teamMembers.title,
      ),
      backgroundColor: colorScheme.background,
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.xSmall,
            ),
            child: EventTeamMembersSearchBar(
              textController: _textController,
            ),
          ),
          SizedBox(
            height: Spacing.xSmall,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Spacing.small,
            ),
            child: SizedBox(
              height: Sizing.medium,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) =>
                    SizedBox(width: Spacing.extraSmall),
                itemCount: 5,
                itemBuilder: (context, index) {
                  final selected = index == 0;
                  return LemonOutlineButton(
                    onTap: () {},
                    textColor: selected == true
                        ? colorScheme.onPrimary
                        : colorScheme.onSecondary,
                    backgroundColor: selected == true
                        ? colorScheme.outline
                        : Colors.transparent,
                    borderColor: selected == true
                        ? Colors.transparent
                        : colorScheme.outline,
                    label: StringUtils.capitalize("Co-host"),
                    radius: BorderRadius.circular(LemonRadius.button),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
