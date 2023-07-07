import 'package:app/core/application/token/orders_listing_subscription_bloc/orders_listing_subscription_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/token/input/watch_orders_input.dart';
import 'package:app/core/domain/token/token_enums.dart';
import 'package:app/core/domain/token/token_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/profile/widgets/profile_nft_item.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/token/token_service.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart' as dartz;

class ProfileNftSoldListView extends StatelessWidget {
  final User user;
  const ProfileNftSoldListView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersListingSubscriptionBloc(
        TokenService(
          getIt<TokenRepository>(),
        ),
      )..add(OrdersListingSubscriptionEvent.start(
          input: WatchOrdersInput(
            where: OrderWhereComplex(
              makerIn: user.wallets,
              takerExists: true,
            ),
            sort: OrderSort(
              by: OrderSortBy.createdAt,
              direction: SortDirection.DESC,
            ),
            limit: 50,
          ),
        )),
      child: _ProfileNftCollectedList(),
    );
  }
}

class _ProfileNftCollectedList extends StatefulWidget {
  const _ProfileNftCollectedList();

  @override
  State<_ProfileNftCollectedList> createState() => _ProfileNftCreatedListViewState();
}

class _ProfileNftCreatedListViewState extends State<_ProfileNftCollectedList> {
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
                if(orders.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(t.nft.emptyCreatedNfts)),
                  );
                }
                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: Spacing.xSmall,
                    mainAxisSpacing: Spacing.xSmall,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final order = orders[index];
                      return ProfileNftItem(nftToken: dartz.Right(order.token));
                    },
                    childCount: orders.length,
                  ),
                );
              });
        },
      ),
    );
  }
}
