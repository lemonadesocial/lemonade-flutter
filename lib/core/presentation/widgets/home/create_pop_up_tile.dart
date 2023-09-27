import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CreatePopupGradient {
  post(
    colors: [
      Color.fromRGBO(49, 60, 75, 1),
      Color.fromRGBO(29, 29, 29, 1),
    ],
  ),
  room(
    colors: [
      Color.fromRGBO(78, 65, 53, 1),
      Color.fromRGBO(29, 29, 29, 1),
    ],
  ),
  event(
    colors: [
      Color.fromRGBO(64, 52, 81, 1),
      Color.fromRGBO(29, 29, 29, 1),
    ],
  ),
  poap(
    colors: [
      Color.fromRGBO(49, 78, 73, 1),
      Color.fromRGBO(29, 29, 29, 1),
    ],
  ),
  collectible(
    colors: [
      Color.fromRGBO(82, 53, 64, 1),
      Color.fromRGBO(29, 29, 29, 1),
    ],
  );

  const CreatePopupGradient({required this.colors});
  final List<Color> colors;
}

class CreatePopUpTile extends StatelessWidget {
  const CreatePopUpTile({
    Key? key,
    this.onTap,
    required this.colors,
    required this.label,
    required this.content,
    required this.suffixIcon,
    this.featureAvailable = false,
  }) : super(key: key);

  final VoidCallback? onTap;
  final List<Color> colors;
  final String label;
  final String content;
  final Widget suffixIcon;
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
            padding: EdgeInsets.all(Spacing.medium),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  LemonRadius.small,
                ),
              ),
              gradient: RadialGradient(
                radius: 2.5,
                center: Alignment.topRight,
                colors: colors,
              ),
              shadows: [
                BoxShadow(
                  color: LemonColor.white06,
                  offset: const Offset(-1, -1),
                  spreadRadius: 1,
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: Typo.extraMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        content,
                        style: Typo.medium.copyWith(
                          fontWeight: FontWeight.w400,
                          color: colorScheme.onPrimary.withOpacity(0.36),
                          fontFamily: FontFamily.switzerVariable,
                        ),
                      ),
                    ],
                  ),
                ),
                suffixIcon,
              ],
            ),
          ),
          if (!featureAvailable)
            Positioned(
              top: 0,
              right: 0,
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
