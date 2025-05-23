import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

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
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return ClipRect(
      child: Container(
        color: appColors.pageBg,
        height: maxExtent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildLeading(),
            Transform.translate(
              offset: Offset(0, maxExtent - shrinkOffset),
              child: Text(
                title ?? '',
                style: appText.md,
              ),
            ),
            // Spacer(),
            buildActions(),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.from(actions ?? [])
          .map(
            (item) => Container(
              margin: EdgeInsets.only(left: Spacing.medium),
              child: item,
            ),
          )
          .toList(),
    );
  }
}
