import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return InkWell(
      onTap: () {
        Vibrate.feedback(FeedbackType.light);
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        decoration: BoxDecoration(
          color: appColors.cardBg,
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
                    style: appText.md,
                  ),
                  SizedBox(height: 2.w),
                  description != ''
                      ? Text(
                          description,
                          style: appText.sm.copyWith(
                            color: appColors.textTertiary,
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
                    color: appColors.textTertiary,
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
