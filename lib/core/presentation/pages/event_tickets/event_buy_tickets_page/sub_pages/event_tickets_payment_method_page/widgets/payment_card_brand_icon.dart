import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentCardBrandIcon extends StatelessWidget {
  final PaymentCardBrand cardBrand;
  const PaymentCardBrandIcon({
    super.key,
    required this.cardBrand,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (cardBrand == PaymentCardBrand.visa) {
      return Assets.icons.icVisa.image(
        width: Sizing.small,
        height: 7.w,
      );
    }

    if (cardBrand == PaymentCardBrand.mastercard) {
      return Assets.icons.icMasterCard.svg();
    }

    return Text(
      cardBrand.name.toUpperCase(),
      style: Typo.small.copyWith(
        color: colorScheme.primary,
      ),
    );
  }
}
