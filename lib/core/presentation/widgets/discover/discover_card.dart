import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum DiscoverCardGradient {
  events(
    colors: [
      Color.fromRGBO(50, 43, 63, 1),
      Color.fromRGBO(37, 32, 45, 1),
      Color.fromRGBO(18, 18, 18, 1),
    ],
  ),
  collaborators(
    colors: [
      Color.fromRGBO(52, 69, 72, 1),
      Color.fromRGBO(40, 52, 53, 1),
      Color.fromRGBO(18, 18, 18, 1),
    ],
  ),
  badges(
    colors: [
      Color.fromRGBO(69, 58, 48, 1),
      Color.fromRGBO(51, 43, 37, 1),
      Color.fromRGBO(18, 18, 18, 1),
    ],
  ),
  music(
    colors: [
      Color.fromRGBO(66, 66, 57, 1),
      Color.fromRGBO(45, 44, 39, 1),
      Color.fromRGBO(18, 18, 18, 1),
    ],
  );

  const DiscoverCardGradient({required this.colors});
  final List<Color> colors;
}

class DiscoverCard extends StatelessWidget {
  const DiscoverCard({
    super.key,
    required this.colors,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.onTap,
  });
  final List<Color> colors;
  final String title;
  final String subTitle;
  final Widget icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Spacing.xSmall),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              LemonRadius.small,
            ),
          ),
          gradient: RadialGradient(
            radius: 1.2,
            center: Alignment.bottomCenter,
            stops: const [.1, .4, 1],
            colors: colors,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(height: Spacing.smMedium),
            Text(
              title,
              style: Typo.small.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
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
    );
  }
}
