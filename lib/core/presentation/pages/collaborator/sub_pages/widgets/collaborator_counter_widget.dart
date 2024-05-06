import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class CollaboratorCounter extends StatelessWidget {
  final int count;
  const CollaboratorCounter({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Spacing.superExtraSmall / 2,
        horizontal: Spacing.superExtraSmall,
      ),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
      ),
      child: Center(
        child: Text(
          count.toString(),
          style: Typo.xSmall.copyWith(
            color: colorScheme.onSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
