import 'package:app/theme/sizing.dart';
import 'package:flutter/material.dart';

class CircleDot extends StatelessWidget {
  const CircleDot({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: Sizing.medium / 2,
      height: Sizing.medium / 2,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizing.medium / 2),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 6.5,
            top: 6.5,
            child: Container(
              width: 6,
              height: 6,
              decoration: ShapeDecoration(
                color: color,
                shape: const CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
