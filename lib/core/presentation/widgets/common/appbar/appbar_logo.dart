import 'package:app/core/utils/modal_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          scale: 2.5,
          image: Assets.icons.icLemonFilledBackground.provider(),
        ),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          showComingSoonDialog(context);
        },
        child: Center(
          child: Assets.icons.icLemonFilledStart.svg(),
        ),
      ),
    );
  }
}
