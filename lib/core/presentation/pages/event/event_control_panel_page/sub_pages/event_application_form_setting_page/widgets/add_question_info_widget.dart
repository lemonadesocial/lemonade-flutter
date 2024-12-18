import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddQuestionInfoWidget extends StatelessWidget {
  final String title;
  final String description;
  final Widget? icon;
  const AddQuestionInfoWidget({
    super.key,
    required this.title,
    required this.description,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.only(
        left: Spacing.small,
        right: Spacing.small,
        bottom: Spacing.xSmall,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            padding: EdgeInsets.all(Spacing.extraSmall),
            decoration: BoxDecoration(
              color: LemonColor.chineseBlack,
              borderRadius: BorderRadius.circular(LemonRadius.medium / 2),
              border: Border.all(
                color: colorScheme.outlineVariant,
              ),
            ),
            child: Center(
              child: icon ??
                  ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (filter) => Assets.icons.icInfo.svg(
                      colorFilter: filter,
                    ),
                  ),
            ),
          ),
          SizedBox(width: Spacing.small),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                description,
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
