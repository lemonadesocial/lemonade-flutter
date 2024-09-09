import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class CollaboratorCircleWidget extends StatelessWidget {
  const CollaboratorCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: Sizing.xLarge,
      height: Sizing.xLarge,
      padding: EdgeInsets.all(Spacing.small),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            LemonColor.white12,
            LemonColor.white06,
          ],
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: LemonColor.white03,
          ),
          borderRadius: BorderRadius.circular(Sizing.medium),
        ),
      ),
      child: Center(
        child: Container(
          width: Sizing.regular,
          height: Sizing.regular,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.24),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SizedBox(
            width: Sizing.regular,
            height: Sizing.regular,
            child: ThemeSvgIcon(
              builder: (colorFilter) =>
                  Assets.icons.icUserGroupNetworkGradient.svg(
                width: Sizing.regular,
                height: Sizing.regular,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
