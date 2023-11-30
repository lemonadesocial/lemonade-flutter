import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class CustomNumberKeyboard extends StatelessWidget {
  final void Function(int value)? onNumberPressed;
  final void Function()? onClearPressed;
  final void Function()? onBackspacePressed;

  const CustomNumberKeyboard({
    super.key,
    this.onNumberPressed,
    this.onClearPressed,
    this.onBackspacePressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 270.w,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: Spacing.extraSmall,
          crossAxisSpacing: Spacing.extraSmall,
          childAspectRatio: 107.w / 60.w,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          final isZeroButton = index == 10;
          final isClearButton = index == 9;
          final isBackspace = index == 11;
          final buttonValue = isZeroButton ? 0 : index + 1;

          Widget childWidget = const SizedBox.shrink();

          childWidget = Text(
            buttonValue.toString(),
            style: Typo.extraMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          );

          if (isClearButton) {
            childWidget = ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icDelete.svg(
                colorFilter: filter,
                width: Sizing.xSmall,
                height: Sizing.xSmall,
              ),
            );
          }

          if (isBackspace) {
            childWidget = Assets.icons.icBackspace.svg(
              width: Sizing.xSmall,
              height: Sizing.xSmall,
            );
          }

          return InkWell(
            onTap: () {
              Vibrate.feedback(FeedbackType.light);
              if (isClearButton) {
                return onClearPressed?.call();
              }
              if (isBackspace) {
                return onBackspacePressed?.call();
              }

              onNumberPressed?.call(buttonValue);
            },
            child: Container(
              decoration: BoxDecoration(
                color: isClearButton || isBackspace
                    ? Colors.transparent
                    : LemonColor.atomicBlack,
                borderRadius: BorderRadius.circular(LemonRadius.large),
                border: isClearButton || isBackspace
                    ? Border.all(
                        color: colorScheme.outline,
                      )
                    : null,
              ),
              child: Center(
                child: childWidget,
              ),
            ),
          );
        },
      ),
    );
  }
}
