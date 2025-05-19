import 'dart:ui';

import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/data/space/dtos/space_dto.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/widgets/shimmer/shimmer.dart';
import 'package:app/graphql/backend/space/space.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:flutter/rendering.dart';

class DiscoverFeaturedSpacesView extends StatelessWidget {
  const DiscoverFeaturedSpacesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final appTextTheme = Theme.of(context).appTextTheme;
    final colorScheme = Theme.of(context).colorScheme;
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
                style: appTextTheme.lg.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 14.w),
            ),
            if (spaces.isEmpty) _buildLoadingGrid(colorScheme),
            if (spaces.isNotEmpty)
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Spacing.xSmall,
                  crossAxisSpacing: Spacing.xSmall,
                  childAspectRatio:
                      1.0, // Changed to 1.0 for square aspect ratio
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final space = spaces[index];
                    return GestureDetector(
                      onTap: () {
                        if (space.id != null) {
                          AutoRouter.of(context).navigate(
                            SpaceDetailRoute(
                              spaceId: space.id!,
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          fit: StackFit.expand,
                          children: [
                            // Base image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.network(
                                space.getSpaceImageUrl(),
                                fit: BoxFit.cover,
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                            // Blur and gradient overlay
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Stack(
                                children: [
                                  ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                      sigmaX: 16.w,
                                      sigmaY: 16.w,
                                    ),
                                    child: ShaderMask(
                                      shaderCallback: (rect) {
                                        return const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black,
                                            Colors.black,
                                            Colors.black,
                                            Colors.black38,
                                            Colors.transparent,
                                          ],
                                          stops: [0.2, 0.4, 0.6, 0.7, 0.85],
                                        ).createShader(rect);
                                      },
                                      blendMode: BlendMode.dstOut,
                                      child: Image.network(
                                        space.getSpaceImageUrl(),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withOpacity(0.3),
                                            ],
                                            stops: const [0.3, 0.9],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.65),
                                              Colors.transparent,
                                            ],
                                            stops: const [0.2, 0.8],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Text content
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    space.title ?? '',
                                    style: appTextTheme.sm.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: spaces.length,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildLoadingGrid(ColorScheme colorScheme) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Spacing.xSmall,
        crossAxisSpacing: Spacing.xSmall,
        childAspectRatio: 0.85,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: LemonColor.atomicBlack,
          ),
          child: Shimmer.fromColors(
            baseColor: colorScheme.surfaceVariant,
            highlightColor: colorScheme.surface,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.background,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        ),
        childCount: 4,
      ),
    );
  }
}
