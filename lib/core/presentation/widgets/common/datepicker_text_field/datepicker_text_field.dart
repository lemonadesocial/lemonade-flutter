import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const DatePickerTextField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  DatePickerTextFieldState createState() => DatePickerTextFieldState();
}

class DatePickerTextFieldState extends State<DatePickerTextField> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LemonTextField(
      label: widget.label,
      controller: widget.controller,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: colorScheme.copyWith(
                  primary: Colors.white54,
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('E, MMMM d').format(pickedDate);
          setState(() {
            widget.controller.text = formattedDate;
          });
        } else {}
      },
    );
  }
}
