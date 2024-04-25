import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDiscoveryBasicInfoSection extends StatelessWidget {
  const UserDiscoveryBasicInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
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
              const Text(
                'Madelyn Franci',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Nohemi',
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 9),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.w),
                decoration: ShapeDecoration(
                  color: const Color(0x2DC69DF7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '@madfranci',
                      style: TextStyle(
                        color: Color(0xFFC69DF7),
                        fontSize: 12,
                        fontFamily: 'Switzer Variable',
                        fontWeight: FontWeight.w400,
                        height: 0,
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
              Container(
                width: 18,
                height: 18,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (colorFilter) => Assets.icons.icBriefcase.svg(
                    colorFilter: colorFilter,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: SizedBox(
                  child: Text(
                    'Systems analyst at Mitsubishi',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5400000214576721),
                      fontSize: 16,
                      fontFamily: 'Switzer Variable',
                      fontWeight: FontWeight.w400,
                      height: 0,
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
