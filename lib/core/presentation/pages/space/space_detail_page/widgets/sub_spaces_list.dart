import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';
import 'package:auto_route/auto_route.dart';

class SubSpacesList extends StatelessWidget {
  const SubSpacesList({
    required this.subSpaces,
    super.key,
  });

  final List<Space> subSpaces;

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: SizedBox(height: Spacing.s5),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
          sliver: SliverGrid.count(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: Spacing.s3,
            crossAxisSpacing: Spacing.s3,
            children:
                subSpaces.map((space) => SubSpaceItem(space: space)).toList(),
          ),
        ),
      ],
    );
  }
}

class SubSpaceItem extends StatelessWidget {
  const SubSpaceItem({
    required this.space,
    super.key,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(LemonRadius.md),
                child: SoftEdgeBlur(
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
        ],
      ),
    );
  }
}
