import 'dart:math';

import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/space/query/list_spaces_by_geo_regions.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final List<String> colorPalette = [
  '#6C85EE',
  '#EF7248',
  '#6FB983',
  '#62B5CA',
  '#F5A623',
  '#9B51E0',
  '#D76666',
  '#F5A623',
  '#9B51E0',
  '#D76666',
  '#6C85EE',
  '#EF7248',
  '#6FB983',
  '#62B5CA',
  '#F5A623',
  '#9B51E0',
  '#D76666',
];

class DiscoverSpacesByLocationsView extends StatefulWidget {
  const DiscoverSpacesByLocationsView({
    super.key,
  });

  @override
  State<DiscoverSpacesByLocationsView> createState() =>
      _DiscoverSpacesByLocationsViewState();
}

class _DiscoverSpacesByLocationsViewState
    extends State<DiscoverSpacesByLocationsView> {
  String? selectedRegion;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Query$ListSpacesByGeoRegions$Widget(
      options: Options$Query$ListSpacesByGeoRegions(
        onComplete: (raw, data) {
          setState(() {
            selectedRegion = data?.listGeoRegions.firstOrNull?.$_id;
          });
        },
      ),
      builder: (
        result, {
        refetch,
        fetchMore,
      }) {
        final regions = result.parsedData?.listGeoRegions ?? [];

        return MultiSliver(
          children: [
            SliverToBoxAdapter(
              child: Text(
                t.discover.exploreLocalEvents.toUpperCase(),
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
            SliverToBoxAdapter(
              child: SizedBox(
                height: 38.w,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: regions.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox.shrink();
                  },
                  itemBuilder: (context, index) {
                    final region = regions[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedRegion = region.$_id;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(Spacing.superExtraSmall),
                        decoration: BoxDecoration(
                          color: selectedRegion == region.$_id
                              ? LemonColor.atomicBlack
                              : Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(LemonRadius.xSmall),
                        ),
                        child: Center(
                          child: Text(
                            region.title,
                            style: Typo.small.copyWith(
                              color: selectedRegion == region.$_id
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSecondary,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (selectedRegion != null) ...[
              SizedBox(height: Spacing.small),
              SliverGrid.count(
                crossAxisCount: 2,
                childAspectRatio: 170 / 50,
                mainAxisSpacing: Spacing.smMedium,
                crossAxisSpacing: Spacing.smMedium,
                children: regions
                        .firstWhereOrNull(
                          (region) => region.$_id == selectedRegion,
                        )
                        ?.cities
                        .map((city) {
                      final eventsCount = (city.listedEventsCount ?? 0).toInt();
                      final random = Random();
                      final color = Color(
                        int.parse(
                          '0xFF${colorPalette[random.nextInt(colorPalette.length)].substring(1)}',
                        ),
                      );
                      return InkWell(
                        onTap: () {
                          if (city.space.isNotEmpty == true) {
                            AutoRouter.of(context).push(
                              SpaceDetailRoute(
                                spaceId: city.space,
                              ),
                            );
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 42.w,
                              height: 42.w,
                              decoration: ShapeDecoration(
                                color: color,
                                shape: const CircleBorder(),
                              ),
                              child: Center(
                                child: Assets.icons.icLocationPinOutline.svg(),
                              ),
                            ),
                            SizedBox(width: Spacing.small),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    city.name,
                                    style: Typo.mediumPlus.copyWith(
                                      color: colorScheme.onPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 4.w),
                                  Text(
                                    t.event.eventCount(n: eventsCount),
                                    style: Typo.medium.copyWith(
                                      color: colorScheme.onSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList() ??
                    [],
              ),
            ],
          ],
        );
      },
    );
  }
}
