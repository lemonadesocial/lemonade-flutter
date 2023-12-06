import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final DateTime? initialValue;

  const TimePickerTextField({
    super.key,
    required this.controller,
    required this.label,
    this.initialValue,
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
          int hour = pickedTime.hour;
          int minute = pickedTime.minute;
          DateTime parsedTime = DateTime(2023, 1, 1, hour, minute);
          String formattedTime = DateFormat('HH:mm').format(parsedTime);
          setState(() {
            widget.controller.text = formattedTime;
          });
        }
      },
    );
  }
}
