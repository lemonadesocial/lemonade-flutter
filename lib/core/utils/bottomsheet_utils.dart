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
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      barrierColor: Colors.black.withOpacity(0.5),
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
