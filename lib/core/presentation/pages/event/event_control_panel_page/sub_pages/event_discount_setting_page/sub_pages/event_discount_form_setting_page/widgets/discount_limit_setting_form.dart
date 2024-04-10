import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountLimitSettingForm extends StatelessWidget {
  const DiscountLimitSettingForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.common.settings,
          style: Typo.mediumPlus.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        _Field(
          title: t.event.eventPromotions.ticketLimit,
          description: t.event.eventPromotions.ticketLimitDescription,
          hintText: '100',
          onChange: (value) {
            // final parsedValue = value.isNotEmpty == true ? double.parse(value) : 0;
          },
        ),
        SizedBox(height: Spacing.xSmall),
        _Field(
          title: t.event.eventPromotions.ticketLimit,
          description: t.event.eventPromotions.ticketLimitDescription,
          hintText: '1',
          onChange: (value) {
            // final parsedValue = value.isNotEmpty == true ? double.parse(value) : 0;
          },
        ),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  final String title;
  final String description;
  final String? hintText;

  final Function(String value)? onChange;

  const _Field({
    required this.title,
    required this.description,
    this.hintText,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(LemonRadius.small),
      borderSide: BorderSide(color: colorScheme.outline),
    );
    return Container(
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      padding: EdgeInsets.all(Spacing.small),
      child: SizedBox(
        height: Sizing.medium,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    description,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Sizing.medium * 2,
              height: Sizing.medium,
              child: TextField(
                enableSuggestions: false,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                onChanged: onChange,
                cursorColor: colorScheme.onPrimary,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 2.w),
                  hintText: hintText,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
