import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LemonAnimatedAppBar extends SliverPersistentHeaderDelegate {
  const LemonAnimatedAppBar({
    this.title,
    this.titleBuilder,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.padding,
    this.hideLeading,
  });

  final Widget? leading;
  final String? title;
  final Widget Function(BuildContext context, double shrinkOffset)?
      titleBuilder;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final bool? hideLeading;

  Size get preferredSize => Size.fromHeight(60.w);

  @override
  double get maxExtent => 60.w;

  @override
  double get minExtent => 60.w;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final primary = Theme.of(context).colorScheme.primary;
    return AppBar(
      backgroundColor: backgroundColor ?? primary,
      automaticallyImplyLeading: hideLeading ?? true,
      leading: hideLeading ?? false ? null : leading ?? const LemonBackButton(),
      actions: actions,
      title: title != null
          ? buildCenteredTitle(title!, shrinkOffset)
          : (titleBuilder != null
              ? titleBuilder!(context, shrinkOffset)
              : null),
      centerTitle: true,
      elevation: 0,
      toolbarHeight: preferredSize.height,
    );
  }

  Widget buildCenteredTitle(String title, double shrinkOffset) {
    return Transform.translate(
      offset: Offset(0, maxExtent - shrinkOffset),
      child: Text(
        title,
        style: Typo.extraMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
