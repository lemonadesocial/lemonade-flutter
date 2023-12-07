import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final DateTime? initialValue;
  final ValueChanged<DateTime>? onChanged;

  const TimePickerTextField({
    super.key,
    required this.controller,
    required this.label,
    this.initialValue,
    this.onChanged,
  });

  @override
  TimePickerTextFieldState createState() => TimePickerTextFieldState();
}

class TimePickerTextFieldState extends State<TimePickerTextField> {
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      String formattedDate = DateFormat('HH:mm').format(widget.initialValue!);
      widget.controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LemonTextField(
      label: widget.label,
      controller: widget.controller,
      readOnly: true,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          initialTime:
              TimeOfDay.fromDateTime(widget.initialValue ?? DateTime.now()),
          context: context,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: colorScheme.copyWith(
                  primary: Colors.white,
                ),
              ),
              child: child!,
            );
          },
        );
        if (pickedTime != null) {
          int year = widget.initialValue?.year ?? DateTime.now().year;
          int month = widget.initialValue?.month ?? DateTime.now().month;
          int day = widget.initialValue?.day ?? DateTime.now().day;
          int hour = pickedTime.hour;
          int minute = pickedTime.minute;
          DateTime parsedTime = DateTime(year, month, day, hour, minute);
          String formattedTime = DateFormat('HH:mm').format(parsedTime);
          setState(() {
            widget.controller.text = formattedTime;
            if (widget.onChanged != null) {
              widget.onChanged!(parsedTime);
            }
          });
        }
      },
    );
  }
}
