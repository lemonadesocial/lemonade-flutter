import 'dart:ui';

import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class LemonSnapBottomSheet extends StatelessWidget {
  final Widget? child;
  final List<double>? snapSizes;
  final double? maxSnapSize;
  final double? minSnapSize;
  final double? defaultSnapSize;
  final DraggableScrollableController? controller;

  const LemonSnapBottomSheet({
    super.key,
    this.child,
    this.snapSizes,
    this.maxSnapSize,
    this.minSnapSize,
    this.defaultSnapSize,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: DraggableScrollableSheet(
          initialChildSize: defaultSnapSize ?? 0.5,
          minChildSize: minSnapSize ?? 0.25,
          maxChildSize: maxSnapSize ?? 1.0,
          snap: true,
          snapSizes: snapSizes,
          controller: controller,
          builder: (BuildContext context, ScrollController scrollController) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: ClipRRect(
                child: Container(
                  decoration: ShapeDecoration(
                      color: colorScheme.secondary.withOpacity(0.99),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(LemonRadius.small),
                          topLeft: Radius.circular(LemonRadius.small),
                        ),
                      )),
                  child: Column(
                    children: [
                      _buildIndicator(),
                      if (child != null) child!,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildIndicator() {
    return Container(
      width: Sizing.large,
      height: 3,
      margin: EdgeInsets.symmetric(vertical: Spacing.extraSmall),
      decoration: BoxDecoration(
        color: LemonColor.white36,
        borderRadius: BorderRadius.circular(2.5),
      ),
    );
  }
}
