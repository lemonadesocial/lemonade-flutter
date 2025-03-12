import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
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
    this.hideLeading,
    this.bottom,
    this.onPressBack,
    this.backButtonColor,
  });

  final Widget? leading;
  final String? title;
  final Widget Function(BuildContext context)? titleBuilder;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final bool? hideLeading;
  final PreferredSizeWidget? bottom;
  final Function()? onPressBack;
  final Color? backButtonColor;

  static double get height => 60.w;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).colorScheme.background;
    return AppBar(
      backgroundColor: backgroundColor ?? background,
      automaticallyImplyLeading: hideLeading ?? true,
      leadingWidth: 100,
      leading: hideLeading ?? false
          ? null
          : leading ??
              LemonBackButton(
                onPressBack: onPressBack,
                color: backButtonColor,
              ),
      actions: actions,
      title: title != null
          ? buildCenteredTitle(title!)
          : (titleBuilder != null ? titleBuilder!(context) : null),
      centerTitle: true,
      elevation: 0,
      toolbarHeight: preferredSize.height,
      bottom: bottom,
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
