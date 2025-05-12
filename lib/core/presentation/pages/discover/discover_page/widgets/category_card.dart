import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CategoryCardGradient {
  longevity(
    colors: [
      Color.fromRGBO(43, 58, 58, 0.8), // Bluish background
      Color.fromRGBO(25, 34, 34, 0.8),
      Color.fromRGBO(18, 18, 18, 0.8),
    ],
  ),
  dacc(
    colors: [
      Color.fromRGBO(64, 52, 40, 0.8), // Orange-ish background
      Color.fromRGBO(45, 35, 28, 0.8),
      Color.fromRGBO(18, 18, 18, 0.8),
    ],
  ),
  ai(
    colors: [
      Color.fromRGBO(62, 42, 56, 0.8), // Pink-ish background
      Color.fromRGBO(47, 32, 42, 0.8),
      Color.fromRGBO(18, 18, 18, 0.8),
    ],
  ),
  ethereum(
    colors: [
      Color.fromRGBO(61, 48, 71, 0.8), // Purple background
      Color.fromRGBO(45, 34, 51, 0.8),
      Color.fromRGBO(18, 18, 18, 0.8),
    ],
  ),
  meetup(
    colors: [
      Color.fromRGBO(37, 56, 43, 0.8), // Green background
      Color.fromRGBO(30, 42, 27, 0.8),
      Color.fromRGBO(18, 18, 18, 0.8),
    ],
  ),
  popupVillage(
    colors: [
      Color.fromRGBO(70, 57, 45, 0.8), // Olive green background
      Color.fromRGBO(47, 38, 32, 0.8),
      Color.fromRGBO(18, 18, 18, 0.8),
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
    required this.icon,
    required this.onTap,
    this.padding,
  });

  final List<Color> colors;
  final String title;
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
  });

  final Function() onTap;
  final EdgeInsets? padding;
  final List<Color> colors;
  final Widget icon;
  final String title;

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
            ],
          ),
        ),
      ),
    );
  }
}
