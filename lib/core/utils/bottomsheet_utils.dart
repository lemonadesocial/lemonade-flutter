import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetUtils {
  static showSnapBottomSheet(
    BuildContext context, {
    required Widget Function(BuildContext) builder,
    Widget? child,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: builder,
    );
  }

  static showSnapBottomSheetWithRadius(
    BuildContext context, {
    Widget? child,
    Color? color,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      builder: (context) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(18),
          ),
          color: color ?? Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        clipBehavior: Clip.hardEdge,
        child: FractionallySizedBox(
          heightFactor: 0.95,
          child: Column(
            children: [
              Container(
                height: 10.h,
                color:
                    color ?? Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              Container(
                width: 48.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Expanded(
                child: child ?? const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
