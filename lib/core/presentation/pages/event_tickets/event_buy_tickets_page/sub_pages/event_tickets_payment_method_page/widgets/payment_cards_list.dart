import 'package:app/core/application/payment/payment_bloc/payment_bloc.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_payment_method_page/widgets/add_card_button.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_payment_method_page/widgets/payment_card_item.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCardsList extends StatelessWidget {
  const PaymentCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        switch (state.status) {
          case PaymentStatus.loading:
            return Center(
              child: Loading.defaultLoading(context),
            );
          default:
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
        }
      },
    );
  }
}
