import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/wheel_time_picker/wheel_time_picker.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectTimeOfDayBottomSheet extends StatefulWidget {
  final DateTime date;
  const SelectTimeOfDayBottomSheet({
    super.key,
    required this.date,
  });

  @override
  State<SelectTimeOfDayBottomSheet> createState() =>
      _SelectTimeBottomSheetState();
}

class _SelectTimeBottomSheetState extends State<SelectTimeOfDayBottomSheet> {
  late TimeOfDay timeOfDay;

  @override
  void initState() {
    super.initState();
    timeOfDay = TimeOfDay.fromDateTime(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    return SafeArea(
      child: Container(
        color: appColors.pageBg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: BottomSheetGrabber(),
            ),
            SizedBox(
              height: 200.w,
              child: WheelTimePicker(
                timeOfDay: TimeOfDay.fromDateTime(widget.date),
                onTimeChanged: (timeOfDay) {
                  setState(() {
                    this.timeOfDay = timeOfDay;
                  });
                },
              ),
            ),
            SizedBox(height: Spacing.medium),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.small),
              child: LinearGradientButton.secondaryButton(
                mode: GradientButtonMode.light,
                onTap: () {
                  Navigator.pop(context, timeOfDay);
                },
                label: t.common.actions.confirm,
                textColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
