import 'package:app/core/application/payment/payment_bloc.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_payment_method_page/widgets/add_card_bottomsheet.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_payment_method_page/widgets/payment_card_item.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentCardsList extends StatelessWidget {
  const PaymentCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PaymentBloc>().getListCard();
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        switch (state.status) {
          case PaymentStatus.loaded:
            return Column(
              children: [
                ListView.separated(
                  itemCount: state.listCard.length,
                  itemBuilder: (context, index) => PaymentCardItem(
                    cardInfo: state.listCard[index],
                    listCard: state.listCard,
                  ),
                  separatorBuilder: (_, __) => SizedBox(height: Spacing.xSmall),
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                  shrinkWrap: true,
                ),
                SizedBox(height: Spacing.xSmall),
                const AddCardButton(),
              ],
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class AddCardButton extends StatelessWidget {
  const AddCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => AddCardBottomSheet().showAsBottomSheet(context),
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
