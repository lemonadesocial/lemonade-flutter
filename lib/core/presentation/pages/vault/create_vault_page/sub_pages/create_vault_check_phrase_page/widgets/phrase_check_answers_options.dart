import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhraseCheckAnswersOptions extends StatelessWidget {
  const PhraseCheckAnswersOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.filled(4, 0).map((item) {
        return Padding(
          padding: EdgeInsets.only(bottom: Spacing.xSmall),
          child: Container(
            height: 54.w,
            padding: EdgeInsets.all(Spacing.smMedium),
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              borderRadius: BorderRadius.circular(LemonRadius.small),
            ),
            child: Center(
              child: Text(
                "Police",
                style: Typo.medium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
