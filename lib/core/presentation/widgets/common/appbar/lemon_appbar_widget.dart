import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class LemonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String? title;
  final Widget Function(BuildContext context)? titleBuilder;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  const LemonAppBar({
    super.key,
    this.title,
    this.titleBuilder,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.padding,
  });

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Container(
      color: backgroundColor ?? primary,
      padding: padding,
      child: SafeArea(
        child: PreferredSize(
          preferredSize: Size.fromHeight(preferredSize.height),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildLeading(),
              if (title?.isNotEmpty ?? false)
                Flexible(
                  child: Center(
                    child: Text(
                      title!,
                      style: Typo.large.copyWith(fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              if (titleBuilder != null) titleBuilder!.call(context),
              buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLeading() {
    return leading ?? LemonBackButton();
  }

  Widget buildActions() {
    return Container(
      padding: EdgeInsets.only(right: 18),
      child: actions?.isNotEmpty == true
          ? Row(
              children: List.from(actions ?? [])
                  .map(
                    (item) => Container(
                      margin: EdgeInsets.only(left: Spacing.medium),
                      width: Sizing.small,
                      height: preferredSize.height,
                      child: item,
                    ),
                  )
                  .toList(),
            )
          : Container(
              margin: EdgeInsets.only(left: Spacing.medium),
              width: Sizing.small,
              height: preferredSize.height,
            ),
    );
  }
}
