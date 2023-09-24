import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

void showCalendar(
  BuildContext context, {
  DateTime? initialDay,
  required ValueChanged<DateTime> onDateSelect,
}) async {
  final chosenDay0 = await showDatePicker(
    context: context,
    initialDate: initialDay ?? DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2200),
    builder: (context, dialogWidget) => Theme(
      data: Theme.of(context).copyWith(
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              LemonRadius.normal,
            ), // this is the border radius of the picker
          ),
        ),
        dialogBackgroundColor: LemonColor.chineseBlack,
        colorScheme: ColorScheme.dark(
          primary: LemonColor.paleViolet, // header background color
          onPrimary: LemonColor.white, // header text color
          onSurface: LemonColor.white, // body text color
          surface: LemonColor.black33,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: LemonColor.paleViolet, // button text color
          ),
        ),
      ),
      child: dialogWidget!,
    ),
  );
  if (chosenDay0 != null) {
    onDateSelect(chosenDay0);
  }
}
