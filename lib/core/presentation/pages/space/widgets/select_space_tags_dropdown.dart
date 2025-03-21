import 'package:app/core/data/space/dtos/space_tag_dto.dart';
import 'package:app/core/domain/space/entities/space_tag.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/graphql/backend/space/mutation/insert_space_tag.graphql.dart';
import 'package:app/graphql/backend/space/query/list_space_tags.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:math';

class SelectSpaceTagsDropdown extends StatefulWidget {
  final List<SpaceTag> initialSelectedTags;
  final Function(List<SpaceTag> selectedTags)? onChange;
  final String spaceId;
  final bool canInsertTag;

  const SelectSpaceTagsDropdown({
    super.key,
    required this.spaceId,
    this.initialSelectedTags = const [],
    this.onChange,
    this.canInsertTag = false,
  });

  @override
  State<SelectSpaceTagsDropdown> createState() =>
      _SelectSpaceTagsDropdownState();
}

class _SelectSpaceTagsDropdownState extends State<SelectSpaceTagsDropdown> {
  List<SpaceTag> selectedItems = [];
  final TextEditingController searchController = TextEditingController();
  String searchText = '';
  List<SpaceTag> allTags = [];
  GlobalKey<DropdownButton2State<SpaceTag>> dropdownKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectedItems = List<SpaceTag>.from(widget.initialSelectedTags);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Query$ListSpaceTags$Widget(
      options: Options$Query$ListSpaceTags(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: Variables$Query$ListSpaceTags(
          space: widget.spaceId,
        ),
        onComplete: (_, result) {
          setState(() {
            allTags = (result?.listSpaceTags ?? [])
                .map(
                  (item) => SpaceTag.fromDto(
                    SpaceTagDto.fromJson(item.toJson()),
                  ),
                )
                .toList();
          });
        },
      ),
      builder: (
        result, {
        refetch,
        fetchMore,
      }) {
        return Wrap(
          spacing: Spacing.xSmall,
          runSpacing: Spacing.xSmall,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2<SpaceTag>(
                key: dropdownKey,
                value: null,
                onChanged: (value) {},
                customButton: FittedBox(
                  child: Opacity(
                    opacity: widget.canInsertTag ? 1 : 0.36,
                    child: LemonOutlineButton(
                      leading: Assets.icons.icPlus.svg(),
                      radius: BorderRadius.circular(LemonRadius.button),
                      backgroundColor: LemonColor.chineseBlack,
                      label: t.space.addTags,
                    ),
                  ),
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: searchController,
                  searchInnerWidgetHeight: 56.w,
                  searchInnerWidget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LemonTextField(
                        controller: searchController,
                        borderColor: Colors.transparent,
                        hintText: t.space.applyTags,
                      ),
                      Divider(
                        color: colorScheme.outline,
                      ),
                    ],
                  ),
                  searchMatchFn: (item, searchValue) {
                    if (item.value == null) {
                      return true;
                    }
                    return item.value?.tag.toLowerCase().contains(
                              searchValue.toLowerCase(),
                            ) ??
                        false;
                  },
                ),
                items: [
                  ...allTags.map(
                    (tag) => DropdownMenuItem<SpaceTag>(
                      value: tag,
                      child: StatefulBuilder(
                        builder: (context, menuSetState) {
                          final selected =
                              selectedItems.any((item) => item.id == tag.id);
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (selected) {
                                  selectedItems
                                      .removeWhere((item) => item.id == tag.id);
                                } else {
                                  selectedItems.add(tag);
                                }
                              });
                              widget.onChange?.call([...selectedItems]);
                              menuSetState(() {});
                            },
                            child: _SelectTagItem(
                              tag: tag,
                              selected: selected,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  if (widget.canInsertTag)
                    DropdownMenuItem(
                      value: null,
                      child: StatefulBuilder(
                        builder: (context, menuSetState) {
                          return _InsertTagItem(
                            controller: searchController,
                            spaceId: widget.spaceId,
                            onNewTagCreated: (tag) async {
                              setState(() {
                                selectedItems.add(tag);
                                allTags = [...allTags, tag];
                              });
                              widget.onChange?.call([...selectedItems]);
                              // This is tricky way to update the list item
                              // of dropdown as the lib currently doesn't support
                              // Regassign new key for dropdown
                              // so it can rebuild
                              dropdownKey =
                                  GlobalKey<DropdownButton2State<SpaceTag>>();
                              // Delay a bit then open dropdown again
                              await Future.delayed(
                                const Duration(milliseconds: 200),
                              );
                              searchController.clear();
                              dropdownKey.currentState?.callTap();
                            },
                          );
                        },
                      ),
                    ),
                ],
                dropdownStyleData: DropdownStyleData(
                  padding: EdgeInsets.zero,
                  width: 250.w,
                  maxHeight: 380.w,
                  scrollbarTheme: ScrollbarThemeData(
                    thickness: MaterialStateProperty.all(0),
                    thumbVisibility: MaterialStateProperty.all(false),
                    trackVisibility: MaterialStateProperty.all(false),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(LemonRadius.small),
                    color: LemonColor.chineseBlack,
                  ),
                  offset: Offset(0, -Spacing.superExtraSmall),
                ),
                menuItemStyleData:
                    MenuItemStyleData(padding: EdgeInsets.zero, height: 42.w),
              ),
            ),
            ...selectedItems.map((item) {
              return FittedBox(
                child: LemonOutlineButton(
                  radius: BorderRadius.circular(LemonRadius.button),
                  backgroundColor: LemonColor.chineseBlack,
                  textStyle: item.color.isNotEmpty == true
                      ? Typo.medium.copyWith(
                          color: Color(
                            int.parse('0xFF${item.color.substring(1)}'),
                          ),
                        )
                      : Typo.medium,
                  label: item.tag,
                  trailing: ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (filter) => Assets.icons.icClose.svg(
                      colorFilter: filter,
                      width: 16.w,
                      height: 16.w,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedItems.remove(item);
                    });
                  },
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

class _SelectTagItem extends StatelessWidget {
  final SpaceTag tag;
  final bool selected;
  const _SelectTagItem({
    required this.tag,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 42.w,
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.small,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (tag.color.isNotEmpty == true) ...[
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: Color(
                  int.parse('0xFF${tag.color.substring(1)}'),
                ),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: Spacing.extraSmall),
          ],
          Expanded(
            flex: 1,
            child: Text(
              tag.tag,
              style: Typo.medium.copyWith(
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
      ),
    );
  }
}

class _InsertTagItem extends StatefulWidget {
  final String spaceId;
  final TextEditingController controller;
  final Function(SpaceTag tag)? onNewTagCreated;

  const _InsertTagItem({
    required this.spaceId,
    required this.controller,
    this.onNewTagCreated,
  });

  @override
  State<_InsertTagItem> createState() => _InsertTagItemState();
}

class _InsertTagItemState extends State<_InsertTagItem> {
  String searchTagName = '';
  bool isLoading = false;
  final List<String> colorPalette = [
    '#D9D9D9',
    '#F5A9CB',
    '#C39BD3',
    '#9B59B6',
    '#5499C7',
    '#75C6D1',
    '#7DCEA0',
    '#F4D03F',
    '#F0B27A',
    '#F1948A',
  ];
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateSearchTagName);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateSearchTagName);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateSearchTagName();
  }

  void _updateSearchTagName() {
    setState(() {
      searchTagName = widget.controller.text;
    });
  }

  Future<void> _createNewTag() async {
    try {
      final random = Random();
      final randomColor = colorPalette[random.nextInt(colorPalette.length)];
      final result = await getIt<AppGQL>().client.mutate$InsertSpaceTag(
            Options$Mutation$InsertSpaceTag(
              variables: Variables$Mutation$InsertSpaceTag(
                input: Input$SpaceTagInput(
                  tag: searchTagName,
                  space: widget.spaceId,
                  color: randomColor,
                  type: Enum$SpaceTagType.event,
                ),
              ),
            ),
          );

      if (result.hasException || result.parsedData?.insertSpaceTag == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      final tag = SpaceTag.fromDto(
        SpaceTagDto.fromJson(
          result.parsedData!.insertSpaceTag.toJson(),
        ),
      );

      widget.onNewTagCreated?.call(tag);
      // widget.controller.clear();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return InkWell(
      onTap: () {
        if (isLoading) {
          return;
        }
        if (searchTagName.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          _createNewTag();
        }
      },
      child: Container(
        height: 42.w,
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.small,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLoading)
              Loading.defaultLoading(context)
            else ...[
              ThemeSvgIcon(
                color: LemonColor.paleViolet,
                builder: (filter) => Assets.icons.icPlus.svg(
                  colorFilter: filter,
                  width: Sizing.mSmall,
                  height: Sizing.mSmall,
                ),
              ),
              SizedBox(width: Spacing.small),
              Text(
                "${t.common.create} ${searchTagName.isNotEmpty ? "\"$searchTagName\"" : ''}",
                style: Typo.medium.copyWith(
                  color: LemonColor.paleViolet,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
