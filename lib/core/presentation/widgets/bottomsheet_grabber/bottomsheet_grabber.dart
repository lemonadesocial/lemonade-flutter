import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetGrabber extends StatelessWidget {
  const BottomSheetGrabber({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Spacing.superExtraSmall),
      width: Sizing.large,
      height: 3.w,
      decoration: ShapeDecoration(
        color: LemonColor.white12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.r),
        ),
      ),
    );
  }
}
