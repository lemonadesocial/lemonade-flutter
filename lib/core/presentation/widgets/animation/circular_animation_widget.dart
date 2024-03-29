import 'package:app/core/presentation/widgets/animation/ripple_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularAnimationWidget extends StatelessWidget {
  final Widget icon;
  final Color? rippleColor;
  final Color? gradientColor;

  const CircularAnimationWidget({
    super.key,
    required this.icon,
    this.rippleColor,
    this.gradientColor,
  });

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
                  color: rippleColor ?? const Color.fromRGBO(11, 11, 11, 1),
                  scaleTween: Tween<double>(begin: 0.3, end: 1),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.black,
                    gradientColor ?? const Color.fromRGBO(12, 12, 12, 1),
                  ],
                  stops: const [
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
            child: icon,
          ),
        ],
      ),
    );
  }
}
