import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/query/get_event_tags.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class SelectEventTagsDropdown extends StatefulWidget {
  final List<String> initialSelectedTags;
  final Function(List<String> selectedTags)? onChange;

  const SelectEventTagsDropdown({
    super.key,
    this.initialSelectedTags = const [],
    this.onChange,
  });

  @override
  State<SelectEventTagsDropdown> createState() =>
      _SelectEventTagsDropdownState();
}

class _SelectEventTagsDropdownState extends State<SelectEventTagsDropdown> {
  List<String> selectedItems = [];

  @override
  initState() {
    super.initState();
    selectedItems = List<String>.from(widget.initialSelectedTags);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.theme.appColors;
    return Query$GetEventTags$Widget(
      builder: (
        result, {
        refetch,
        fetchMore,
      }) {
        final tags = result.parsedData?.getEventTags ?? [];
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            value: selectedItems.isEmpty ? null : selectedItems.last,
            onChanged: (value) {},
            customButton: Container(
              width: double.infinity,
              padding: EdgeInsets.all(Spacing.small),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LemonRadius.small),
                color: appColors.cardBg,
              ),
              child: Row(
                children: [
                  ThemeSvgIcon(
                    color: appColors.textTertiary,
                    builder: (filter) => Assets.icons.icTag.svg(
                      width: Sizing.mSmall,
                      height: Sizing.mSmall,
                      colorFilter: filter,
                    ),
                  ),
                  SizedBox(width: Spacing.small),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.event.eventTags.tags,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        if (selectedItems.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(
                              top: Spacing.superExtraSmall / 2,
                            ),
                            child: Text(
                              selectedItems.join(", "),
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: Spacing.xSmall),
                  ThemeSvgIcon(
                    color: appColors.textTertiary,
                    builder: (filter) =>
                        Assets.icons.icArrowUpDown.svg(colorFilter: filter),
                  ),
                ],
              ),
            ),
            items: tags
                .map(
                  (tag) => DropdownMenuItem(
                    value: tag,
                    child: StatefulBuilder(
                      builder: (context, menuSetState) {
                        final selected = selectedItems.contains(tag);

                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (selected) {
                                selectedItems.remove(tag);
                              } else {
                                selectedItems.add(tag);
                              }
                            });
                            widget.onChange?.call([...selectedItems]);
                            menuSetState(() {});
                          },
                          child: _SelectTagItem(
                            tag: tag,
                            selected: selectedItems.contains(tag),
                          ),
                        );
                      },
                    ),
                  ),
                )
                .toList(),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 250.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LemonRadius.small),
                color: appColors.pageBg,
              ),
              offset: Offset(0, -Spacing.superExtraSmall),
            ),
            menuItemStyleData: const MenuItemStyleData(
              overlayColor: MaterialStatePropertyAll(LemonColor.darkBackground),
            ),
          ),
        );
      },
    );
  }
}

class _SelectTagItem extends StatelessWidget {
  final String tag;
  final bool selected;
  const _SelectTagItem({
    required this.tag,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            tag,
            style: Typo.mediumPlus.copyWith(
              color: colorScheme.onPrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        if (selected)
          ThemeSvgIcon(
            color: colorScheme.onPrimary,
            builder: (filter) => Assets.icons.icDone.svg(
              colorFilter: filter,
            ),
          ),
      ],
    );
  }
}
