import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailFloatingMenuButton extends StatelessWidget {
  final Function()? onTap;
  const EventDetailFloatingMenuButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FloatingActionButton(
      foregroundColor: colorScheme.onSecondary,
      backgroundColor: LemonColor.black33,
      onPressed: () {
        onTap?.call();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(
          color: colorScheme
              .outlineVariant, // Use the secondary color for the border
          width: 2.w, // Adjust the border width as needed
        ),
      ),
      child: const Icon(Icons.menu),
    );
  }
}
