import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_animated_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class PostGuestEventAnimatedAppBar extends LemonAnimatedAppBar {
  final Event event;

  PostGuestEventAnimatedAppBar({
    required this.event,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = Theme.of(context).colorScheme.primary;
    return AppBar(
      backgroundColor: backgroundColor ?? primary,
      automaticallyImplyLeading: hideLeading ?? true,
      leading: hideLeading ?? false ? null : leading ?? const LemonBackButton(),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: Spacing.smMedium),
          child: InkWell(
            onTap: () {
              Vibrate.feedback(FeedbackType.light);
              SnackBarUtils.showComingSoon();
            },
            child: ThemeSvgIcon(
              color: colorScheme.onPrimary,
              builder: (filter) => Assets.icons.icMoreHoriz.svg(
                colorFilter: filter,
                width: 25.w,
                height: 25.w,
              ),
            ),
          ),
        ),
      ],
      centerTitle: true,
      elevation: 0,
      toolbarHeight: preferredSize.height,
    );
  }
}
