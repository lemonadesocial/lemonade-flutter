import 'package:app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        scale: 2.5,
        image: Assets.icons.icLemonFilledBackground.provider(),
      )),
      child: Center(
        child: Assets.icons.icLemonFilledStart.svg(),
      ),
    );
  }
}
