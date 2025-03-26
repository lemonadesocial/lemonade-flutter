import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/space/get_my_space_event_requests_bloc/get_my_space_event_requests_bloc.dart';
import 'package:app/core/application/space/get_space_detail_bloc/get_space_detail_bloc.dart';
import 'package:app/core/data/space/dtos/space_tag_dto.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/domain/space/entities/space_tag.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/pin_event_options_bottomsheet.dart';
import 'package:app/core/presentation/pages/space/pin_existing_event_to_space_page/pin_existing_event_to_space_page.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_event_requests_list.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/graphql/backend/space/query/list_space_tags.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
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
                        onTap: () async {
                          final spaceDetailBloc =
                              context.read<GetSpaceDetailBloc>();
                          final option = await showCupertinoModalBottomSheet<
                              PinEventOptions>(
                            context: context,
                            backgroundColor: LemonColor.atomicBlack,
                            barrierColor: Colors.black.withOpacity(0.5),
                            expand: false,
                            builder: (innerContext) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: spaceDetailBloc,
                                ),
                              ],
                              child: const PinEventOptionsBottomsheet(),
                            ),
                          );
                          if (option == PinEventOptions.newEvent) {
                            // Allow create event if space is admin or ambassador
                            if (widget.space.isAdmin(userId: userId ?? '') ||
                                widget.space.isAmbassador == true) {
                              await AutoRouter.of(context).push(
                                CreateEventRoute(
                                  spaceId: widget.space.id,
                                ),
                              );
                            }
                            // Otherwise, need submit to space
                            else {
                              await AutoRouter.of(context).push(
                                CreateEventRoute(
                                  spaceId: null,
                                  submittingToSpaceId: widget.space.id,
                                ),
                              );
                            }
                          }
                          if (option == PinEventOptions.existingEvent) {
                            final value =
                                await PinExistingEventToSpacePage.show(
                              context,
                              space: widget.space,
                            );
                            if (value != null) {
                              refetch?.call();
                              widget.onRefresh(selectedTag);
                            }
                          }
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
                  if (tags.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: Spacing.small),
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
                                radius:
                                    BorderRadius.circular(LemonRadius.button),
                                textStyle: Typo.medium.copyWith(
                                  color: colorScheme.onPrimary,
                                ),
                                backgroundColor: isActive
                                    ? colorScheme.onPrimary.withOpacity(0.18)
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
                                fontWeight: FontWeight.w600,
                              ),
                              backgroundColor: isActive
                                  ? colorScheme.onPrimary.withOpacity(0.18)
                                  : Colors.transparent,
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
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            width: Spacing.extraSmall,
                          ),
                          itemCount: tags.length + 1,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          BlocBuilder<GetMySpaceEventRequestsBloc,
              GetMySpaceEventRequestsState>(
            builder: (context, state) {
              return state.maybeWhen(
                success: (response) {
                  final filteredRecords = response.records
                      .where(
                        (element) =>
                            element.state ==
                            Enum$SpaceEventRequestState.pending,
                      )
                      .toList();

                  return filteredRecords.isEmpty
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: EdgeInsets.only(top: Spacing.small),
                          child: Column(
                            children: [
                              SpaceEventRequestsList(requests: filteredRecords),
                              Divider(
                                height: Spacing.smMedium * 2,
                                thickness: 1.w,
                                color: colorScheme.outline,
                              ),
                            ],
                          ),
                        );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
    );
  }
}
