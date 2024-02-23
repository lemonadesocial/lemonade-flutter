import 'package:app/core/presentation/widgets/animation/ripple_animation.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessCircleAnimationWidget extends StatelessWidget {
  const SuccessCircleAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450.w,
      height: 450.w,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) => Transform.scale(
                scale: 1.5,
                child: RippleAnimation(
                  size: constraints.maxWidth,
                  color: const Color.fromRGBO(12, 20, 17, 1),
                  scaleTween: Tween<double>(begin: 0.3, end: 1),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  colors: [
                    Colors.black,
                    Color.fromRGBO(12, 20, 17, 1),
                  ],
                  stops: [
                    0.5,
                    1,
                  ],
                ),
                borderRadius: BorderRadius.circular(240.w),
              ),
              width: 240.w,
              height: 240.w,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Assets.icons.icSuccess.svg(),
          ),
        ],
      ),
    );
  }
}
