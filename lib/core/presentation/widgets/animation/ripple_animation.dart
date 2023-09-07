import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math show sin, pi, sqrt;

class RippleAnimation extends StatefulWidget {
  const RippleAnimation({
    super.key,
    this.size = 40.0,
    this.color = LemonColor.rippleMarkerColor,
    this.scaleTween,
    this.numOfCircle = 2,
  });
  final double size;
  final Color color;
  final Tween<double>? scaleTween;
  final int? numOfCircle;

  @override
  RippleMarkerState createState() => RippleMarkerState();
}

class RippleMarkerState extends State<RippleAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CirclePainter(
        _controller,
        numOfWave: widget.numOfCircle,
        color: widget.color,
      ),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.size),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: <Color>[
                    widget.color,
                    Colors.black,
                  ],
                ),
              ),
              child: ScaleTransition(
                scale:
                    (widget.scaleTween ?? Tween(begin: 0.5, end: 1.0)).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: CurveWave(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  _CirclePainter(
    this._animation, {
    this.numOfWave = 2,
    required this.color,
  }) : super(repaint: _animation);

  final Color color;
  final Animation<double> _animation;
  final int? numOfWave;

  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color mColor = color.withOpacity(opacity);
    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = math.sqrt(area * value / 4);
    final Paint paint = Paint()..color = mColor;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = numOfWave!; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) => true;
}

class CurveWave extends Curve {
  @override
  double transform(double t) {
    if (t == 0 || t == 1) {
      return 0.01;
    }
    return math.sin(t * math.pi);
  }
}
