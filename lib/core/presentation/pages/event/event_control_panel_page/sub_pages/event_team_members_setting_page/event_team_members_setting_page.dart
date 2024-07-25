import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/widgets/event_roles_access_control_bottomsheet.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/widgets/event_team_members_item_widget.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/widgets/event_team_members_search_bar.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
        actions: [
          InkWell(
            onTap: () {
              showCupertinoModalBottomSheet(
                bounce: true,
                backgroundColor: LemonColor.atomicBlack,
                context: context,
                topRadius: Radius.circular(30.r),
                barrierColor: Colors.black.withOpacity(0.8),
                builder: (mContext) {
                  return const EventRoleAccessControlBottomSheet();
                },
              );
            },
            child: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icInfo.svg(
                colorFilter: filter,
                width: Sizing.medium / 2,
                height: Sizing.medium / 2,
              ),
            ),
          ),
          SizedBox(width: Spacing.smMedium),
        ],
      ),
      backgroundColor: colorScheme.background,
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: Spacing.xSmall,
            ),
            child: EventTeamMembersSearchBar(
              textController: _textController,
            ),
          ),
          SizedBox(
            height: Spacing.xSmall,
          ),
          SizedBox(
            height: Sizing.medium,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.small,
              ),
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
                  // TODO: Will integrate with backend data soon
                  label: StringUtils.capitalize("Co-host"),
                  radius: BorderRadius.circular(LemonRadius.button),
                );
              },
            ),
          ),
          SizedBox(
            height: Spacing.xSmall,
          ),
          const Expanded(
            child: CustomScrollView(
              slivers: [_EventTeamMembersList()],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventTeamMembersList extends StatelessWidget {
  const _EventTeamMembersList();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        left: Spacing.small,
        right: Spacing.small,
        bottom: Spacing.xLarge,
      ),
      sliver: SliverList.separated(
        itemCount: 8,
        itemBuilder: (context, index) {
          // TODO: Will integrate with backend data soon
          return EventTeamMemberItemWidget(
            title: 'Justin Saris',
            subTitle: '@jessie.bessie',
            onTap: () {},
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: Spacing.xSmall),
      ),
    );
  }
}
