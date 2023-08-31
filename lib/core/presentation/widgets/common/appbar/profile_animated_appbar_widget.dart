import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAnimatedAppBar extends SliverPersistentHeaderDelegate {
  const ProfileAnimatedAppBar({
    this.title,
    this.leading,
    this.actions,
  });
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent,) {
    final primary = Theme.of(context).colorScheme.primary;
    return ClipRect(
      child: Container(
        color: primary,
        height: maxExtent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildLeading(),
            Transform.translate(
              offset: Offset(0, maxExtent - shrinkOffset),
              child: Text(
                title ?? '',
                style: Typo.large,
              ),
            ),
            // Spacer(),
            buildActions()
          ],
        ),
      ),
    );
  }

  Widget buildLeading() {
    return Container(
      padding: EdgeInsets.only(left: 15.w),
      height: maxExtent,
      child: leading ?? const LemonBackButton(),
    );
  }

  Widget buildActions() {
    return Container(
      padding: EdgeInsets.only(right: 15.w),
      child: Row(
        children: List.from(actions ?? [])
            .map(
              (item) => Container(
                margin: EdgeInsets.only(left: Spacing.medium),
                width: Sizing.small,
                height: maxExtent,
                child: item,
              ),
            )
            .toList(),
      ),
    );
  }
}
