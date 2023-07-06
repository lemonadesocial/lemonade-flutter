import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/base_sliver_tab_view.dart';
import 'package:app/core/presentation/widgets/hero_image_viewer_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePhotosTabView extends StatelessWidget {
  final User user;
  const ProfilePhotosTabView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BaseSliverTabView(
      name: "profile",
      children: [
        SliverToBoxAdapter(
          child: SizedBox(height: 3),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final photoItem = (user.newPhotosExpanded ?? [])[index];
                return HeroImageViewer(
                  tag: photoItem.key ?? '',
                  imageUrl: ImageUtils.generateUrl(file: photoItem),
                  child: Container(
                    child: CachedNetworkImage(
                      imageUrl: ImageUtils.generateUrl(file: photoItem),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              childCount: (user.newPhotosExpanded ?? []).length,
            ),
          ),
        )
      ],
    );
  }
}
