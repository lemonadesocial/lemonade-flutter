import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class LemonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;

  const LemonAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
  });

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Container(
      color: primary,
      child: SafeArea(
        child: PreferredSize(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildLeading(),
                Text(
                  title ?? '',
                  style: Typo.large,
                ),
                Spacer(),
                buildActions()
              ],
            ),
          ),
          preferredSize: Size.fromHeight(preferredSize.height),
        ),
      ),
    );
  }

  Widget buildLeading() {
    return Container(
      height: double.infinity,
      width: preferredSize.height,
      child: leading ?? LemonBackButton(),
    );
  }

  Widget buildActions() {
    return Container(
        padding: EdgeInsets.only(right: 18),
        child: Row(
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
        ));
  }
}
