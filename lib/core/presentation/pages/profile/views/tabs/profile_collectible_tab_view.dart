import 'package:app/core/domain/token/token_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/profile/views/list/profile_nft_collected_list_view.dart';
import 'package:app/core/presentation/pages/profile/views/list/profile_nft_created_list_view.dart';
import 'package:app/core/presentation/pages/profile/views/list/profile_nft_on_sale_list_view.dart';
import 'package:app/core/presentation/pages/profile/views/list/profile_nft_sold_list_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/base_sliver_tab_view.dart';
import 'package:app/core/presentation/widgets/lemon_chip_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class ProfileCollectibleTabView extends StatefulWidget {
  final User user;
  const ProfileCollectibleTabView({
    super.key,
    required this.user,
  });

  @override
  State<ProfileCollectibleTabView> createState() => _ProfileCollectibleTabViewState();
}

class _ProfileCollectibleTabViewState extends State<ProfileCollectibleTabView> {
  double get _filterBarHeight => 72;
  TokensListingType tokensListingType = TokensListingType.created;

  _selectTokenListingType(TokensListingType _type) {
    setState(() {
      tokensListingType = _type;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BaseSliverTabView(
      name: "collectible",
      children: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          sliver: SliverAppBar(
            pinned: true,
            leading: SizedBox.shrink(),
            collapsedHeight: _filterBarHeight,
            expandedHeight: _filterBarHeight,
            flexibleSpace: GestureDetector(
              onTap: () {},
              child: Container(
                color: colorScheme.primary,
                child: Column(
                  children: [
                    SizedBox(height: Spacing.smMedium),
                    Row(
                      children: TokensListingType.values.map((item) {
                        return Container(
                          margin: EdgeInsets.only(right: Spacing.superExtraSmall),
                          child: LemonChip(
                            onTap: () => _selectTokenListingType(item),
                            label: t['nft.${item.name}'],
                            isActive: tokensListingType == item,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: Spacing.smMedium),
                  ],
                ),
              ),
            ),
          ),
        ),
        if(tokensListingType == TokensListingType.onSale) ProfileNftOnSaleListView(user: widget.user),
        if(tokensListingType == TokensListingType.created) ProfileNftCreatedListView(user: widget.user),
        if(tokensListingType == TokensListingType.collected) ProfileNftCollectedListView(user: widget.user),
        if(tokensListingType == TokensListingType.sold) ProfileNftSoldListView(user: widget.user),
        SliverToBoxAdapter(
          child: SizedBox(height: 92),
        )
      ],
    );
  }
}