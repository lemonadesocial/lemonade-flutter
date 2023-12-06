import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final DateTime? initialValue;

  const DatePickerTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.initialValue,
  }) : super(key: key);

  @override
  DatePickerTextFieldState createState() => DatePickerTextFieldState();
}

class DatePickerTextFieldState extends State<DatePickerTextField> {
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      String formattedDate =
          DateFormat('E, MMMM d').format(widget.initialValue!);
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
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: widget.initialValue ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(3000),
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
