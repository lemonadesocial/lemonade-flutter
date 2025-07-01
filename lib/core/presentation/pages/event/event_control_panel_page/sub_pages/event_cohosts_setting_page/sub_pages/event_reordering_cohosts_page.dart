import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_cohosts_setting_page/widgets/event_cohost_setting_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EventReorderingCohostsPage extends StatefulWidget {
  final Event? event;
  final Function(
    List<String> newOrderedUsers,
  )? onDone;
  const EventReorderingCohostsPage({
    super.key,
    required this.event,
    this.onDone,
  });

  @override
  State<EventReorderingCohostsPage> createState() =>
      _EventReorderingCohostsPageState();
}

class _EventReorderingCohostsPageState
    extends State<EventReorderingCohostsPage> {
  late List<User> _orderedUsers;

  @override
  void initState() {
    super.initState();
    _orderedUsers =
        (widget.event?.visibleCohostsExpanded ?? []).whereType<User>().toList();
  }

  void _updateItems(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex--;
      }
      final item = _orderedUsers.removeAt(oldIndex);
      _orderedUsers.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: appColors.pageBg,
      appBar: LemonAppBar(
        title: t.event.eventCohost.cohosts,
        backgroundColor: appColors.pageBg,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacing.small),
            child: InkWell(
              onTap: () {
                widget.onDone
                    ?.call(_orderedUsers.map((user) => user.userId).toList());
              },
              child: Text(
                t.common.done,
                style: Typo.medium.copyWith(
                  color: appColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ReorderableListView.builder(
        itemCount: _orderedUsers.length,
        onReorder: (oldIndex, newIndex) {
          _updateItems(oldIndex, newIndex);
        },
        proxyDecorator: (child, index, animation) {
          return child;
        },
        itemBuilder: (context, index) {
          final cohost = _orderedUsers[index];
          final isHidden =
              !(widget.event?.visibleCohosts ?? []).contains(cohost.userId);
          if (isHidden) {
            return SizedBox.shrink(
              key: ValueKey(_orderedUsers[index]),
            );
          }
          return Padding(
            key: ValueKey(_orderedUsers[index]),
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.small,
              vertical: Spacing.small,
            ),
            child: EventCohostSettingItem(
              user: _orderedUsers[index],
              onPressItem: () {},
              trailing: Row(
                children: [
                  if (widget.event?.host == cohost.userId) ...[
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: Spacing.extraSmall / 2,
                        horizontal: Spacing.extraSmall,
                      ),
                      decoration: BoxDecoration(
                        color: appColors.cardBg,
                        borderRadius:
                            BorderRadius.circular(LemonRadius.extraSmall),
                      ),
                      child: Center(
                        child: Text(
                          t.event.eventCohost.creator,
                          style: Typo.small.copyWith(
                            color: appColors.textTertiary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Spacing.small),
                  ],
                  ReorderableDragStartListener(
                    index: index,
                    child: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icReorder.svg(
                        colorFilter: filter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
