import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloatingCreateButton extends StatelessWidget {
  const FloatingCreateButton({
    super.key,
    this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 54.h,
        height: 54.h,
        padding: EdgeInsets.all(17.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [LemonColor.arsenic, LemonColor.charlestonGreen],
          ),
          boxShadow: const [
            BoxShadow(
              color: LemonColor.fabShadow,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Assets.icons.icFoa.svg(),
      ),
    );
  }
}
