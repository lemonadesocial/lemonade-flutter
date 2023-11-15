import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AIMetadataButtonCard extends StatelessWidget {
  const AIMetadataButtonCard({
    Key? key,
    this.onTap,
    required this.colors,
    required this.title,
    required this.description,
    this.suffixIcon,
    this.featureAvailable = false,
  }) : super(key: key);

  final VoidCallback? onTap;
  final List<Color> colors;
  final String title;
  final String description;
  final Widget? suffixIcon;
  final bool featureAvailable;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 128.h,
            margin: EdgeInsets.only(
              left: 70.w,
              right: Spacing.smMedium,
              bottom: Spacing.smMedium,
            ),
            padding: EdgeInsets.all(Spacing.smMedium),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              gradient: RadialGradient(
                radius: 2,
                center: Alignment.topRight,
                colors: colors,
              ),
              shadows: [
                BoxShadow(
                  color: LemonColor.white06,
                  offset: const Offset(-1, -1),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                suffixIcon ?? const SizedBox(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Typo.extraMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.nohemiVariable,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          Text(
                            description,
                            style: Typo.medium.copyWith(
                              fontWeight: FontWeight.w400,
                              color: colorScheme.onPrimary.withOpacity(0.54),
                              fontFamily: FontFamily.switzerVariable,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!featureAvailable)
            Positioned(
              top: 0,
              right: Spacing.smMedium,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: 6.w,
                  left: 6.w,
                  top: 6.w,
                  right: 8.w,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.12),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(LemonRadius.xSmall),
                    topRight: Radius.circular(LemonRadius.xSmall),
                  ),
                ),
                child: Text(
                  t.home.comingSoon,
                  style: Typo.xSmall.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.72),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
