import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class CollaboratorProfileFieldCard extends StatelessWidget {
  final String title;
  final String description;
  final Function()? onTap;
  final bool? hideArrowButton;

  const CollaboratorProfileFieldCard({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
    this.hideArrowButton,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        Vibrate.feedback(FeedbackType.light);
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2.w),
                  description != ''
                      ? Text(
                          description,
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            hideArrowButton == false
                ? ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (filter) => Assets.icons.icArrowRight.svg(
                      colorFilter: filter,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
