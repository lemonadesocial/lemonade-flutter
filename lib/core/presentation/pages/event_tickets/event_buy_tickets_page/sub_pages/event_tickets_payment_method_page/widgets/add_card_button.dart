import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCardButton extends StatelessWidget {
  const AddCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () async {
        // TODO: will handle add new card later
        // final newCard = await AddCardBottomSheet(
        //   publishableKey: paymentBloc.state.publishableKey,
        // ).showAsBottomSheet(context) as PaymentCard?;
        // if (newCard != null) {
        //   context.read<PaymentBloc>().newCardAdded(newCard);
        // }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        child: DottedBorder(
          dashPattern: [5.w],
          color: colorScheme.outline,
          borderType: BorderType.RRect,
          padding: EdgeInsets.all(Spacing.smMedium),
          radius: Radius.circular(LemonRadius.xSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icons.icCreditCard.svg(),
              SizedBox(width: Spacing.extraSmall),
              Text(
                t.event.eventPayment.addNewCard,
                style: Typo.medium.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
