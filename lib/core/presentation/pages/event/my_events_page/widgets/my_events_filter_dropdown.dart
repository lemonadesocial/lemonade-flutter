import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:app/app_theme/app_theme.dart';

enum MyEventsFilter {
  all,
  hosting,
  attending,
  pending,
}

class MyEventsFilterDropdown extends StatefulWidget {
  const MyEventsFilterDropdown({
    super.key,
    required this.onChanged,
    required this.value,
  });

  final Function(MyEventsFilter) onChanged;
  final MyEventsFilter value;

  @override
  State<MyEventsFilterDropdown> createState() => _MyEventsFilterDropdownState();
}

class _MyEventsFilterDropdownState extends State<MyEventsFilterDropdown> {
  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    return PopupMenuButton<void>(
      constraints: const BoxConstraints(minWidth: 252),
      padding: EdgeInsets.zero,
      menuPadding: EdgeInsets.zero,
      elevation: 3,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LemonRadius.sm),
        side: BorderSide(color: appColors.cardBorder),
      ),
      clipBehavior: Clip.none,
      child: ThemeSvgIcon(
        color: appColors.textTertiary,
        builder: (filter) {
          return Assets.icons.icFilterList.svg(
            colorFilter: filter,
            width: Sizing.s6,
            height: Sizing.s6,
          );
        },
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _FilterItem(
                    title: t.event.allEvents,
                    onTap: () {
                      widget.onChanged(MyEventsFilter.all);
                      setState(() {});
                    },
                    selected: widget.value == MyEventsFilter.all,
                  ),
                  Divider(
                    height: Spacing.s1_5,
                    thickness: Spacing.s1_5,
                    color: appColors.pageDividerInverse.withOpacity(0.5),
                  ),
                  _FilterItem(
                    title: t.event.hosting.capitalize(),
                    onTap: () {
                      widget.onChanged(MyEventsFilter.hosting);
                      setState(() {});
                    },
                    selected: widget.value == MyEventsFilter.hosting,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: appColors.pageDivider,
                  ),
                  _FilterItem(
                    title: t.event.attending.capitalize(),
                    onTap: () {
                      widget.onChanged(MyEventsFilter.attending);
                      setState(() {});
                    },
                    selected: widget.value == MyEventsFilter.attending,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: appColors.pageDivider,
                  ),
                  _FilterItem(
                    title: t.event.pending.capitalize(),
                    onTap: () {
                      widget.onChanged(MyEventsFilter.pending);
                      setState(() {});
                    },
                    selected: widget.value == MyEventsFilter.pending,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FilterItem extends StatelessWidget {
  const _FilterItem({
    required this.title,
    required this.onTap,
    required this.selected,
  });

  final String title;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: appColors.pageOverlaySecondary,
          borderRadius: BorderRadius.circular(LemonRadius.sm),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.s3,
          vertical: Spacing.s2_5,
        ),
        child: Row(
          children: [
            Text(
              title,
              style: appText.sm,
            ),
            const Spacer(),
            if (selected)
              ThemeSvgIcon(
                color: appColors.textPrimary,
                builder: (filter) => Assets.icons.icDone.svg(
                  colorFilter: filter,
                  width: Sizing.s5,
                  height: Sizing.s5,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
