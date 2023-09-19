import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class TicketWaveCustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.2811318);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width, size.height * 0.2811318);
    path_0.cubicTo(
      size.width,
      size.height * 0.1297809,
      size.width * 0.9943510,
      size.height * 0.04468791,
      size.width * 0.9904749,
      size.height * 0.1376818,
    );
    path_0.lineTo(size.width * 0.9654189, size.height * 0.7390055);
    path_0.cubicTo(
      size.width * 0.9590265,
      size.height * 0.8924782,
      size.width * 0.9500649,
      size.height * 0.8924782,
      size.width * 0.9436696,
      size.height * 0.7390064,
    );
    path_0.lineTo(size.width * 0.9199646, size.height * 0.1700845);
    path_0.cubicTo(
      size.width * 0.9135723,
      size.height * 0.01661309,
      size.width * 0.9046106,
      size.height * 0.01661300,
      size.width * 0.8982153,
      size.height * 0.1700845,
    );
    path_0.lineTo(size.width * 0.8745103, size.height * 0.7390064);
    path_0.cubicTo(
      size.width * 0.8681150,
      size.height * 0.8924782,
      size.width * 0.8591563,
      size.height * 0.8924782,
      size.width * 0.8527611,
      size.height * 0.7390064,
    );
    path_0.lineTo(size.width * 0.8290560, size.height * 0.1700855);
    path_0.cubicTo(
      size.width * 0.8226608,
      size.height * 0.01661327,
      size.width * 0.8137021,
      size.height * 0.01661300,
      size.width * 0.8073068,
      size.height * 0.1700845,
    );
    path_0.lineTo(size.width * 0.7836018, size.height * 0.7390055);
    path_0.cubicTo(
      size.width * 0.7772065,
      size.height * 0.8924782,
      size.width * 0.7682478,
      size.height * 0.8924782,
      size.width * 0.7618525,
      size.height * 0.7390064,
    );
    path_0.lineTo(size.width * 0.7381475, size.height * 0.1700855);
    path_0.cubicTo(
      size.width * 0.7317522,
      size.height * 0.01661327,
      size.width * 0.7227935,
      size.height * 0.01661300,
      size.width * 0.7163982,
      size.height * 0.1700845,
    );
    path_0.lineTo(size.width * 0.6926932, size.height * 0.7390055);
    path_0.cubicTo(
      size.width * 0.6862979,
      size.height * 0.8924782,
      size.width * 0.6773392,
      size.height * 0.8924782,
      size.width * 0.6709440,
      size.height * 0.7390064,
    );
    path_0.lineTo(size.width * 0.6472389, size.height * 0.1700855);
    path_0.cubicTo(
      size.width * 0.6408437,
      size.height * 0.01661327,
      size.width * 0.6318850,
      size.height * 0.01661300,
      size.width * 0.6254897,
      size.height * 0.1700845,
    );
    path_0.lineTo(size.width * 0.6017847, size.height * 0.7390055);
    path_0.cubicTo(
      size.width * 0.5953894,
      size.height * 0.8924782,
      size.width * 0.5864277,
      size.height * 0.8924782,
      size.width * 0.5800354,
      size.height * 0.7390064,
    );
    path_0.lineTo(size.width * 0.5563304, size.height * 0.1700855);
    path_0.cubicTo(
      size.width * 0.5499351,
      size.height * 0.01661327,
      size.width * 0.5409735,
      size.height * 0.01661300,
      size.width * 0.5345811,
      size.height * 0.1700845,
    );
    path_0.lineTo(size.width * 0.5108761, size.height * 0.7390055);
    path_0.cubicTo(
      size.width * 0.5044808,
      size.height * 0.8924782,
      size.width * 0.4955192,
      size.height * 0.8924782,
      size.width * 0.4891239,
      size.height * 0.7390064,
    );
    path_0.lineTo(size.width * 0.4654189, size.height * 0.1700855);
    path_0.cubicTo(
      size.width * 0.4590265,
      size.height * 0.01661318,
      size.width * 0.4500649,
      size.height * 0.01661300,
      size.width * 0.4436696,
      size.height * 0.1700845,
    );
    path_0.lineTo(size.width * 0.4199646, size.height * 0.7390064);
    path_0.cubicTo(
      size.width * 0.4135723,
      size.height * 0.8924782,
      size.width * 0.4046106,
      size.height * 0.8924782,
      size.width * 0.3982153,
      size.height * 0.7390064,
    );
    path_0.lineTo(size.width * 0.3745103, size.height * 0.1700855);
    path_0.cubicTo(
      size.width * 0.3681150,
      size.height * 0.01661327,
      size.width * 0.3591563,
      size.height * 0.01661300,
      size.width * 0.3527611,
      size.height * 0.1700845,
    );
    path_0.lineTo(size.width * 0.3290560, size.height * 0.7390055);
    path_0.cubicTo(
      size.width * 0.3226608,
      size.height * 0.8924782,
      size.width * 0.3137021,
      size.height * 0.8924782,
      size.width * 0.3073068,
      size.height * 0.7390064,
    );
    path_0.lineTo(size.width * 0.2836021, size.height * 0.1700855);
    path_0.cubicTo(
      size.width * 0.2772074,
      size.height * 0.01661327,
      size.width * 0.2682472,
      size.height * 0.01661300,
      size.width * 0.2618525,
      size.height * 0.1700845,
    );
    path_0.lineTo(size.width * 0.2381475, size.height * 0.7390055);
    path_0.cubicTo(
      size.width * 0.2317528,
      size.height * 0.8924782,
      size.width * 0.2227926,
      size.height * 0.8924782,
      size.width * 0.2163979,
      size.height * 0.7390064,
    );
    path_0.lineTo(size.width * 0.1926929, size.height * 0.1700855);
    path_0.cubicTo(
      size.width * 0.1862982,
      size.height * 0.01661318,
      size.width * 0.1773381,
      size.height * 0.01661300,
      size.width * 0.1709434,
      size.height * 0.1700845,
    );
    path_0.lineTo(size.width * 0.1472383, size.height * 0.7390055);
    path_0.cubicTo(
      size.width * 0.1408437,
      size.height * 0.8924782,
      size.width * 0.1318835,
      size.height * 0.8924782,
      size.width * 0.1254888,
      size.height * 0.7390064,
    );
    path_0.lineTo(size.width * 0.1017838, size.height * 0.1700855);
    path_0.cubicTo(
      size.width * 0.09538909,
      size.height * 0.01661318,
      size.width * 0.08642891,
      size.height * 0.01661300,
      size.width * 0.08003422,
      size.height * 0.1700845,
    );
    path_0.lineTo(size.width * 0.05632920, size.height * 0.7390055);
    path_0.cubicTo(
      size.width * 0.04993451,
      size.height * 0.8924782,
      size.width * 0.04097434,
      size.height * 0.8924782,
      size.width * 0.03457965,
      size.height * 0.7390064,
    );
    path_0.lineTo(size.width * 0.009524631, size.height * 0.1376818);
    path_0.cubicTo(
      size.width * 0.005649882,
      size.height * 0.04468809,
      0,
      size.height * 0.1297809,
      0,
      size.height * 0.2811318,
    );
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.white.withOpacity(0.06);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
