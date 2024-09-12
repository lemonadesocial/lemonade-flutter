import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_grid_view/sub_events_listing_grid_view.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubEventsGridViewModeSwitcher extends StatelessWidget {
  final SubEventsGridViewMode gridViewMode;
  final Function(SubEventsGridViewMode mode) onGridViewModeChanged;
  const SubEventsGridViewModeSwitcher({
    super.key,
    required this.gridViewMode,
    required this.onGridViewModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
      child: Container(
        height: 42.w,
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: BorderRadius.circular(21.r),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Row(
          children: SubEventsGridViewMode.values
              .map(
                (mode) => Expanded(
                  child: _SubEventsGridViewModeButton(
                    isSelected: mode == gridViewMode,
                    onPressed: () {
                      onGridViewModeChanged(mode);
                    },
                    text: StringUtils.capitalize(mode.name),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _SubEventsGridViewModeButton extends StatelessWidget {
  const _SubEventsGridViewModeButton({
    required this.isSelected,
    required this.onPressed,
    required this.text,
  });

  final bool isSelected;
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? LemonColor.chineseBlack : colorScheme.background,
          borderRadius: BorderRadius.circular(21.r),
        ),
        child: Center(
          child: Text(
            text,
            style: Typo.small.copyWith(
              color:
                  isSelected ? colorScheme.onPrimary : colorScheme.onSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
