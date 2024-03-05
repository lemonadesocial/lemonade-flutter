import 'dart:math';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventInviteLoadingView extends StatelessWidget {
  const EventInviteLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          const _CircularLoading(),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    t.event.inviteEvent.inviteLoadingTitle,
                    style: Typo.extraLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    t.event.inviteEvent.inviteLoadingDescription,
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircularLoading extends StatefulWidget {
  const _CircularLoading();

  @override
  State<_CircularLoading> createState() => _CircularLoadingState();
}

class _CircularLoadingState extends State<_CircularLoading>
    with TickerProviderStateMixin {
  late AnimationController _animationContrl;
  late Animation<double> _animation;

  @override
  void dispose() {
    _animationContrl.dispose();
    super.dispose();
  }

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
