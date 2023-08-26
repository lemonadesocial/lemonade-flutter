import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LemonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LemonAppBar({
    super.key,
    this.title,
    this.titleBuilder,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.padding,
  });
  final Widget? leading;
  final String? title;
  final Widget Function(BuildContext context)? titleBuilder;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  @override
  Size get preferredSize => Size.fromHeight(60.w);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Container(
      color: backgroundColor ?? primary,
      padding: padding,
      child: SafeArea(
        child: PreferredSize(
          preferredSize: Size.fromHeight(preferredSize.height),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildLeading(),
                    const Spacer(),
                    buildActions(),
                  ],
                ),
              ),
              buildCenteredTitle(title!),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCenteredTitle(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18, 
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget buildLeading() {
    return Padding(
      padding: EdgeInsets.only(left: Spacing.small),
      child: leading ?? const LemonBackButton(),
    );
  }

  Widget buildActions() {
    return Padding(
      padding: EdgeInsets.only(right: Spacing.small),
      child: actions?.isNotEmpty ?? false
          ? Row(
              children: List.from(actions ?? [])
                  .map(
                    (item) => SizedBox(
                      height: preferredSize.height,
                      child: item,
                    ),
                  )
                  .toList(),
            )
          : SizedBox(
              width: Sizing.small,
              height: preferredSize.height,
            ),
    );
  }
}
