import 'dart:ui';

import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class FrostedGlassDropdown<T> extends StatefulWidget {

  const FrostedGlassDropdown({
    super.key,
    required this.items,
    this.itemBuilder,
    this.isEqual,
    this.onItemPressed,
  });
  final List<DropdownItemDpo<T>> items;
  final Widget Function(BuildContext ctx, int index)? itemBuilder;
  final bool Function(DropdownItemDpo<T> a, DropdownItemDpo<T> b)? isEqual;
  final Function(DropdownItemDpo<T>? item)? onItemPressed;

  @override
  State<FrostedGlassDropdown<T>> createState() => _FrostedGlassDropdownController<T>();
}

class _FrostedGlassDropdownController<T> extends State<FrostedGlassDropdown<T>> {
  DropdownItemDpo<T>? selectedItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Spacing.superExtraSmall),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Spacing.superExtraSmall),
            width: 210,
            color: LemonColor.dropdownBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children:
                  List.generate(widget.items.length, (index) => _buildItem(context, index, item: widget.items[index])),
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildItem(BuildContext ctx, int index, {required DropdownItemDpo<T> item}) {
    if (widget.itemBuilder != null) return widget.itemBuilder?.call(ctx, index);

    final isSelected =
        selectedItem == null || widget.isEqual == null ? false : widget.isEqual!.call(selectedItem!, item);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        final newItem = isSelected ? null : item;
        widget.onItemPressed?.call(newItem);
        setState(() {
          selectedItem = newItem;
        });
      },
      child: Container(
        color: isSelected ? Colors.white.withOpacity(6/100) : Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: Spacing.small, vertical: Spacing.small),
        child: Row(
          children: [
            Text(item.label),
            const Spacer(),
            if (isSelected)
              ThemeSvgIcon(builder: (filter) => Assets.icons.icDone.svg(colorFilter: filter, width: 18, height: 18)),
          ],
        ),
      ),
    );
  }
}
