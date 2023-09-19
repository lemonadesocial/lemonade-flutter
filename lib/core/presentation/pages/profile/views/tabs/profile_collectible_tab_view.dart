import 'package:app/core/domain/token/token_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/profile/views/list/profile_nft_collected_list_view.dart';
import 'package:app/core/presentation/pages/profile/views/list/profile_nft_created_list_view.dart';
import 'package:app/core/presentation/pages/profile/views/list/profile_nft_on_sale_list_view.dart';
import 'package:app/core/presentation/pages/profile/views/list/profile_nft_sold_list_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/base_sliver_tab_view.dart';
import 'package:flutter/material.dart';

class ProfileCollectibleTabView extends StatefulWidget {
  final User user;

  const ProfileCollectibleTabView({
    super.key,
    required this.user,
  });

  @override
  State<ProfileCollectibleTabView> createState() =>
      _ProfileCollectibleTabViewState();
}

class _ProfileCollectibleTabViewState extends State<ProfileCollectibleTabView> {
  // double get _filterBarHeight => 72.h;
  TokensListingType tokensListingType = TokensListingType.created;

  @override
  Widget build(BuildContext context) {
    return BaseSliverTabView(
      name: "collectible",
      children: [
        // TODO(Ron): temporary remove this section to match design
        // SliverPadding(
        //   padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
        //   sliver: SliverAppBar(
        //     pinned: true,
        //     leading: const SizedBox.shrink(),
        //     collapsedHeight: _filterBarHeight,
        //     expandedHeight: _filterBarHeight,
        //     flexibleSpace: Container(
        //       color: colorScheme.primary,
        //       child: ListView.separated(
        //         padding: EdgeInsets.symmetric(vertical: Spacing.small),
        //         itemBuilder: (context, index) => LemonChip(
        //           onTap: () => setState(() {
        //             tokensListingType = TokensListingType.values[index];
        //           }),
        //           label: t['nft.${TokensListingType.values[index].name}'],
        //           isActive:
        //               tokensListingType == TokensListingType.values[index],
        //         ),
        //         separatorBuilder: (_, __) =>
        //             SizedBox(width: Spacing.superExtraSmall),
        //         itemCount: TokensListingType.values.length,
        //         scrollDirection: Axis.horizontal,
        //       ),
        //     ),
        //   ),
        // ),
        if (tokensListingType == TokensListingType.onSale)
          ProfileNftOnSaleListView(user: widget.user),
        if (tokensListingType == TokensListingType.created)
          ProfileNftCreatedListView(user: widget.user),
        if (tokensListingType == TokensListingType.collected)
          ProfileNftCollectedListView(user: widget.user),
        if (tokensListingType == TokensListingType.sold)
          ProfileNftSoldListView(user: widget.user),
        const SliverToBoxAdapter(
          child: SizedBox(height: 92),
        )
      ],
    );
  }
}
