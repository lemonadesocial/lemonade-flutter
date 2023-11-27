import 'package:app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({super.key, this.scale});

  final double? scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          scale: scale ?? 1.8,
          image: Assets.images.icLemonFilled.provider(),
        ),
      ),
    );
  }
}
