import 'package:app/core/application/event/get_event_roles_bloc/get_event_roles_bloc.dart';
import 'package:app/core/domain/event/entities/event_feature.dart';
import 'package:app/core/domain/event/entities/event_role.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventRoleAccessControlBottomSheet extends StatefulWidget {
  const EventRoleAccessControlBottomSheet({super.key});

  @override
  EventRoleAccessControlBottomSheetState createState() =>
      EventRoleAccessControlBottomSheetState();
}

class EventRoleAccessControlBottomSheetState
    extends State<EventRoleAccessControlBottomSheet> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: LemonColor.atomicBlack,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetGrabber(),
            LemonAppBar(
              title: t.event.teamMembers.eventRoles,
              backgroundColor: LemonColor.atomicBlack,
            ),
            BlocBuilder<GetEventRolesBloc, GetEventRolesState>(
              builder: (context, state) {
                if (state.fetching == true) {
                  return Center(child: Loading.defaultLoading(context));
                }
                if (state.eventRoles.isEmpty) {
                  return const EmptyList();
                }
                final eventRoles = state.eventRoles;
                final eventRole = eventRoles[selectedIndex];
                return Column(
                  children: [
                    _RoleTags(
                      eventRoles: eventRoles,
                      selectedIndex: selectedIndex,
                      onTap: (newSelectedIndex) {
                        setState(() {
                          selectedIndex = newSelectedIndex;
                        });
                      },
                    ),
                    _AccessControlList(
                      eventRole: eventRole,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleTags extends StatelessWidget {
  const _RoleTags({
    required this.eventRoles,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<EventRole> eventRoles;
  final int selectedIndex;
  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        top: Spacing.superExtraSmall,
        bottom: Spacing.smMedium,
      ),
      child: SizedBox(
        height: Sizing.medium,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) =>
              SizedBox(width: Spacing.extraSmall),
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.smMedium,
          ),
          itemCount: eventRoles.length,
          itemBuilder: (context, index) {
            final item = eventRoles[index];
            final selected = selectedIndex == index;
            return LemonOutlineButton(
              onTap: () {
                onTap?.call(index);
              },
              textColor:
                  selected ? colorScheme.onPrimary : colorScheme.onSecondary,
              backgroundColor:
                  selected ? colorScheme.outline : Colors.transparent,
              borderColor: selected ? Colors.transparent : colorScheme.outline,
              label: StringUtils.capitalize(item.title),
              radius: BorderRadius.circular(LemonRadius.button),
            );
          },
        ),
      ),
    );
  }
}

class _AccessControlList extends StatelessWidget {
  const _AccessControlList({
    required this.eventRole,
  });

  final EventRole eventRole;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final eventFeatures = eventRole.featuresExpanded ?? [];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.smMedium * 2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.event.teamMembers.accessControl,
            textAlign: TextAlign.left,
            style: Typo.mediumPlus.copyWith(
              color: colorScheme.onPrimary,
              height: 0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Spacing.small),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 400.w),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) =>
                  SizedBox(height: Spacing.small),
              itemCount: eventFeatures.length,
              itemBuilder: (context, index) {
                final eventFeature = eventFeatures[index];
                return _AccessControlItem(eventFeature: eventFeature);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AccessControlItem extends StatelessWidget {
  const _AccessControlItem({
    this.eventFeature,
  });

  final EventFeature? eventFeature;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final featureEnable = eventFeature?.featureEnable ?? false;
    double opacity = featureEnable == true ? 1 : 0.35;
    final icon = featureEnable == true
        ? ThemeSvgIcon(
            color: colorScheme.onPrimary,
            builder: (filter) => Assets.icons.icDone.svg(
              colorFilter: filter,
              width: 15.w,
              height: 15.w,
            ),
          )
        : ThemeSvgIcon(
            color: colorScheme.onPrimary,
            builder: (filter) => Assets.icons.icClose.svg(
              colorFilter: filter,
              width: 15.w,
              height: 15.w,
            ),
          );
    return Opacity(
      opacity: opacity,
      child: Row(
        children: [
          icon,
          SizedBox(
            width: Spacing.xSmall,
          ),
          Text(
            eventFeature?.title ?? '',
            style: Typo.small.copyWith(
              color: colorScheme.onPrimary,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
