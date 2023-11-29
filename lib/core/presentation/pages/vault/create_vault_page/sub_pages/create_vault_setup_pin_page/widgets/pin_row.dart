import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class PinRow extends StatelessWidget {
  final String pinCode;

  const PinRow({
    super.key,
    required this.pinCode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.filled(6, 0)
          .asMap()
          .map((index, value) {
            String? displayValue;
            if (index >= pinCode.length) {
              displayValue = null;
            } else {
              displayValue = pinCode[index];
            }

            return MapEntry(
              index,
              _PinItem(
                value: displayValue,
                active: index == pinCode.length,
              ),
            );
          })
          .values
          .toList(),
    );
  }
}

class _PinItem extends StatelessWidget {
  final String? value;
  final bool? active;

  const _PinItem({
    this.value,
    this.active,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: Sizing.large,
      height: Sizing.xLarge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.small),
        border: Border.all(
          color: active == true ? LemonColor.paleViolet : colorScheme.outline,
        ),
      ),
      child: Center(
        child: Text(
          value ?? '',
          style: Typo.extraLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
