import 'package:app/core/data/space/dtos/space_tag_dto.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/domain/space/entities/space_tag.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/submit_event_options_bottomsheet.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/space/query/list_space_tags.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceEventsHeader extends StatefulWidget {
  final Space space;
  final Function(SpaceTag?) onTagChange;
  const SpaceEventsHeader({
    super.key,
    required this.space,
    required this.onTagChange,
  });

  @override
  State<SpaceEventsHeader> createState() => _SpaceEventsHeaderState();
}

class _SpaceEventsHeaderState extends State<SpaceEventsHeader> {
  SpaceTag? selectedTag;

  void _changeTag(SpaceTag? tag) {
    setState(() {
      selectedTag = tag;
    });
    widget.onTagChange(tag);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.event.events,
                style: Typo.extraMedium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              LemonOutlineButton(
                leading: Assets.icons.icPlus.svg(),
                onTap: () {
                  SubmitEventOptionsBottomsheet.show(context);
                },
                label: t.space.submitEvent,
                radius: BorderRadius.circular(LemonRadius.button),
                backgroundColor: LemonColor.chineseBlack,
                textStyle: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          Query$ListSpaceTags$Widget(
            options: Options$Query$ListSpaceTags(
              variables:
                  Variables$Query$ListSpaceTags(space: widget.space.id ?? ''),
            ),
            builder: (result, {fetchMore, refetch}) {
              if (result.parsedData?.listSpaceTags == null) {
                return const SizedBox.shrink();
              }
              final tags = result.parsedData?.listSpaceTags
                      .map(
                        (e) => SpaceTag.fromDto(
                          SpaceTagDto.fromJson(
                            e.toJson(),
                          ),
                        ),
                      )
                      .toList() ??
                  [];

              if (tags.isEmpty) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: EdgeInsets.symmetric(vertical: Spacing.small),
                child: SizedBox(
                  height: Sizing.medium,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        final isActive = selectedTag == null;
                        return LemonOutlineButton(
                          onTap: () {
                            _changeTag(null);
                          },
                          label: t.common.all,
                          radius: BorderRadius.circular(LemonRadius.button),
                          textStyle: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                          backgroundColor: isActive
                              ? LemonColor.chineseBlack
                              : Colors.transparent,
                        );
                      }
                      final tag = tags[index - 1];
                      final isActive = selectedTag?.id == tag.id;
                      return LemonOutlineButton(
                        onTap: () {
                          _changeTag(tag);
                        },
                        label: tag.tag,
                        radius: BorderRadius.circular(LemonRadius.button),
                        textStyle: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                        backgroundColor: isActive
                            ? LemonColor.chineseBlack
                            : Colors.transparent,
                        leading: Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            color: tag.color.isNotEmpty == true
                                ? Color(
                                    int.parse(
                                      tag.color.replaceAll('#', '0xFF'),
                                    ),
                                  )
                                : Colors.amber,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      width: Spacing.extraSmall,
                    ),
                    itemCount: tags.length + 1,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
