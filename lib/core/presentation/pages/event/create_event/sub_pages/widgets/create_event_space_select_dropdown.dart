import 'package:app/core/application/space/list_spaces_bloc/list_spaces_bloc.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';

class CreateEventSpaceSelectDropdown extends StatelessWidget {
  final Function(String spaceId)? onSpaceSelected;

  const CreateEventSpaceSelectDropdown({
    super.key,
    this.onSpaceSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        left: Spacing.smMedium,
      ),
      child: BlocBuilder<ListSpacesBloc, ListSpacesState>(
        builder: (context, spacesState) {
          return spacesState.maybeWhen(
            loading: () => Loading.defaultLoading(context),
            success: (spaces) {
              if (spaces.isEmpty) return const SizedBox.shrink();

              final sortedSpaces = spaces.toList()
                ..sort(
                  (a, b) => a.personal == b.personal
                      ? (a.title ?? '').compareTo(b.title ?? '')
                      : (a.personal ?? false)
                          ? -1
                          : 1,
                );

              return BlocBuilder<CreateEventBloc, CreateEventState>(
                builder: (context, createEventState) {
                  // Initialize with first personal space if no space is selected
                  if (createEventState.selectedSpaceId == null) {
                    final defaultSpaceId = sortedSpaces.first.id;
                    if (defaultSpaceId != null) {
                      context.read<CreateEventBloc>().add(
                            CreateEventEvent.onSpaceIdChanged(
                              spaceId: defaultSpaceId,
                            ),
                          );
                    }
                  }

                  final selectedSpace = sortedSpaces.firstWhere(
                    (space) => space.id == createEventState.selectedSpaceId,
                    orElse: () => sortedSpaces.first,
                  );

                  return DropdownButtonHideUnderline(
                    child: DropdownButton2<Space>(
                      isExpanded: false,
                      value: selectedSpace,
                      customButton: Padding(
                        padding: EdgeInsets.only(
                          right: Spacing.small,
                          top: Spacing.xSmall,
                          bottom: Spacing.xSmall,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(LemonRadius.normal),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LemonNetworkImage(
                                imageUrl: selectedSpace.getSpaceImageUrl(),
                                width: Sizing.mSmall,
                                height: Sizing.mSmall,
                                fit: BoxFit.cover,
                                borderRadius:
                                    BorderRadius.circular(Sizing.mSmall),
                                placeholder: ImagePlaceholder.spaceThumbnail(
                                  iconColor: colorScheme.onSecondary,
                                  backgroundColor: LemonColor.white06,
                                  padding: EdgeInsets.all(
                                    Spacing.superExtraSmall / 2,
                                  ),
                                ),
                              ),
                              SizedBox(width: Spacing.superExtraSmall),
                              ThemeSvgIcon(
                                color: Theme.of(context).colorScheme.onPrimary,
                                builder: (filter) =>
                                    Assets.icons.icArrowDown.svg(
                                  colorFilter: filter,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      items: sortedSpaces.map((space) {
                        return DropdownMenuItem<Space>(
                          value: space,
                          child: _SpaceItem(
                            space: space,
                            isSelected: space.id == selectedSpace.id,
                          ),
                        );
                      }).toList(),
                      onChanged: (space) {
                        if (space != null) {
                          onSpaceSelected?.call(space.id ?? '');
                        }
                      },
                      dropdownStyleData: DropdownStyleData(
                        padding: EdgeInsets.zero,
                        width: 250.w,
                        maxHeight: 300.h,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(LemonRadius.normal),
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                        offset: Offset(
                          -Spacing.superExtraSmall,
                          Spacing.superExtraSmall,
                        ),
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchInnerWidgetHeight: 50.h,
                        searchInnerWidget: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacing.medium,
                            vertical: Spacing.small,
                          ),
                          child: Text(
                            Translations.of(context).space.chooseCommunity,
                            style: Typo.small.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        padding: EdgeInsets.zero,
                        height: 48.w,
                      ),
                    ),
                  );
                },
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _SpaceItem extends StatelessWidget {
  final Space? space;
  final bool isSelected;

  const _SpaceItem({
    required this.space,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final imageUrl = space?.getSpaceImageUrl() ?? '';

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.small,
        vertical: Spacing.xSmall,
      ),
      height: 48.h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 32.w,
            height: 32.w,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: LemonNetworkImage(
                imageUrl: imageUrl,
                width: Sizing.medium,
                height: Sizing.medium,
                borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                placeholder: ImagePlaceholder.spaceThumbnail(
                  iconColor: colorScheme.onSecondary,
                  backgroundColor: LemonColor.white06,
                  padding: EdgeInsets.all(Spacing.superExtraSmall),
                ),
              ),
            ),
          ),
          SizedBox(width: Spacing.small),
          Expanded(
            child: Text(
              space?.title ?? '',
              style: Typo.small.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (isSelected)
            Icon(
              Icons.check,
              color: colorScheme.onPrimary,
              size: 16.w,
            ),
        ],
      ),
    );
  }
}
