import 'dart:math';

import 'package:app/core/domain/badge/entities/badge_entities.dart'
    as badge_entities;
import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/domain/poap/poap_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final _badgeQuantityBarSize = Size(94.w, 94.w);

class HotBadgeQuantityBar extends StatelessWidget {
  const HotBadgeQuantityBar({
    super.key,
    required this.badge,
  });

  final badge_entities.Badge badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.flip(
          flipY: true,
          child: CustomPaint(
            painter: _BadgeQuantityBarPainter(),
            size: _badgeQuantityBarSize,
          ),
        ),
        Transform.flip(
          flipY: true,
          child: FutureBuilder(
            future: getIt<PoapRepository>().getPoapViewSupply(
              input: GetPoapViewSupplyInput(
                network: badge.network ?? '',
                address: badge.contract?.toLowerCase() ?? '',
              ),
            ),
            builder: (context, snapshot) {
              final poapViewSupply =
                  snapshot.data?.fold((l) => null, (poapView) => poapView);
              var claimProgress = .0;
              final claimedQuantity = poapViewSupply?.claimedQuantity ?? 0;
              final quantity = poapViewSupply?.quantity ?? 0;
              if (quantity != 0) {
                claimProgress = claimedQuantity / quantity;
              }
              return TweenAnimationBuilder(
                duration: const Duration(milliseconds: 500),
                tween: Tween<double>(begin: 0, end: claimProgress),
                builder: (context, animationValue, _) => CustomPaint(
                  painter: _BadgeQuantityBarPainter(
                    isGradient: true,
                    progress: animationValue,
                  ),
                  size: _badgeQuantityBarSize,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _BadgeQuantityBarPainter extends CustomPainter {
  _BadgeQuantityBarPainter({
    this.isGradient = false,
    this.progress = 1,
  }) : super();
  final bool isGradient;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.w;

    if (isGradient) {
      paint.shader = SweepGradient(
        center: Alignment.centerRight,
        endAngle: 1,
        colors: [
          LemonColor.white,
          LemonColor.paleViolet,
        ],
      ).createShader(rect);
    } else {
      paint.color = LemonColor.paleViolet36;
    }

    const startAngle = 0.6 + pi;
    final sweepAngle = (pi - 1.2) * progress;
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
