import 'package:app/core/data/space/dtos/space_dto.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/pages/space/spaces_listing_page/widgets/space_list_item.dart';
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
              child: SizedBox(height: Spacing.xSmall),
            ),
            if (spaces.isEmpty)
              SliverList.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: Spacing.xSmall);
                },
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(Spacing.small),
                    width: double.infinity,
                    height: 91,
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
                      children: [0.3.sw, 0.8.sw, 0.8.sw]
                          .asMap()
                          .map((index, width) {
                            return MapEntry(
                              index,
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: index == 0
                                      ? Spacing.xSmall
                                      : Spacing.extraSmall,
                                ),
                                height: Spacing.extraSmall,
                                width: width.toDouble(),
                                child: Shimmer.fromColors(
                                  baseColor: colorScheme.surfaceVariant,
                                  highlightColor: colorScheme.surface,
                                  child: Container(
                                    color: colorScheme.background,
                                  ),
                                ),
                              ),
                            );
                          })
                          .values
                          .toList(),
                    ),
                  );
                },
              ),
            if (spaces.isNotEmpty)
              SliverList.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: Spacing.xSmall);
                },
                itemCount: spaces.length,
                itemBuilder: (context, index) {
                  final space = spaces[index];
                  return SpaceListItem(
                    space: space,
                    onTap: () {
                      if (space.id != null) {
                        AutoRouter.of(context).navigate(
                          SpaceDetailRoute(
                            spaceId: space.id!,
                          ),
                        );
                      }
                    },
                    featured: true,
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
