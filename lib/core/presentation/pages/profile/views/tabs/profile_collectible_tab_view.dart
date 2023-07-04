import 'package:app/core/presentation/pages/profile/views/tabs/base_sliver_tab_view.dart';
import 'package:app/core/presentation/widgets/hero_image_viewer_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_chip_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileCollectibleTabView extends StatelessWidget {
  const ProfileCollectibleTabView({super.key});

  double get _filterBarHeight => 72;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BaseSliverTabView(
      name: "collectible",
      children: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          sliver: SliverAppBar(
            pinned: true,
            collapsedHeight: _filterBarHeight,
            expandedHeight: _filterBarHeight,
            flexibleSpace: Container(
              color: colorScheme.primary,
              child: Column(
                children:[
                    SizedBox(height: Spacing.smMedium),
                   Row(
                  children: [
                    LemonChip(label: t.nft.onSale),
                    SizedBox(width: Spacing.superExtraSmall),
                    LemonChip(label: t.nft.created, isActive: true),
                    SizedBox(width: Spacing.superExtraSmall),
                    LemonChip(label: t.nft.collected),
                    SizedBox(width: Spacing.superExtraSmall),
                    LemonChip(label: t.nft.sold),
                  ],
                ),
                SizedBox(height: Spacing.smMedium),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: Spacing.xSmall,
              mainAxisSpacing: Spacing.xSmall,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return HeroImageViewer(
                  tag: images[index],
                  imageUrl: images[index],
                  child: _CollectibleItem(
                    imageUrl: images[index],
                  ),
                );
              },
              childCount: images.length,
            ),
          ),
        )
      ],
    );
  }
}

class _CollectibleItem extends StatelessWidget {
  final String imageUrl;
  const _CollectibleItem({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outline),
          borderRadius: BorderRadius.circular(LemonRadius.small),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(LemonRadius.small),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            errorWidget: (ctx, _, __) => ImagePlaceholder.eventCard(),
          ),
        ));
  }
}

final images = [
  'https://images.unsplash.com/photo-1647891938250-954addeb9c51?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxzZWFyY2h8OHx8bmF0dXJlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1679678691006-0ad24fecb769?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxzZWFyY2h8MjJ8fG5hdHVyZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1662010021854-e67c538ea7a9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxzZWFyY2h8MXx8Y2FyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2F0fGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1616394158624-a2ba9cfe2994?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8aG9uZyUyMGtvbmd8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1674574124976-a56d9052c2f8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxNnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
  'https://plus.unsplash.com/premium_photo-1673548917477-4c0c8889b439?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1687368438644-3ba4c870a26c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0Mnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1661956600655-e772b2b97db4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw1MXx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1685369018466-5daddafa8146?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2N3x8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'
];
