import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorDiscoverBasicInfoSection extends StatelessWidget {
  const CollaboratorDiscoverBasicInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Madelyn Franci',
                style: Typo.extraLarge.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onPrimary,
                  fontFamily: FontFamily.nohemiVariable,
                ),
              ),
              SizedBox(width: Spacing.smMedium / 2),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.w),
                decoration: ShapeDecoration(
                  color: LemonColor.acidGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '@madfranci',
                      style: Typo.small.copyWith(
                        color: LemonColor.paleViolet,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Spacing.extraSmall),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Sizing.medium / 2,
                height: Sizing.medium / 2,
                child: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (colorFilter) => Assets.icons.icBriefcase.svg(
                    colorFilter: colorFilter,
                  ),
                ),
              ),
              SizedBox(width: Spacing.superExtraSmall),
              Expanded(
                child: SizedBox(
                  child: Text(
                    'Systems analyst at Mitsubishi',
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
