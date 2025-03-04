import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceInfo extends StatelessWidget {
  const SpaceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(),
              SizedBox(
                width: 100.w,
                height: Sizing.medium,
                child: LinearGradientButton.primaryButton(
                  radius: BorderRadius.circular(LemonRadius.button),
                  textStyle: Typo.medium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                  label: "Subscribe",
                  onTap: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: Spacing.small),
          // Space name
          Text(
            'Culture Fest',
            style: Typo.extraLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: Spacing.superExtraSmall),
          // Description
          Text(
            'Description about this space goes here. This can be multiple lines of text describing what this space is about.',
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          SizedBox(height: Spacing.superExtraSmall),
          Row(
            children: [
              ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icLocationPin.svg(
                  colorFilter: filter,
                ),
              ),
              SizedBox(width: Spacing.superExtraSmall),
              Text(
                'Location',
                style: Typo.medium.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: Spacing.small),
          Row(
            children: <SvgGenImage>[
              Assets.icons.icXLine,
              Assets.icons.icInstagram,
              Assets.icons.icLinkedin,
            ].map((item) {
              return Container(
                width: Sizing.medium,
                height: Sizing.medium,
                margin: EdgeInsets.only(right: Spacing.superExtraSmall),
                decoration: ShapeDecoration(
                  color: LemonColor.chineseBlack,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(LemonRadius.button),
                  ),
                ),
                child: Center(
                  child: ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (filter) => item.svg(
                      colorFilter: filter,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
