import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

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
    this.leadingWidth,
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
  final double? leadingWidth;

  static double get height => 60.w;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).colorScheme.background;
    return AppBar(
      backgroundColor: backgroundColor ?? background,
      automaticallyImplyLeading: hideLeading ?? true,
      leadingWidth: leadingWidth,
      leading: hideLeading ?? false
          ? null
          : leading ??
              LemonBackButton(
                onPressBack: onPressBack,
                color: backButtonColor,
              ),
      actions: actions,
      title: title != null
          ? buildCenteredTitle(context, title!)
          : (titleBuilder != null ? titleBuilder!(context) : null),
      centerTitle: true,
      elevation: 0,
      toolbarHeight: preferredSize.height,
      bottom: bottom,
    );
  }

  Widget buildCenteredTitle(BuildContext context, String title) {
    final appText = context.theme.appTextTheme;
    return Text(
      title,
      style: appText.lg,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
