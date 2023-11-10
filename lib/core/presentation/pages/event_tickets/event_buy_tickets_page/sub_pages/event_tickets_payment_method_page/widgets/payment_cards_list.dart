import 'package:flutter/material.dart';

class PaymentCardsList extends StatelessWidget {
  const PaymentCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: will handle get list cards later
    return const SizedBox.shrink();
    // return BlocBuilder<PaymentBloc, PaymentState>(
    //   builder: (context, state) {
    //     switch (state.status) {
    //       case PaymentStatus.loading:
    //         return Center(
    //           child: Loading.defaultLoading(context),
    //         );
    //       default:
    //         return Column(
    //           children: [
    //             ListView.separated(
    //               itemCount: state.listCard.length,
    //               itemBuilder: (context, index) => PaymentCardItem(
    //                 cardInfo: state.listCard[index],
    //                 listCard: state.listCard,
    //               ),
    //               separatorBuilder: (_, __) => SizedBox(height: Spacing.xSmall),
    //               padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
    //               shrinkWrap: true,
    //             ),
    //             SizedBox(height: Spacing.xSmall),
    //             const AddCardButton(),
    //           ],
    //         );
    //     }
    //   },
    // );
  }
}
