import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

class AddQuestionRequiredSwitch extends StatelessWidget {
  final bool isRequired;
  final Function(bool) onChanged;
  const AddQuestionRequiredSwitch({
    super.key,
    required this.isRequired,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.medium),
        border: Border.all(
          color: colorScheme.outline,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            t.event.applicationForm.required,
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          FlutterSwitch(
            inactiveColor: colorScheme.outline,
            inactiveToggleColor: colorScheme.onSurfaceVariant,
            activeColor: LemonColor.paleViolet,
            activeToggleColor: colorScheme.onPrimary,
            height: 24.w,
            width: 42.w,
            value: isRequired,
            onToggle: (value) {
              onChanged(value);
            },
          ),
        ],
      ),
    );
  }
}
