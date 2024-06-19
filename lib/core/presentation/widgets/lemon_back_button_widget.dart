import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class LemonBackButton extends StatelessWidget {
  const LemonBackButton({super.key, this.color, this.onPressBack});

  final Color? color;
  final Function()? onPressBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPressBack != null) {
          onPressBack?.call();
          return;
        }
        AutoRouter.of(context).pop();
      },
      child: ThemeSvgIcon(
        color: color ?? Theme.of(context).colorScheme.onPrimary,
        builder: (filter) => Assets.icons.icBack.svg(
          colorFilter: filter,
          fit: BoxFit.scaleDown,
          width: Sizing.small,
          height: Sizing.small,
        ),
      ),
    );
  }
}
