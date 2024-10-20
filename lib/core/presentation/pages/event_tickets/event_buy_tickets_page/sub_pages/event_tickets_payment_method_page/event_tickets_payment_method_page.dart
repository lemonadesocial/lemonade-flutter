import 'package:app/core/application/payment/get_payment_cards_bloc/get_payment_cards_bloc.dart';
import 'package:app/core/application/payment/select_payment_card_cubit/select_payment_card_cubit.dart';
import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_payment_method_page/widgets/add_card_bottomsheet.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_payment_method_page/widgets/add_card_button.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_payment_method_page/widgets/payment_card_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

@RoutePage()
class EventTicketsPaymentMethodPage extends StatelessWidget {
  final String publishableKey;
  final Function(PaymentCard paymentCard)? onSelectCard;
  final Function(PaymentCard paymentCard)? onCardAdded;
  final Widget? buyButton;

  const EventTicketsPaymentMethodPage({
    super.key,
    required this.publishableKey,
    this.onSelectCard,
    this.onCardAdded,
    this.buyButton,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: LemonAppBar(
        title: t.event.eventPayment.paymentMethod,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<GetPaymentCardsBloc, GetPaymentCardsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  loading: () => Loading.defaultLoading(context),
                  failure: () => EmptyList(emptyText: t.common.somethingWrong),
                  success: (paymentCards) {
                    final selectedCard =
                        context.watch<SelectPaymentCardCubit>().state.maybeWhen(
                              orElse: () => null,
                              cardSelected: (selectedCard) => selectedCard,
                            );
                    return Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemCount: paymentCards.length + 1,
                              itemBuilder: (context, index) {
                                if (index == paymentCards.length) {
                                  return AddCardButton(
                                    onPressAdd: () async {
                                      final newCard =
                                          await showCupertinoModalBottomSheet(
                                        backgroundColor: LemonColor.atomicBlack,
                                        context: context,
                                        topRadius: Radius.circular(24.r),
                                        barrierColor:
                                            Colors.black.withOpacity(0.5),
                                        builder: (mContext) {
                                          return AddCardBottomSheet(
                                            publishableKey: publishableKey,
                                          );
                                        },
                                      );
                                      if (newCard != null) {
                                        onCardAdded?.call(newCard);
                                      }
                                      AutoRouter.of(context).pop();
                                    },
                                  );
                                }
                                return PaymentCardItem(
                                  selected: selectedCard?.id ==
                                      paymentCards[index].id,
                                  onPressed: () =>
                                      onSelectCard?.call(paymentCards[index]),
                                  paymentCard: paymentCards[index],
                                );
                              },
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: Spacing.xSmall),
                              padding: EdgeInsets.symmetric(
                                horizontal: Spacing.smMedium,
                              ),
                            ),
                          ),
                          if (selectedCard != null)
                            buyButton != null
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Spacing.smMedium,
                                    ),
                                    child: buyButton!,
                                  )
                                : const SizedBox.shrink(),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
