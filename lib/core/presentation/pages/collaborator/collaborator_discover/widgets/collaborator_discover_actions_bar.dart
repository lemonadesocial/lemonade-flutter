import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorDiscoverActionsBar extends StatelessWidget {
  const CollaboratorDiscoverActionsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icDeclineCollaborator.svg(
              width: 60.w,
              height: 60.w,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icLikeCollaborator.svg(
              width: 60.w,
              height: 60.w,
            ),
          ),
        ),
      ],
    );
  }
}
