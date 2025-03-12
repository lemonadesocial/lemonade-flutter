import 'package:app/core/application/space/list_spaces_bloc/list_spaces_bloc.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectSpaceToTransferDropdown extends StatelessWidget {
  const SelectSpaceToTransferDropdown({
    super.key,
    this.initialSpaceId,
    this.onChange,
  });

  final String? initialSpaceId;
  final Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListSpacesBloc(
        spaceRepository: getIt<SpaceRepository>(),
      )..add(
          const ListSpacesEvent.fetch(
            withMySpaces: true,
            roles: [
              Enum$SpaceRole.admin,
              Enum$SpaceRole.creator,
            ],
          ),
        ),
      child: _View(
        initialSpaceId: initialSpaceId,
        onChange: onChange,
      ),
    );
  }
}

class _View extends StatefulWidget {
  final String? initialSpaceId;
  final Function(String?)? onChange;
  const _View({
    this.initialSpaceId,
    this.onChange,
  });

  @override
  State<_View> createState() => __ViewState();
}

class __ViewState extends State<_View> {
  Space? selectedSpace;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListSpacesBloc, ListSpacesState>(
      builder: (context, state) {
        final spaces = state.maybeWhen(
          orElse: () => <Space>[],
          success: (spaces) => spaces,
        );
        return DropdownButtonHideUnderline(
          child: DropdownButton2<Space>(
            alignment: AlignmentDirectional.bottomStart,
            items: spaces.map((Space space) {
              return DropdownMenuItem<Space>(
                value: space,
                child: _Item(
                  space: space,
                  hasArrowIcon: false,
                  backgroundColor: LemonColor.chineseBlack,
                ),
              );
            }).toList(),
            value: selectedSpace,
            onChanged: (Space? newValue) {
              setState(() {
                selectedSpace = newValue;
              });
              widget.onChange?.call(newValue?.id);
            },
            customButton: _Item(space: selectedSpace, hasBorder: true),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                color: LemonColor.chineseBlack,
                borderRadius: BorderRadius.circular(LemonRadius.medium),
              ),
              maxHeight: 300.w,
              offset: Offset(0, 210.w),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.zero,
            ),
          ),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.space,
    this.hasArrowIcon = true,
    this.hasBorder = false,
    this.backgroundColor,
  });

  final Space? space;
  final bool hasArrowIcon;
  final bool hasBorder;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
        border:
            hasBorder ? Border.all(color: colorScheme.outlineVariant) : null,
      ),
      padding: EdgeInsets.all(Spacing.small),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Opacity(
            opacity: space == null ? 0.5 : 1,
            child: LemonNetworkImage(
              imageUrl: space?.imageAvatar?.url ?? '',
              width: 18.w,
              height: 18.w,
              borderRadius: BorderRadius.circular(4.r),
              placeholder: ImagePlaceholder.spaceThumbnail(),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Text(
              space != null
                  ? space?.title ?? ''
                  : t.space.transferEventSpace.selectCommunity,
              style: Typo.medium.copyWith(
                color: space == null
                    ? colorScheme.onSecondary
                    : colorScheme.onPrimary,
              ),
            ),
          ),
          if (hasArrowIcon)
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icDoubleArrowUpDown.svg(
                colorFilter: filter,
              ),
            ),
        ],
      ),
    );
  }
}
