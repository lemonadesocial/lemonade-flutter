//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';

class ShapeTriangle extends StatelessWidget {
  final Size size;
  final Color? color;
  const ShapeTriangle({
    super.key,
    required this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: _TrianglePainterWidget(
        backgroundColor: color,
      ),
    );
  }
}

class _TrianglePainterWidget extends CustomPainter {
  final Color? backgroundColor;

  _TrianglePainterWidget({
    this.backgroundColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, 0);
    path_0.lineTo(size.width * 0.5000000, size.height);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = backgroundColor ?? Colors.black.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
