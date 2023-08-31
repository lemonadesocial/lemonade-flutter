import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:flutter/material.dart';

class LemonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LemonAppBar({
    Key? key,
    this.title,
    this.titleBuilder,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.padding,
    this.hideLeading,
  }) : super(key: key);

  final Widget? leading;
  final String? title;
  final Widget Function(BuildContext context)? titleBuilder;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final bool? hideLeading;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return AppBar(
      backgroundColor: backgroundColor ?? primary,
      automaticallyImplyLeading: hideLeading ?? true,
      leading: hideLeading ?? false ? null : leading ?? const LemonBackButton(),
      actions: actions,
      title: title != null
          ? buildCenteredTitle(title!)
          : (titleBuilder != null ? titleBuilder!(context) : null),
      centerTitle: true,
      elevation: 0,
      toolbarHeight: preferredSize.height,
    );
  }

  Widget buildCenteredTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
