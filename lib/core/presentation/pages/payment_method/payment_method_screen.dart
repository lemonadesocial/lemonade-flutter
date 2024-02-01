import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: const LemonAppBar(
        leading: LemonBackButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.payment.payUsing,
            style: Typo.extraLarge.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: Spacing.superExtraSmall),
          Text(
            t.payment.payUsingDesc,
            style: Typo.mediumPlus.copyWith(
              color: colorScheme.onPrimary.withOpacity(0.54),
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: Spacing.medium),
        ],
      ),
    );
  }
}
