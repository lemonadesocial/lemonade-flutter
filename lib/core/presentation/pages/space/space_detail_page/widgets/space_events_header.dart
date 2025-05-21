import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/data/space/dtos/space_tag_dto.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/domain/space/entities/space_tag.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/graphql/backend/space/query/list_space_tags.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class SpaceEventsHeader extends StatefulWidget {
  final Space space;
  final Function(SpaceTag?) onTagChange;
  final Function(SpaceTag?) onRefresh;

  const SpaceEventsHeader({
    super.key,
    required this.space,
    required this.onTagChange,
    required this.onRefresh,
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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    final userId = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (user) => user.userId,
          orElse: () => null,
        );
    final isSpaceAdmin = widget.space.isAdmin(userId: userId ?? '');
    final isSpaceOwner = widget.space.isCreator(userId: userId ?? '');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Query$ListSpaceTags$Widget(
            options: Options$Query$ListSpaceTags(
              variables:
                  Variables$Query$ListSpaceTags(space: widget.space.id ?? ''),
            ),
            builder: (
              result, {
              fetchMore,
              refetch,
            }) {
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
                      .where(
                        (element) =>
                            element.targets != null &&
                            element.targets!.isNotEmpty,
                      )
                      .toList() ??
                  [];

              return Column(
                children: [
                  if (tags.isNotEmpty)
                    SizedBox(
                      height: Sizing.medium,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            // final isActive = selectedTag == null;
                            return LemonOutlineButton(
                              onTap: () {
                                _changeTag(null);
                              },
                              label: t.common.all,
                              radius: BorderRadius.circular(LemonRadius.full),
                              textStyle: appText.sm.copyWith(
                                color: appColors.textSecondary,
                              ),
                              borderColor: appColors.pageDivider,
                              backgroundColor: Colors.transparent,
                            );
                          }
                          final tag = tags[index - 1];
                          return LemonOutlineButton(
                            onTap: () {
                              _changeTag(tag);
                            },
                            label: tag.tag,
                            radius: BorderRadius.circular(LemonRadius.full),
                            textStyle: appText.sm.copyWith(
                              color: appColors.textSecondary,
                            ),
                            borderColor: appColors.pageDivider,
                            backgroundColor: Colors.transparent,
                            leading: (isSpaceAdmin || isSpaceOwner)
                                ? Container(
                                    width: 8.w,
                                    height: 8.w,
                                    decoration: BoxDecoration(
                                      color: tag.color.isNotEmpty == true
                                          ? Color(
                                              int.parse(
                                                tag.color
                                                    .replaceAll('#', '0xFF'),
                                              ),
                                            )
                                          : Colors.amber,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : null,
                            trailing: Text(
                              tag.targets?.length.toString() ?? '0',
                              style: appText.sm.copyWith(
                                color: appColors.textTertiary,
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
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
