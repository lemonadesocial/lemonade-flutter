import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreatePopUpTile extends StatelessWidget {
  const CreatePopUpTile({
    Key? key,
    this.onTap,
    required this.color,
    required this.label,
    required this.content,
    required this.suffixIcon,
    this.featureAvailable = false,
  }) : super(key: key);

  final VoidCallback? onTap;
  final Color color;
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.normal),
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  color,
                  colorScheme.onPrimary.withOpacity(0.06),
                ],
                stops: const [0,0.4],
              ),
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
                    topRight: Radius.circular(LemonRadius.normal),
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
