import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventRoleAccessControlBottomSheet extends StatefulWidget {
  const EventRoleAccessControlBottomSheet({super.key});

  @override
  EventRoleAccessControlBottomSheetState createState() =>
      EventRoleAccessControlBottomSheetState();
}

class EventRoleAccessControlBottomSheetState
    extends State<EventRoleAccessControlBottomSheet> {
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
            const _RoleTags(),
            const _AccessControlList()
          ],
        ),
      ),
    );
  }
}

class _RoleTags extends StatelessWidget {
  const _RoleTags();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
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
          itemCount: 5,
          itemBuilder: (context, index) {
            final selected = index == 0;
            return LemonOutlineButton(
              onTap: () {},
              textColor: selected == true
                  ? colorScheme.onPrimary
                  : colorScheme.onSecondary,
              backgroundColor:
                  selected == true ? colorScheme.outline : Colors.transparent,
              borderColor:
                  selected == true ? Colors.transparent : colorScheme.outline,
              label: StringUtils.capitalize("Co-host"),
              radius: BorderRadius.circular(LemonRadius.button),
            );
          },
        ),
      ),
    );
  }
}

class _AccessControlList extends StatelessWidget {
  const _AccessControlList({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
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
            constraints: BoxConstraints(maxHeight: 330.w),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) =>
                  SizedBox(height: Spacing.small),
              itemCount: 10,
              itemBuilder: (context, index) {
                final featurePermission = index == 9 ? false : true;
                return _AccessControlItem(featurePermission: featurePermission);
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
    this.featurePermission,
  });

  final bool? featurePermission;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    double opacity = featurePermission == true ? 1 : 0.35;
    final icon = featurePermission == true
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
            'Data dashboard',
            style: Typo.small.copyWith(
              color: colorScheme.onPrimary,
              height: 0,
            ),
          )
        ],
      ),
    );
  }
}
