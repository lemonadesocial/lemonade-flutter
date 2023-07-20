import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

class BottomSheetUtils {
  static showSnapBottomSheet(
    BuildContext context, {
    Widget? child,
    List<double>? snapSizes,
    double? maxSnapSize,
    double? minSnapSize,
    double? defaultSnapSize,
    DraggableScrollableController? controller,
  }) {
    return showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return LemonSnapBottomSheet(
          child: child,
          snapSizes: snapSizes,
          minSnapSize: minSnapSize,
          maxSnapSize: maxSnapSize,
          controller: controller,
        );
      },
    );
  }
}
