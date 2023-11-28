import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AIMetaDataCard extends StatelessWidget {
  const AIMetaDataCard({Key? key, this.onTap, required this.item})
      : super(key: key);
  final Function()? onTap;
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final label = item['label'];
    final content = item['content'];
    final icon = item['icon'];
    final featureAvailable = item['featureAvailable'];
    final colors = item['colors'];
    return InkWell(
      onTap: onTap,
      child: GridTile(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                gradient: RadialGradient(
                  radius: 2.5,
                  center: Alignment.bottomRight,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      icon ?? const SizedBox(),
                      SizedBox(width: Spacing.xSmall),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: Typo.medium.copyWith(
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.nohemiVariable,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          Text(
                            content,
                            style: Typo.xSmall.copyWith(
                              fontWeight: FontWeight.w400,
                              color: colorScheme.onPrimary.withOpacity(0.54),
                              fontFamily: FontFamily.switzerVariable,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
            if (!featureAvailable)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary.withOpacity(0.12),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(LemonRadius.xSmall),
                      topRight: Radius.circular(LemonRadius.xSmall),
                    ),
                  ),
                  child: Text(
                    t.home.comingSoon,
                    style: Typo.extraSmall.copyWith(
                      color: colorScheme.onPrimary.withOpacity(0.72),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
