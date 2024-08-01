import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubEventCalendarDayCellWidget extends StatelessWidget {
  final DateTime date;
  final TextStyle? textStyle;
  final BoxDecoration? decoration;
  final bool selected;
  final bool hasEvent;

  const SubEventCalendarDayCellWidget({
    super.key,
    required this.date,
    required this.selected,
    required this.hasEvent,
    this.decoration,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: decoration?.copyWith(
        border: Border.all(
          color: selected ? colorScheme.outline : Colors.transparent,
          width: selected ? 1.w : 0,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.day.toString(),
              style: textStyle,
            ),
            SizedBox(
              height: 4.w,
            ),
            hasEvent
                ? Icon(Icons.circle, size: 3.w, color: LemonColor.paleViolet)
                : SizedBox(
                    height: 3.w,
                  ),
          ],
        ),
      ),
    );
  }
}
