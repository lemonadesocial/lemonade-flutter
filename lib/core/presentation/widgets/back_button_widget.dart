import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class LemonBackButton extends StatelessWidget {
  const LemonBackButton({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).pop();
      },
      child: Center(
        child: ThemeSvgIcon(
          color: color ?? appColors.textTertiary,
          builder: (filter) => Assets.icons.icBack.svg(
            colorFilter: filter,
            // fit: BoxFit.scaleDown,
            width: Sizing.small,
            height: Sizing.small,
          ),
        ),
      ),
    );
  }
}
