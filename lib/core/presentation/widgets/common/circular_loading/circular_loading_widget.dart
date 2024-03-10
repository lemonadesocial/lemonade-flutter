import 'dart:math';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularLoading extends StatefulWidget {
  const CircularLoading({super.key});

  @override
  State<CircularLoading> createState() => CircularLoadingState();
}

class CircularLoadingState extends State<CircularLoading>
    with TickerProviderStateMixin {
  late AnimationController _animationContrl;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationContrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation =
        CurvedAnimation(parent: _animationContrl, curve: Curves.linear);
    _animationContrl.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 240.w,
      height: 240.w,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: 240.w,
              height: 240.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(240.w),
                border: Border.all(
                  color: colorScheme.secondaryContainer,
                  width: 4.w,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: RotationTransition(
              turns: _animation,
              child: CustomPaint(
                size: Size(235.w, 235.w),
                painter: const _ArcPainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  const _ArcPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = Sizing.small
      ..color = LemonColor.paleViolet;

    const startAngle = pi;
    const sweepAngle = (pi / 4);
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
