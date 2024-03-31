import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wheel_picker/wheel_picker.dart';

class WheelTimePicker extends StatefulWidget {
  const WheelTimePicker(
      {super.key, this.timeOfDay, required this.onTimeChanged});

  final TimeOfDay? timeOfDay;
  final Function(TimeOfDay) onTimeChanged;

  @override
  State<WheelTimePicker> createState() => _WheelTimePickerState();
}

class _WheelTimePickerState extends State<WheelTimePicker> {
  final now = TimeOfDay.now();
  late final hoursWheel = WheelPickerController(
    itemCount: 12,
    initialIndex:
        widget.timeOfDay != null ? widget.timeOfDay!.hour % 12 : now.hour % 12,
  );
  late final minutesWheel = WheelPickerController(
    itemCount: 60,
    initialIndex:
        widget.timeOfDay != null ? widget.timeOfDay!.minute : now.minute,
    mounts: [hoursWheel],
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const textStyle =
        TextStyle(fontSize: 16.0, height: 2.5, color: Colors.white);
    final wheelStyle = WheelPickerStyle(
      size: 400,
      itemExtent: textStyle.fontSize! * textStyle.height!,
      squeeze: 1.25,
      diameterRatio: 1,
      surroundingOpacity: .25,
      magnification: 1.2,
    );

    Widget itemBuilder(BuildContext context, int index) {
      return Text("$index".padLeft(2, '0'), style: textStyle);
    }

    void onHourChanged(int newHour) {
      final newTime = TimeOfDay(
        hour: (newHour + widget.timeOfDay!.periodOffset),
        minute: widget.timeOfDay!.minute,
      );
      widget.onTimeChanged(newTime);
    }

    void onMinutesChanged(int newMinutes) {
      final newTime = TimeOfDay(
        hour: widget.timeOfDay!.hour,
        minute: newMinutes,
      );
      widget.onTimeChanged(newTime);
    }

    void onPeriodChanged(int index) {
      final newHour = index == 0
          ? widget.timeOfDay!.hour > 12
              ? widget.timeOfDay!.hour - 12
              : widget.timeOfDay!.hour
          : widget.timeOfDay!.hour < 12
              ? widget.timeOfDay!.hour + 12
              : widget.timeOfDay!.hour;

      final newTime =
          TimeOfDay(hour: newHour, minute: widget.timeOfDay!.minute);
      widget.onTimeChanged(newTime);
    }

    return SizedBox(
      width: 200.0,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _centerBar(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WheelPicker(
                builder: itemBuilder,
                controller: hoursWheel,
                looping: true,
                enableTap: false,
                style: wheelStyle,
                selectedIndexColor: colorScheme.onPrimary,
                onIndexChanged: (index) {
                  onHourChanged(index);
                },
              ),
              SizedBox(
                width: Spacing.small,
              ),
              WheelPicker(
                builder: itemBuilder,
                controller: minutesWheel,
                style: wheelStyle,
                enableTap: false,
                selectedIndexColor: colorScheme.onPrimary,
                onIndexChanged: (index) {
                  onMinutesChanged(index);
                },
              ),
              SizedBox(
                width: Spacing.small,
              ),
              WheelPicker(
                itemCount: 2,
                builder: (context, index) {
                  return Text(["AM", "PM"][index], style: textStyle);
                },
                initialIndex: widget.timeOfDay != null
                    ? (widget.timeOfDay!.period == DayPeriod.am)
                        ? 0
                        : 1
                    : (now.period == DayPeriod.am)
                        ? 0
                        : 1,
                looping: false,
                enableTap: false,
                style: wheelStyle.copyWith(
                  shiftAnimationStyle: const WheelShiftAnimationStyle(
                    duration: Duration(seconds: 1),
                    curve: Curves.bounceOut,
                  ),
                ),
                onIndexChanged: (index) {
                  onPeriodChanged(index);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    hoursWheel.dispose();
    minutesWheel.dispose();
    super.dispose();
  }

  Widget _centerBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Container(
        height: 32.h,
        margin: EdgeInsets.symmetric(horizontal: Spacing.xLarge),
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
