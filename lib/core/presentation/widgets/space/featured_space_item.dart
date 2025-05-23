import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

class FeaturedSpaceItem extends StatelessWidget {
  const FeaturedSpaceItem({
    super.key,
    required this.space,
    this.width,
    this.height,
  });

  final Space space;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: InkWell(
        onTap: () {
          AutoRouter.of(context).push(
            SpaceDetailRoute(
              spaceId: space.id ?? '',
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: context.theme.appColors.cardBorder,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(LemonRadius.md),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(LemonRadius.md),
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
                    fit: BoxFit.cover,
                    width: width ?? double.infinity,
                    height: height ?? double.infinity,
                    placeholder: ImagePlaceholder.dicebearThumbnail(
                      seed: space.id ?? '',
                      size: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  bottom: Spacing.s2,
                  left: Spacing.s3,
                  right: Spacing.s3,
                  child: Text(
                    space.title ?? '',
                    style: context.theme.appTextTheme.sm,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
