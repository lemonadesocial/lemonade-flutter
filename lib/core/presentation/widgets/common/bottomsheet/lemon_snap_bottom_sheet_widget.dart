import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class LemonSnapBottomSheet extends StatelessWidget {
  final Widget Function(ScrollController scrollController) builder;
  final Widget Function()? footerBuilder;
  final List<double>? snapSizes;
  final double? maxSnapSize;
  final double? minSnapSize;
  final double? defaultSnapSize;
  final DraggableScrollableController? controller;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final Decoration? decoration;

  const LemonSnapBottomSheet({
    super.key,
    required this.builder,
    this.footerBuilder,
    this.snapSizes,
    this.maxSnapSize,
    this.minSnapSize,
    this.defaultSnapSize,
    this.controller,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        bottom: resizeToAvoidBottomInset == true
            ? MediaQuery.of(context).viewInsets.bottom
            : 0,
      ),
      child: DraggableScrollableSheet(
        snapAnimationDuration: const Duration(milliseconds: 300),
        initialChildSize: defaultSnapSize ?? 0.5,
        minChildSize: minSnapSize ?? 0.25,
        maxChildSize: maxSnapSize ?? 1.0,
        snap: true,
        snapSizes: snapSizes,
        controller: controller,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: decoration ??
                ShapeDecoration(
                  color: backgroundColor ?? colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(LemonRadius.small),
                      topLeft: Radius.circular(LemonRadius.small),
                    ),
                  ),
                ),
            child: Column(
              children: [
                _buildIndicator(),
                builder(scrollController),
                if (footerBuilder != null) ...[
                  const Spacer(),
                  footerBuilder!.call(),
                ],
              ],
            ),
          );
        },
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
