import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/data/space/dtos/space_dto.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/graphql/backend/space/space.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

class DiscoverFeaturedSpacesView extends StatelessWidget {
  const DiscoverFeaturedSpacesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).appTextTheme;
    final t = Translations.of(context);

    return Query$ListSpaces$Widget(
      options: Options$Query$ListSpaces(
        variables: Variables$Query$ListSpaces(
          featured: true,
        ),
      ),
      builder: (
        result, {
        refetch,
        fetchMore,
      }) {
        final spaces = (result.parsedData?.listSpaces ?? [])
            .map(
              (e) => Space.fromDto(
                SpaceDto.fromJson(
                  e.toJson(),
                ),
              ),
            )
            .toList();

        return MultiSliver(
          children: [
            SliverToBoxAdapter(
              child: Text(
                t.discover.featuredCommunities,
                style: appTextTheme.lg,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: Spacing.s4),
            ),
            if (spaces.isEmpty)
              const SliverToBoxAdapter(
                child: SizedBox(),
              )
            else if (spaces.isNotEmpty)
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Spacing.s3,
                  crossAxisSpacing: Spacing.s3,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final space = spaces[index];
                    return _FeaturedSpaceItem(space: space);
                  },
                  childCount: spaces.length,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _FeaturedSpaceItem extends StatelessWidget {
  const _FeaturedSpaceItem({
    required this.space,
  });

  final Space space;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(
          SpaceDetailRoute(
            spaceId: space.id ?? '',
          ),
        );
      },
      child: Stack(
        children: [
          SoftEdgeBlur(
            edges: [
              EdgeBlur(
                type: EdgeType.bottomEdge,
                size: 52.w,
                sigma: 50,
                tintColor: context.theme.appColors.pageOverlaySecondary
                    .withOpacity(0.2),
                controlPoints: [
                  ControlPoint(
                    position: 0.5,
                    type: ControlPointType.visible,
                  ),
                  ControlPoint(
                    position: 1,
                    type: ControlPointType.transparent,
                  ),
                ],
              ),
            ],
            child: LemonNetworkImage(
              imageUrl: space.imageAvatar?.url ?? '',
              borderRadius: BorderRadius.circular(
                LemonRadius.md,
              ),
              border: Border.all(
                color: context.theme.appColors.cardBorder,
                width: 1,
              ),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: ImagePlaceholder.dicebearThumbnail(
                seed: space.id ?? '',
                size: double.infinity,
              ),
            ),
          ),
          Positioned(
            bottom: Spacing.s2,
            left: Spacing.s3,
            child: Center(
              child: Text(
                space.title ?? '',
                style: context.theme.appTextTheme.sm,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
