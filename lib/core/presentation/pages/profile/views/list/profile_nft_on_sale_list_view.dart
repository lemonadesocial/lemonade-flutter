import 'package:app/core/application/common/scroll_notification_bloc/scroll_notification_bloc.dart';
import 'package:app/core/application/token/orders_listing_subscription_bloc/orders_listing_subscription_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/token/input/watch_orders_input.dart';
import 'package:app/core/domain/token/token_enums.dart';
import 'package:app/core/domain/token/token_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/profile/widgets/profile_nft_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/token/token_service.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileNftOnSaleListView extends StatelessWidget {

  ProfileNftOnSaleListView({
    super.key,
    required this.user,
  });
  final User user;
  late final ordersListingBloc = OrdersListingSubscriptionBloc(
    TokenService(
      getIt<TokenRepository>(),
    ),
    defaultInput: WatchOrdersInput(
      where: OrderWhereComplex(makerIn: user.wallets, openEq: true),
      sort: const OrderSort(
        by: OrderSortBy.createdAt,
        direction: SortDirection.DESC,
      ),
    ),
  )..add(const OrdersListingSubscriptionEvent.start());

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ordersListingBloc,
      child: BlocListener<ScrollNotificationBloc, ScrollNotificationState>(
        listener: (context, scrollState) {
          scrollState.maybeWhen(
            endReached: () {
              ordersListingBloc.add(const OrdersListingSubscriptionEvent.start());
            },
            orElse: () {},
          );
        },
        child: const _ProfileNftOnSaleList(),
      ),
    );
  }
}

class _ProfileNftOnSaleList extends StatefulWidget {
  const _ProfileNftOnSaleList();

  @override
  State<_ProfileNftOnSaleList> createState() => _ProfileNftCreatedListViewState();
}

class _ProfileNftCreatedListViewState extends State<_ProfileNftOnSaleList> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
      sliver: BlocBuilder<OrdersListingSubscriptionBloc, OrdersListingSubscriptionState>(
        builder: (context, tokenListingState) {
          return tokenListingState.when(
              loading: () => SliverFillRemaining(child: Center(child: Loading.defaultLoading(context))),
              failure: () => SliverToBoxAdapter(child: Center(child: Text(t.common.somethingWrong))),
              fetched: (orders) {
                if (orders.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyList(emptyText: t.nft.noCollectible),
                  );
                }
                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: Spacing.superExtraSmall,
                    mainAxisSpacing: Spacing.superExtraSmall,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final order = orders[index];
                      return ProfileNftItem(nftToken: dartz.Right(order.token));
                    },
                    childCount: orders.length,
                  ),
                );
              },);
        },
      ),
    );
  }
}
