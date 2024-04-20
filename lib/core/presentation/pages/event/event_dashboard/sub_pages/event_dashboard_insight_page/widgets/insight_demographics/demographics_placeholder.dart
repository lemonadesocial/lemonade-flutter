import 'package:app/core/presentation/widgets/shimmer/shimmer.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DemographicsPlaceholder extends StatelessWidget {
  final bool isLast;
  const DemographicsPlaceholder({
    super.key,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : Spacing.extraSmall),
      width: 186.w,
      height: Sizing.medium,
      child: Shimmer.fromColors(
        baseColor: LemonColor.atomicBlack,
        highlightColor: colorScheme.secondaryContainer,
        child: Container(
          color: Colors.black,
        ),
      ),
    );
  }
}
