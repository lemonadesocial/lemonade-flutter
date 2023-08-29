import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPrimaryButton extends StatelessWidget {
  const OnboardingPrimaryButton({
    Key? key,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            LemonColor.button_linear_1,
            LemonColor.button_linear_2,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: LemonColor.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          padding: EdgeInsets.symmetric(vertical: 18.w),
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: theme.colorScheme.onSecondaryContainer,
        ),
        child: Text(
          label,
          style: Typo.medium.copyWith(
            fontFamily: FontFamily.nohemiVariable,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
