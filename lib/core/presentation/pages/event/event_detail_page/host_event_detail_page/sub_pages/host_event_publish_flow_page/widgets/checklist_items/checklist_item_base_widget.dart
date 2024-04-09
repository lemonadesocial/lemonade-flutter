import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckListItemBaseWidget extends StatelessWidget {
  final bool fullfiled;
  final String title;
  final SvgGenImage icon;
  final Widget? child;
  final Function()? onTap;

  const CheckListItemBaseWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.fullfiled,
    this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(LemonRadius.medium),
                topRight: Radius.circular(LemonRadius.medium),
                bottomLeft: child == null
                    ? Radius.circular(LemonRadius.medium)
                    : Radius.zero,
                bottomRight: child == null
                    ? Radius.circular(LemonRadius.medium)
                    : Radius.zero,
              ),
            ),
            child: Row(
              children: [
                ThemeSvgIcon(
                  color: fullfiled
                      ? colorScheme.onSecondary
                      : colorScheme.onPrimary,
                  builder: (colorFilter) => icon.svg(
                    colorFilter: colorFilter,
                    width: 18.w,
                    height: 18.w,
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
                Text(
                  title,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
                const Spacer(),
                ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (colorFilter) => Assets.icons.icArrowRight.svg(
                    colorFilter: colorFilter,
                  ),
                ),
              ],
            ),
          ),
          if (child != null)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(LemonRadius.medium),
                  bottomRight: Radius.circular(LemonRadius.medium),
                ),
              ),
              child: child,
            ),
        ],
      ),
    );
  }
}
