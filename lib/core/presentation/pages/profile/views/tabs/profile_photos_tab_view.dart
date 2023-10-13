import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/base_sliver_tab_view.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final userPhotos = user.newPhotosExpanded ?? [];
    final t = Translations.of(context);
    return BaseSliverTabView(
      name: "profile",
      children: [
        const SliverToBoxAdapter(
          child: SizedBox(height: 3),
        ),
        if (userPhotos.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyList(emptyText: t.common.noPhotos),
          ),
        if (userPhotos.isNotEmpty)
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final photoItem = (user.newPhotosExpanded ?? [])[index];
                  return InkWell(
                    onTap: () => context.router.push(
                      PhotosGalleryRoute(
                        initialIndex: index,
                        photos: user.newPhotosExpanded
                                ?.map((e) => ImageUtils.generateUrl(file: e))
                                .toList() ??
                            [],
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: colorScheme.outline),
                        borderRadius:
                            BorderRadius.circular(LemonRadius.extraSmall),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(LemonRadius.extraSmall),
                        child: CachedNetworkImage(
                          imageUrl: ImageUtils.generateUrl(file: photoItem),
                          fit: BoxFit.cover,
                          errorWidget: (ctx, _, __) =>
                              ImagePlaceholder.defaultPlaceholder(),
                          placeholder: (ctx, _) =>
                              ImagePlaceholder.defaultPlaceholder(),
                        ),
                      ),
                    ),
                  );
                },
                childCount: (user.newPhotosExpanded ?? []).length,
              ),
            ),
          ),
      ],
    );
  }
}
