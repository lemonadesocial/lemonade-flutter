import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CategoryCardGradient {
  longevity(
    colors: [
      Color.fromRGBO(35, 62, 62, 0.65), // Bluish background
      Color.fromRGBO(27, 44, 45, 0.65),
      Color.fromRGBO(18, 18, 18, 1),
    ],
  ),
  dacc(
    colors: [
      Color.fromRGBO(66, 50, 36, 0.65), // Orange-ish background
      Color.fromRGBO(48, 36, 26, 0.65),
      Color.fromRGBO(18, 18, 18, 1),
    ],
  ),
  ai(
    colors: [
      Color.fromRGBO(64, 42, 57, 0.65), // Pink-ish background
      Color.fromRGBO(43, 28, 38, 0.65),
      Color.fromRGBO(18, 18, 18, 1),
    ],
  ),
  ethereum(
    colors: [
      Color.fromRGBO(57, 37, 73, 0.65), // Purple background
      Color.fromRGBO(42, 26, 52, 0.65),
      Color.fromRGBO(18, 18, 18, 1),
    ],
  ),
  meetup(
    colors: [
      Color.fromRGBO(26, 51, 34, 0.65), // Green background
      Color.fromRGBO(26, 42, 22, 0.65),
      Color.fromRGBO(18, 18, 18, 1),
    ],
  ),
  popupVillage(
    colors: [
      Color.fromRGBO(76, 56, 37, 0.65), // Olive green background
      Color.fromRGBO(52, 38, 28, 0.65),
      Color.fromRGBO(18, 18, 18, 1),
    ],
  );

  const CategoryCardGradient({required this.colors});
  final List<Color> colors;
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.colors,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.onTap,
    this.padding,
  });

  final List<Color> colors;
  final String title;
  final String subTitle;
  final Widget icon;
  final Function() onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return _VerticalCategoryCard(
      onTap: onTap,
      padding: padding,
      colors: colors,
      icon: icon,
      title: title,
      subTitle: subTitle,
    );
  }
}

class _VerticalCategoryCard extends StatelessWidget {
  const _VerticalCategoryCard({
    required this.onTap,
    required this.padding,
    required this.colors,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  final Function() onTap;
  final EdgeInsets? padding;
  final List<Color> colors;
  final Widget icon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: padding,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              LemonRadius.small,
            ),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [.1, .4, 1],
            colors: colors,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 6.h, bottom: 18.h),
                child: icon,
              ),
              Text(
                title,
                style: Typo.small.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.nohemiVariable,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subTitle,
                style: Typo.xSmall.copyWith(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
