import 'package:app/core/presentation/widgets/shapes/shape_triangle.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorUserExpertiseOfferingCard extends StatelessWidget {
  final Color? color;
  const CollaboratorUserExpertiseOfferingCard({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.normal),
        color: color ?? colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.collaborator.expertise,
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.w),
          Text(
            'Product Management, Product Development / Product Strategy',
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          SizedBox(height: Spacing.smMedium),
          const DividerWithTriangle(),
          SizedBox(height: Spacing.smMedium),
          Text(
            t.collaborator.offering,
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.w),
          Text(
            'Advise companies, find customers',
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class DividerWithTriangle extends StatelessWidget {
  const DividerWithTriangle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Divider(
          color: colorScheme.outline,
        ),
        Positioned.fill(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RotatedBox(
                quarterTurns: 3,
                child: ShapeTriangle(
                  size: Size(8.w, 8.w),
                  color: LemonColor.white12Solid,
                ),
              ),
              RotatedBox(
                quarterTurns: 1,
                child: ShapeTriangle(
                  size: Size(8.w, 8.w),
                  color: LemonColor.white12Solid,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
