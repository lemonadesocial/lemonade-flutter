import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
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
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [LemonColor.fabSecondaryBg, LemonColor.fabFirstBg],
          ),
          boxShadow: [
            BoxShadow(
              color: LemonColor.fabShadow,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: ThemeSvgIcon(
          color: LemonColor.white,
          builder: (filter) => Assets.icons.icAdd.svg(
            colorFilter: filter,
            width: 24.w,
            height: 24.w,
          ),
        ),
      ),
    );
  }
}
