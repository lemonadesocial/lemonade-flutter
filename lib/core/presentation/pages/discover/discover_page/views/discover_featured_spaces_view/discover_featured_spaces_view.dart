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

class DiscoverFeaturedSpacesView extends StatelessWidget {
  const DiscoverFeaturedSpacesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                t.discover.featuredCommunities.toUpperCase(),
                style: Typo.small.copyWith(
                  color: colorScheme.onPrimary,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 14.w),
            ),
            if (spaces.isEmpty)
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Spacing.xSmall,
                  crossAxisSpacing: Spacing.xSmall,
                  childAspectRatio: 1.5,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                      padding: EdgeInsets.all(Spacing.small),
                      decoration: BoxDecoration(
                        color: LemonColor.atomicBlack,
                        borderRadius: BorderRadius.circular(Spacing.small),
                        border: Border.all(
                          color: colorScheme.outline,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Spacing.xSmall),
                            ),
                            child: Shimmer.fromColors(
                              baseColor: colorScheme.surfaceVariant,
                              highlightColor: colorScheme.surface,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorScheme.background,
                                  borderRadius:
                                      BorderRadius.circular(Spacing.xSmall),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Spacing.small),
                          Shimmer.fromColors(
                            baseColor: colorScheme.surfaceVariant,
                            highlightColor: colorScheme.surface,
                            child: Container(
                              height: 20,
                              color: colorScheme.background,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 4,
                ),
              ),
            if (spaces.isNotEmpty)
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Spacing.xSmall,
                  crossAxisSpacing: Spacing.xSmall,
                  childAspectRatio: 1.5,
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
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: LemonColor.atomicBlack,
                          borderRadius: BorderRadius.circular(Spacing.small),
                          border: Border.all(
                            color: colorScheme.outline,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 42.w,
                              width: 42.w,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Spacing.extraSmall),
                                image: DecorationImage(
                                  image: NetworkImage(space.getSpaceImageUrl()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 14.w),
                            Text(
                              space.title ?? '',
                              style: Typo.medium.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
}
