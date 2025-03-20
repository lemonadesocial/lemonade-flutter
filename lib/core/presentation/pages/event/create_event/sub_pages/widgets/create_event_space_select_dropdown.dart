import 'package:app/core/application/space/list_spaces_bloc/list_spaces_bloc.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
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

class CreateEventSpaceSelectDropdown extends StatefulWidget {
  final Function(String spaceId)? onSpaceSelected;
  final String? selectedSpaceId;

  const CreateEventSpaceSelectDropdown({
    super.key,
    this.onSpaceSelected,
    this.selectedSpaceId,
  });

  @override
  State<CreateEventSpaceSelectDropdown> createState() =>
      _CreateEventSpaceSelectDropdownState();
}

class _CreateEventSpaceSelectDropdownState
    extends State<CreateEventSpaceSelectDropdown> {
  Space? selectedSpace;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Padding(
      padding: EdgeInsets.only(left: Spacing.medium),
      child: BlocBuilder<ListSpacesBloc, ListSpacesState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => Loading.defaultLoading(context),
            success: (spaces) {
              // Sort spaces by personal first, then sort by title
              final sortedSpaces = spaces.toList()
                ..sort(
                  (a, b) => a.personal == b.personal
                      ? (a.title ?? '').compareTo(b.title ?? '')
                      : (a.personal ?? false)
                          ? -1
                          : 1,
                );

              if (selectedSpace == null) {
                if (widget.selectedSpaceId != null) {
                  selectedSpace = sortedSpaces.firstWhere(
                    (space) => space.id == widget.selectedSpaceId,
                    orElse: () => sortedSpaces.first,
                  );
                } else {
                  selectedSpace = sortedSpaces.first;
                }
              }

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
                        borderRadius: BorderRadius.circular(LemonRadius.normal),
                        border: Border.all(color: colorScheme.outline),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LemonNetworkImage(
                            imageUrl: selectedSpace?.imageAvatar?.url ??
                                selectedSpace?.creatorExpanded?.imageAvatar ??
                                '',
                            width: Sizing.mSmall,
                            height: Sizing.mSmall,
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(Sizing.mSmall),
                            placeholder: ImagePlaceholder.defaultPlaceholder(),
                          ),
                          SizedBox(width: Spacing.superExtraSmall),
                          ThemeSvgIcon(
                            color: colorScheme.onPrimary,
                            builder: (filter) => Assets.icons.icArrowDown.svg(
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
                        isSelected: space.id == selectedSpace?.id,
                      ),
                    );
                  }).toList(),
                  onChanged: (space) {
                    if (space != null) {
                      setState(() {
                        selectedSpace = space;
                      });
                      widget.onSpaceSelected?.call(space.id ?? '');
                    }
                  },
                  dropdownStyleData: DropdownStyleData(
                    padding: EdgeInsets.zero,
                    width: 250.w,
                    maxHeight: 300.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(LemonRadius.normal),
                      color: colorScheme.secondaryContainer,
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
                        t.space.chooseCommunity,
                        style: Typo.small.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  menuItemStyleData:
                      MenuItemStyleData(padding: EdgeInsets.zero, height: 48.w),
                ),
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
    final spaceImageAvatarUrl = space?.imageAvatar?.url ?? '';
    final fallbackCreatorImageAvatar =
        space?.creatorExpanded?.imageAvatar ?? '';
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
                imageUrl: spaceImageAvatarUrl.isEmpty
                    ? fallbackCreatorImageAvatar
                    : spaceImageAvatarUrl,
                fit: BoxFit.contain,
                placeholder: ImagePlaceholder.avatarPlaceholder(),
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
